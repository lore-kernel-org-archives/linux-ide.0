From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: [PATCH] libata-dev-2.6: pdc2027x timing register fix for 100MHz adapters
Date: Wed, 2 Feb 2005 17:01:24 +0800
Message-ID: <003f01c50905$c8090d10$6401a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_003C_01C50948.D3E4A700"
Received: from bluehawaii.tikira.net ([61.62.22.51]:60396 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262201AbVBBJCD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Feb 2005 04:02:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.

------=_NextPart_000_003C_01C50948.D3E4A700
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit

Hi Jeff,

  I did not get the pdc2027x timing registers right for the 100 MHz adapters.
For the 100MHz adapters, the hardware will automatically set the timing registers to the correct value.
No need to set the timing register by software table lookup.
(The values in the lookup table are for 133Mhz adapters, which are incorrect for 100MHz adapters.)

  Attached please find the patch against the libata-dev-2.6 tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
----------------------------------------------------------------------------------------------
--- libata-dev-2.6/drivers/scsi/pata_pdc2027x.c 2005-02-02 16:08:39.000000000 +0800
+++ libata-dev-2.6-mod/drivers/scsi/pata_pdc2027x.c 2005-02-02 16:17:26.000000000 +0800
@@ -29,7 +29,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME "pata_pdc2027x"
-#define DRV_VERSION "0.55"
+#define DRV_VERSION "0.56"
 #undef PDC_DEBUG
 
 #ifdef PDC_DEBUG
@@ -130,7 +130,32 @@
  .bios_param  = ata_std_bios_param,
 };
 
-static struct ata_port_operations pdc2027x_pata_ops = {
+static struct ata_port_operations pdc2027x_pata100_ops = {
+ .port_disable  = ata_port_disable,
+
+ .tf_load  = ata_tf_load,
+ .tf_read  = ata_tf_read,
+ .check_status  = ata_check_status,
+ .exec_command  = ata_exec_command,
+ .dev_select  = ata_std_dev_select,
+
+ .phy_reset  = pdc2027x_phy_reset,   
+
+ .check_atapi_dma = pdc2027x_check_atapi_dma,
+ .bmdma_setup  = ata_bmdma_setup,
+ .bmdma_start  = ata_bmdma_start,
+ .qc_prep  = ata_qc_prep,
+ .qc_issue  = ata_qc_issue_prot,
+ .eng_timeout  = ata_eng_timeout,
+
+ .irq_handler  = ata_interrupt,
+ .irq_clear  = ata_bmdma_irq_clear,
+
+ .port_start  = ata_port_start,
+ .port_stop  = ata_port_stop,
+};
+
+static struct ata_port_operations pdc2027x_pata133_ops = {
  .port_disable  = ata_port_disable,
  .set_piomode  = pdc2027x_set_piomode,   
  .set_dmamode  = pdc2027x_set_dmamode,  
@@ -167,7 +192,7 @@
   .pio_mask = 0x1f, /* pio0-4 */
   .mwdma_mask = 0x07, /* mwdma0-2 */
   .udma_mask = ATA_UDMA5, /* udma0-5 */
-  .port_ops = &pdc2027x_pata_ops,
+  .port_ops = &pdc2027x_pata100_ops,
  },
  /* PDC_UDMA_133 */
  {
@@ -177,7 +202,7 @@
   .pio_mask = 0x1f, /* pio0-4 */
   .mwdma_mask = 0x07, /* mwdma0-2 */
   .udma_mask = ATA_UDMA6, /* udma0-6 */
-  .port_ops = &pdc2027x_pata_ops,
+  .port_ops = &pdc2027x_pata133_ops,
  },
 };
 

------=_NextPart_000_003C_01C50948.D3E4A700
Content-Type: application/octet-stream;
	name="pdc2027x_056.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pdc2027x_056.patch"

--- libata-dev-2.6/drivers/scsi/pata_pdc2027x.c	2005-02-02 =
16:08:39.000000000 +0800=0A=
+++ libata-dev-2.6-mod/drivers/scsi/pata_pdc2027x.c	2005-02-02 =
16:17:26.000000000 +0800=0A=
@@ -29,7 +29,7 @@=0A=
 #include <asm/io.h>=0A=
 =0A=
 #define DRV_NAME	"pata_pdc2027x"=0A=
-#define DRV_VERSION	"0.55"=0A=
+#define DRV_VERSION	"0.56"=0A=
 #undef PDC_DEBUG=0A=
 =0A=
 #ifdef PDC_DEBUG=0A=
@@ -130,7 +130,32 @@=0A=
 	.bios_param		=3D ata_std_bios_param,=0A=
 };=0A=
 =0A=
-static struct ata_port_operations pdc2027x_pata_ops =3D {=0A=
+static struct ata_port_operations pdc2027x_pata100_ops =3D {=0A=
+	.port_disable		=3D ata_port_disable,=0A=
+=0A=
+	.tf_load		=3D ata_tf_load,=0A=
+	.tf_read		=3D ata_tf_read,=0A=
+	.check_status		=3D ata_check_status,=0A=
+	.exec_command		=3D ata_exec_command,=0A=
+	.dev_select		=3D ata_std_dev_select,=0A=
+=0A=
+	.phy_reset		=3D pdc2027x_phy_reset,   =0A=
+=0A=
+	.check_atapi_dma	=3D pdc2027x_check_atapi_dma,=0A=
+	.bmdma_setup		=3D ata_bmdma_setup,=0A=
+	.bmdma_start		=3D ata_bmdma_start,=0A=
+	.qc_prep		=3D ata_qc_prep,=0A=
+	.qc_issue		=3D ata_qc_issue_prot,=0A=
+	.eng_timeout		=3D ata_eng_timeout,=0A=
+=0A=
+	.irq_handler		=3D ata_interrupt,=0A=
+	.irq_clear		=3D ata_bmdma_irq_clear,=0A=
+=0A=
+	.port_start		=3D ata_port_start,=0A=
+	.port_stop		=3D ata_port_stop,=0A=
+};=0A=
+=0A=
+static struct ata_port_operations pdc2027x_pata133_ops =3D {=0A=
 	.port_disable		=3D ata_port_disable,=0A=
 	.set_piomode		=3D pdc2027x_set_piomode,   =0A=
 	.set_dmamode		=3D pdc2027x_set_dmamode,  =0A=
@@ -167,7 +192,7 @@=0A=
 		.pio_mask	=3D 0x1f, /* pio0-4 */=0A=
 		.mwdma_mask	=3D 0x07, /* mwdma0-2 */=0A=
 		.udma_mask	=3D ATA_UDMA5, /* udma0-5 */=0A=
-		.port_ops	=3D &pdc2027x_pata_ops,=0A=
+		.port_ops	=3D &pdc2027x_pata100_ops,=0A=
 	},=0A=
 	/* PDC_UDMA_133 */=0A=
 	{=0A=
@@ -177,7 +202,7 @@=0A=
 		.pio_mask	=3D 0x1f, /* pio0-4 */=0A=
 		.mwdma_mask	=3D 0x07, /* mwdma0-2 */=0A=
 		.udma_mask	=3D ATA_UDMA6, /* udma0-6 */=0A=
-		.port_ops	=3D &pdc2027x_pata_ops,=0A=
+		.port_ops	=3D &pdc2027x_pata133_ops,=0A=
 	},=0A=
 };=0A=
 =0A=

------=_NextPart_000_003C_01C50948.D3E4A700--


