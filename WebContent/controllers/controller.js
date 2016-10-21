var app = angular.module("phmsApp", []);
app.controller("loginController", function($scope, $http) {  
    $scope.login = function() {
    	if($scope.userId !== "" && $scope.password !== "") {
	        //console.log($scope.userId);
	        //console.log($scope.password);
	        $http({
	            url : './login',
	            method : "POST",
	            data : {
	                'userId' : $scope.userId,
	                'password' : $scope.password
	            }
	        }).then(function(response) {
	            console.log(response.data);
	        }, function(response) { 
	            console.log(response);
	        });
	    }
    };
});

app.controller("createUserController", function($scope, $http) {  
    $scope.createUser = function() {
        console.log($scope.userId);
        console.log($scope.password);
        if($scope.firstname !== "" && $scope.lastname !== "" 
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
});