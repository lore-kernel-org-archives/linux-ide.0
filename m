From: gettinther <gettinther@gmail.com>
Subject: Re: sata dvdroms fails to be recognized by MCP55 controller with the 2.6.26.5 kernel
Date: Mon, 6 Oct 2008 10:08:30 +0100
Message-ID: <64630f150810060208q22b61900xd7487500eac4e145@mail.gmail.com>
References: <64630f150809291601w3511febdyc769b8871db75602@mail.gmail.com>
	 <20080930170849.52c00228.akpm@linux-foundation.org>
	 <48E2E8A1.8090204@gmail.com>
	 <64630f150810010131g18c1a00m91b3f68ea29a1067@mail.gmail.com>
	 <64630f150810011601y4e729decq24c614f0b7994f3f@mail.gmail.com>
	 <48E71ACE.4000505@gmail.com> <48E71AEC.8020701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:42803 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbYJFJIc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Oct 2008 05:08:32 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1233163wri.5
        for <linux-ide@vger.kernel.org>; Mon, 06 Oct 2008 02:08:31 -0700 (PDT)
In-Reply-To: <48E71AEC.8020701@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Sat, Oct 4, 2008 at 8:27 AM, Tejun Heo <htejun@gmail.com> wrote:
> (restoring lkml and linux-ide.  please don't drop cc list)
>
> Tejun Heo wrote:
>> Hello,
>>
>> gettinther wrote:
>>> 00:05.2 IDE interface: GeForce 8800 GT 512 MCP55 SATA Controller (rev
>>> a2) (prog-if 85 [Master SecO PriO])
>>
>> Ah.. okay.  MCP55.  I've missed that part in the first message.
>> sata_nv is a bit messed up for 2.6.26.  What happened was...
>>
>> * During 2.6.26-rc, libata switched to prefer hardreset over softreset
>>   for various reasons.
>>
>> * After 2.6.26 release, sata_nv generic flavors (MCP55/66) were
>>   reported to have problems probing devices with hardreset.  Hardreset
>>   simply doesn't work.
>>
>> * Patch posted to disable hardreset for generic but it accidentally
>>   disabled hardreset for all flavors (generic/nf2/3/ck804).
>>
>> * Which broke ck804.
>>
>> * Another patch posted to reinstate hardreset for nf2/3 and ck804.
>>
>> * It somehow mysteriously broke nf2/3.  This is still being
>>   investigated.
>>
>> Sorry about the mess but I am puzzled too.  I'll report back when I
>> know more.
>>
>> Thanks.
>>
>
>
> --
> tejun
>

Tejun,

I have tested the patch you sent me and it solves the issue with the
sata dvdrom detection with the 2.6.27.rc8.  The issue is still present
on the 2.6.26.5 kernel.  Are you backporting the solution to that
kernel?

Thank you very much for the fix.

I post below the patch for record.

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 14601dc..ce77619 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -309,8 +309,6 @@ static void nv_nf2_freeze(struct ata_port *ap);
 static void nv_nf2_thaw(struct ata_port *ap);
 static void nv_ck804_freeze(struct ata_port *ap);
 static void nv_ck804_thaw(struct ata_port *ap);
-static int nv_hardreset(struct ata_link *link, unsigned int *class,
-			unsigned long deadline);
 static int nv_adma_slave_config(struct scsi_device *sdev);
 static int nv_adma_check_atapi_dma(struct ata_queued_cmd *qc);
 static void nv_adma_qc_prep(struct ata_queued_cmd *qc);
@@ -405,17 +403,8 @@ static struct scsi_host_template nv_swncq_sht = {
 	.slave_configure	= nv_swncq_slave_config,
 };

-/* OSDL bz3352 reports that some nv controllers can't determine device
- * signature reliably and nv_hardreset is implemented to work around
- * the problem.  This was reported on nf3 and it's unclear whether any
- * other controllers are affected.  However, the workaround has been
- * applied to all variants and there isn't much to gain by trying to
- * find out exactly which ones are affected at this point especially
- * because NV has moved over to ahci for newer controllers.
- */
 static struct ata_port_operations nv_common_ops = {
 	.inherits		= &ata_bmdma_port_ops,
-	.hardreset		= nv_hardreset,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 };
@@ -429,12 +418,17 @@ static struct ata_port_operations nv_generic_ops = {
 	.hardreset		= ATA_OP_NULL,
 };

+/* OSDL bz3352 reports that nf2/3 controllers can't determine device
+ * signature reliably.  Use sata_std_hardreset().
+ */
 static struct ata_port_operations nv_nf2_ops = {
 	.inherits		= &nv_common_ops,
 	.freeze			= nv_nf2_freeze,
 	.thaw			= nv_nf2_thaw,
+	.hardreset		= sata_std_hardreset,
 };

+/* CK804 finally gets hardreset right */
 static struct ata_port_operations nv_ck804_ops = {
 	.inherits		= &nv_common_ops,
 	.freeze			= nv_ck804_freeze,
@@ -443,7 +437,7 @@ static struct ata_port_operations nv_ck804_ops = {
 };

 static struct ata_port_operations nv_adma_ops = {
-	.inherits		= &nv_common_ops,
+	.inherits		= &nv_ck804_ops,

 	.check_atapi_dma	= nv_adma_check_atapi_dma,
 	.sff_tf_read		= nv_adma_tf_read,
@@ -467,7 +461,7 @@ static struct ata_port_operations nv_adma_ops = {
 };

 static struct ata_port_operations nv_swncq_ops = {
-	.inherits		= &nv_common_ops,
+	.inherits		= &nv_generic_ops,

 	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= nv_swncq_qc_prep,
@@ -1605,21 +1599,6 @@ static void nv_mcp55_thaw(struct ata_port *ap)
 	ata_sff_thaw(ap);
 }

-static int nv_hardreset(struct ata_link *link, unsigned int *class,
-			unsigned long deadline)
-{
-	int rc;
-
-	/* SATA hardreset fails to retrieve proper device signature on
-	 * some controllers.  Request follow up SRST.  For more info,
-	 * see http://bugzilla.kernel.org/show_bug.cgi?id=3352
-	 */
-	rc = sata_sff_hardreset(link, class, deadline);
-	if (rc)
-		return rc;
-	return -EAGAIN;
-}
-
 static void nv_adma_error_handler(struct ata_port *ap)
 {
 	struct nv_adma_port_priv *pp = ap->private_data;
