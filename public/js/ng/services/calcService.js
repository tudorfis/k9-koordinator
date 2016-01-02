
/**
 * Calculation service
 */
var calcService = function(api, cFunc) {

	/** procentage tax **/
	this.tax = 7;
	
	/**
	* Calculate tax
	*/
	this.calculateTax = function(item) {
		return ((item / 100) * this.tax); 
	}
}
