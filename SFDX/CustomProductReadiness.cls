public class CustomProductReadiness implements Readiness.ProductEvaluator {

    // return true for the rule to run
    public boolean isActive() {
        return true;
    }

    // return a list of Readiness.ProductScoreDetail which will become the product readiness score
    public List<Readiness.ProductScoreDetail> evaluateReadiness(Readiness.ProductEvaluationContext productContext) {
        // example implmentation which checks for a description and a price	
        Set<ID> productIds = productContext.ProductIds;
        List<Readiness.ProductScoreDetail> scores = new List<Readiness.ProductScoreDetail>();

        List<Product2> products = [SELECT 
              id, description
              FROM  Product2
              WHERE 
              id IN : productIds];
        
        for (Product2 product : products) {
            scores.add(new Readiness.ProductScoreDetail(
                product.Id, 
                'Description Length',
                String.isBlank(product.description) ? 0 : 100,
                'Product does not have a Description.'));
            
            List<PricebookEntry> entries = [SELECT id FROM PricebookEntry WHERE Product2Id = :product.Id];
            Integer pricebookScore = (entries.size() == 0) ? 0 : 100;
            scores.add(new Readiness.ProductScoreDetail(
                product.Id, 
                'Price',
                pricebookScore,
                'Product must have a price.')); 
        }

        return scores;
    }
}