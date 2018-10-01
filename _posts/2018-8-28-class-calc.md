---
layout: post
title: "Class Calculator"
author: "Paul Beaudet"
categories: projects
tags: [makerspace]
image: makerspace.jpg
---

<script type="text/javascript">
var calc = {
    cost: function(desiredIncome, consumablesPerStudent, startup, studentsPerClass, preCommitedClasses){
        preCommitedClasses = preCommitedClasses ? preCommitedClasses : 1; // theres always at least one class to commit to
        var deferredStartupRate = 0;                                      // given no start up cost, cost is zero
        if(startup){
            deferredStartupRate = startup / studentsPerClass / preCommitedClasses;
        } // deffered startup cost over time based on classes teacher is willing to commit to
        var materialsPerClass = (deferredStartupRate + consumablesPerStudent) * studentsPerClass;
        var totalIncome = desiredIncome * 2;                              // assuming 50/50 cut when non members sign up
        var totalClassCost = totalIncome + materialsPerClass;
        var costPerStudent = totalClassCost / studentsPerClass;
        console.log('cost per student minus start: $' + totalIncome / studentsPerClass + consumablesPerStudent);
        return costPerStudent;
    },
    eventbrite: function(costPerStudent){
        var percent = costPerStudent * 0.06;
        return costPerStudent + percent + 1.59;
    },
    submitAction: function(){
        var desiredIncome         = document.getElementById('desiredIncome').value;
        var consumablesPerStudent = document.getElementById('consumablesPerStudent').value;
        var startupCost           = document.getElementById('startup').value;
        var maxStudentsPerClass   = document.getElementById('maxStudentsPerClass').value;
        var minStudentsPerClass   = document.getElementById('minStudentsPerClass').value;
        var preCommitedClasses    = document.getElementById("preCommitedClasses").value;

        var costPerStudent = calc.cost(desiredIncome, consumablesPerStudent, startupCost, minStudentsPerClass, preCommitedClasses);
        var discountAmount = costPerStudent * 0.25;
        var costPerMember = costPerStudent - discountAmount;
        document.getElementById('memberCost').innerHTML = costPerMember.toFixed(2);
        document.getElementById('ebCostMember').innerHTML = calc.eventbrite(costPerMember).toFixed(2);
        document.getElementById('studentCost').innerHTML = costPerStudent.toFixed(2);
        document.getElementById('ebCost').innerHTML = calc.eventbrite(costPerStudent).toFixed(2);

        var OPcostPerStudent = calc.cost(desiredIncome, consumablesPerStudent, startupCost, maxStudentsPerClass, preCommitedClasses);
        var OPdiscountAmount = OPcostPerStudent * 0.25;
        var OPcostPerMember = OPcostPerStudent - OPdiscountAmount;

        document.getElementById('OPmemberCost').innerHTML = OPcostPerMember.toFixed(2);
        document.getElementById('OPebCostMember').innerHTML = calc.eventbrite(OPcostPerMember).toFixed(2);
        document.getElementById('OPstudentCost').innerHTML = OPcostPerStudent.toFixed(2);
        document.getElementById('OPebCost').innerHTML = calc.eventbrite(OPcostPerStudent).toFixed(2);
    }
};
</script>

<h2>Calculate Class Cost</h2>
<p> This tool has floating point math issues still, just put in a fraction if you get weird numbers</p>

Desired Income per class (Teacher or any potential teacher in future)<br>
<input id="desiredIncome" type="number" value=65>
<br><br>
How much will materials cost per student?<br>
<input id="consumablesPerStudent" type="number" value=0>
<br><br>
What is the cost of tools that need to be aquired to run the class?<br>
<input id="startup" type="number"value=0>
<br><br>
What is the student compacity given our tools, space, and parking<br>
<input id="maxStudentsPerClass" type="number" value=6>
<br><br>
What is the minimal amount of students this class needs to run<br>
<input id="minStudentsPerClass" type="number" value=3>
<br><br>
How many classes does the teacher want to commit to hold? (important if there is startup cost)<br>
<input id="preCommitedClasses" type="number" value=1>
<br><br>

<button onclick="calc.submitAction()">Submit</button>

<h2>Minimal price per student</h2>
<p><i>(given minimal number of students attend)</i></p>

<p>Cost per member: $<label id="memberCost"></label></p>
<p>Post Eventbrite fee: $<label id="ebCostMember"></label></p>
<p>Cost per student: $<label id="studentCost"></label></p>
<p>Post Eventbrite fee: $<label id="ebCost"></label></p>

<h2> Optimistic price per student</h2>
<p><i>(if class is filled)</i></p>

<p>Cost per member: $<label id="OPmemberCost"></label></p>
<p>Post Eventbrite fee: $<label id="OPebCostMember"></label></p>
<p>Cost per student: $<label id="OPstudentCost"></label></p>
<p>Post Eventbrite fee: $<label id="OPebCost"></label></p>