From: Tejun Heo <tj@kernel.org>
Subject: Re: link resets with SSD on AHCI
Date: Wed, 05 May 2010 12:15:06 +0200
Message-ID: <4BE1452A.6040607@kernel.org>
References: <20100429215935.GA9796@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030003080707090701010408"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37700 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934221Ab0EEKPr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 May 2010 06:15:47 -0400
In-Reply-To: <20100429215935.GA9796@lixom.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

This is a multi-part message in MIME format.
--------------030003080707090701010408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

On 04/29/2010 11:59 PM, Olof Johansson wrote:
> I did notice that ALPM is enabled at boot, and doesn't seem to be
> re-enabled after the error reset. Based on this, I experimented with
> disabling it (just returning -EINVAL in ahci_enable_alpm). That did make
> the problem not happen after a significant test run (overnight vs 4.5
> minutes above).

It could be that libata's ALPM enable sequence isn't liked by the
controller.  libata first resets the link disabling all powersave
transitions, then turn on ALPM then allows powersave transitions.
It's possible that the controller or device somehow gets upset by this
(ie. the device is told to go to powersave mode only to find out that
the host side isn't allowing it).

Does the attached patch make any difference?  Can you please post the
kernel boot log with the patch applied?

Thanks.

-- 
tejun

--------------030003080707090701010408
Content-Type: text/x-patch;
 name="dont-inhibit-ps-on-reset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dont-inhibit-ps-on-reset.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 49cffb6..696be5f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3810,7 +3810,7 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 	 * cleared.
 	 */
 	do {
-		scontrol = (scontrol & 0x0f0) | 0x300;
+		scontrol = (scontrol & 0x0f0)/* | 0x300*/;
 		if ((rc = sata_scr_write(link, SCR_CONTROL, scontrol)))
 			return rc;
 		/*
@@ -3823,9 +3823,9 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 		/* is SControl restored correctly? */
 		if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
 			return rc;
-	} while ((scontrol & 0xf0f) != 0x300 && --tries);
+	} while ((scontrol & 0xf0f) != /*0x300*/0 && --tries);
 
-	if ((scontrol & 0xf0f) != 0x300) {
+	if ((scontrol & 0xf0f) != /*0x300*/0) {
 		ata_link_printk(link, KERN_ERR,
 				"failed to resume link (SControl %X)\n",
 				scontrol);

--------------030003080707090701010408--
