var app = angular.module("phmsApp", []);

app.controller("createUserController", function($scope, $http) {  
    $scope.createUser = function() {
        //console.log($scope.userId);
        //console.log($scope.password);
        if($scope.firstname && $scope.lastname && $scope.userId && $scope.password && $scope.dob
        	&& $scope.gender && $scope.street && $scope.city && $scope.state && $scope.country 
        	&& $scope.zip && $scope.firstname !== "" && $scope.lastname !== "" 
        	&& $scope.userId !== "" && $scope.password !== "" 
        	&& $scope.password === $scope.rep_password) {
        $http({
	            url : './createUser',
	            method : "POST",
	            data : {
	                'firstname' : $scope.firstname,
	                'lastname' : $scope.lastname,
	                'userId' : $scope.userId,
	                'password' : $scope.password
	            }
	        }).then(function(response) {
	            console.log(response.data);
	        }, function(response) { 
	            console.log(response);
	        });
	    }
	    else {
	    	$scope.message = "Password does not match."
	    }
    };
    $scope.isUserTypeSelected = function() {
    	return ($scope.patient || $scope.healthSupporter);
    };
});