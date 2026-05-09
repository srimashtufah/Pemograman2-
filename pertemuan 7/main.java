import java.sql.Connection;
import java.sql.DriverManager;
import java.util.HashMap;
import java.util.Map;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.view.JasperViewer;

public class main {
    public static void main(String[] args) {
        try {
            // 1. Database connection
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/db_inventaris",
                "root",
                ""
            );

            System.out.println("Database connected!");

            // 2. Path to your JRXML file
            String reportPath = "report/LaporanInventaris.jrxml";

            // 3. Compile report
            JasperReport report = JasperCompileManager.compileReport(reportPath);

            // 4. Parameters (optional)
            Map<String, Object> parameters = new HashMap<>();
            // parameters.put("param_name", value);

            // 5. Fill report
            JasperPrint print = JasperFillManager.fillReport(report, parameters, conn);

            // 6. Show report viewer
            JasperViewer.viewReport(print, false);

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}