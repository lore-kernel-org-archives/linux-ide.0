From: gettinther <gettinther@gmail.com>
Subject: Re: Can you please test the attached patch for nv hardreset problem?
Date: Mon, 13 Oct 2008 20:13:14 +0100
Message-ID: <64630f150810131213m64d8fc72j38debf71a692db16@mail.gmail.com>
References: <48E80F11.3060101@kernel.org>
	 <64630f150810111634gbe4cfdfjccafc9f6f781edcc@mail.gmail.com>
	 <48F30678.7020807@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:9302 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbYJMTNQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 15:13:16 -0400
Received: by yx-out-2324.google.com with SMTP id 8so435352yxm.1
        for <linux-ide@vger.kernel.org>; Mon, 13 Oct 2008 12:13:14 -0700 (PDT)
In-Reply-To: <48F30678.7020807@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, lists@ku-gbr.de, linux@sun7.cn, Robert Hancock <hancockr@shaw.ca>

On Mon, Oct 13, 2008 at 9:27 AM, Tejun Heo <tj@kernel.org> wrote:
> gettinther wrote:
>> OK, patching the 2.6.26 based on your patch doesn't work properly.  It
>> works for sata devices but not sata emulated devices (but these do
>> work with the 2.6.27).
>
> Eh... what do you mean it doesn't work on 2.6.26?  The same change
> doesn't work on 2.6.26 but it does on 2.6.27?  How did you apply the
> change to 2.6.26?  Can you post the diff?
>
> Thanks.
>
> --
> tejun
>

Sorry, replied on the wrong thread

Here's the patch I applied

--- a/drivers/ata/sata_nv.c.old	2008-07-13 22:51:29.000000000 +0100
+++ a/drivers/ata/sata_nv.c	2008-10-10 00:45:14.000000000 +0100
@@ -309,8 +309,6 @@
 static void nv_nf2_thaw(struct ata_port *ap);
 static void nv_ck804_freeze(struct ata_port *ap);
 static void nv_ck804_thaw(struct ata_port *ap);
-static int nv_hardreset(struct ata_link *link, unsigned int *class,
-			unsigned long deadline);
 static int nv_adma_slave_config(struct scsi_device *sdev);
 static int nv_adma_check_atapi_dma(struct ata_queued_cmd *qc);
 static void nv_adma_qc_prep(struct ata_queued_cmd *qc);
@@ -407,7 +405,6 @@

 static struct ata_port_operations nv_generic_ops = {
 	.inherits		= &ata_bmdma_port_ops,
-	.hardreset		= nv_hardreset,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 };
@@ -416,6 +413,7 @@
 	.inherits		= &nv_generic_ops,
 	.freeze			= nv_nf2_freeze,
 	.thaw			= nv_nf2_thaw,
+	.hardreset		= sata_std_hardreset,
 };

 static struct ata_port_operations nv_ck804_ops = {
@@ -1588,21 +1586,6 @@
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
