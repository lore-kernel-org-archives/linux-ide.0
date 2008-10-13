From: gettinther <gettinther@gmail.com>
Subject: Re: sata dvdroms fails to be recognized by MCP55 controller with the 2.6.26.5 kernel
Date: Mon, 13 Oct 2008 20:11:34 +0100
Message-ID: <64630f150810131211s2e0d7759k41b0156013cb35dd@mail.gmail.com>
References: <64630f150809291601w3511febdyc769b8871db75602@mail.gmail.com>
	 <20080930170849.52c00228.akpm@linux-foundation.org>
	 <48E2E8A1.8090204@gmail.com>
	 <64630f150810010131g18c1a00m91b3f68ea29a1067@mail.gmail.com>
	 <64630f150810011601y4e729decq24c614f0b7994f3f@mail.gmail.com>
	 <48E71ACE.4000505@gmail.com> <48E71AEC.8020701@gmail.com>
	 <64630f150810060208q22b61900xd7487500eac4e145@mail.gmail.com>
	 <48EAB71B.1050002@gmail.com>
	 <64630f150810100207g312088ep67c00ca15929091d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:59801 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609AbYJMTLg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 15:11:36 -0400
Received: by an-out-0708.google.com with SMTP id d40so141097and.103
        for <linux-ide@vger.kernel.org>; Mon, 13 Oct 2008 12:11:34 -0700 (PDT)
In-Reply-To: <64630f150810100207g312088ep67c00ca15929091d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Fri, Oct 10, 2008 at 10:07 AM, gettinther <gettinther@gmail.com> wrote:
> On Tue, Oct 7, 2008 at 2:10 AM, Tejun Heo <htejun@gmail.com> wrote:
>> gettinther wrote:
>>> I have tested the patch you sent me and it solves the issue with the
>>> sata dvdrom detection with the 2.6.27.rc8.  The issue is still present
>>> on the 2.6.26.5 kernel.  Are you backporting the solution to that
>>> kernel?
>>
>> It seems nf2/3 still have issues.  Once nf2/3 are cleared, I'll
>> forward the patch to -stable.
>>
>> Thanks.
>>
>> --
>> tejun
>>
>
> Tejun,
>
> I applied your patch to the 2.6.26 tree (slightly modified to suit)
> and it also fixes the issue there.
> I can post the patch this evening if you want to.
>
> Thank you again,
>
> Cyrille
>

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
