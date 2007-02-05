From: Robert Hancock <hancockr@shaw.ca>
Subject: [PATCH -mm] sata_nv: propagate ata_pci_device_do_resume return value
Date: Sun, 04 Feb 2007 23:18:32 -0600
Message-ID: <45C6BE28.9070205@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752711AbXBEFTP@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

ata_pci_device_do_resume can fail if the PCI device couldn't be re-enabled.
Update sata_nv to propagate the return value from this call and to
not try to do any other resume activities if it fails. Fixes a compile
warning.

Signed-off-by: Robert Hancock <hancockr@shaw.ca>

--- linux-2.6.20-rc6-mm3edit/drivers/ata/sata_nv.c.beforeresumechange	2007-02-04 22:18:49.000000000 -0600
+++ linux-2.6.20-rc6-mm3edit/drivers/ata/sata_nv.c	2007-02-04 22:20:06.000000000 -0600
@@ -1604,8 +1604,11 @@ static int nv_pci_device_resume(struct p
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
 	struct nv_host_priv *hpriv = host->private_data;
+	int rc;
 
-	ata_pci_device_do_resume(pdev);
+	rc = ata_pci_device_do_resume(pdev);
+	if(rc)
+		return rc;
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
 		if(hpriv->type >= CK804) {
