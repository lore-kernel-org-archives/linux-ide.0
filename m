From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil issue on 2.6.22
Date: Thu, 06 Dec 2007 11:10:11 +0900
Message-ID: <47575A03.6040305@gmail.com>
References: <47434526.7010304@verizonbusiness.com> <474CC29E.8020102@gmail.com> <475032AF.6090001@verizonbusiness.com> <4754C15C.1020107@gmail.com> <4756B5B2.1010302@verizonbusiness.com> <4756B6D3.9020307@gmail.com> <4756BA80.1020902@verizonbusiness.com> <4757415C.9010906@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090708010805070908050803"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:36769 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbXLFCKt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 21:10:49 -0500
Received: by rv-out-0910.google.com with SMTP id k20so53402rvb
        for <linux-ide@vger.kernel.org>; Wed, 05 Dec 2007 18:10:45 -0800 (PST)
In-Reply-To: <4757415C.9010906@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mark.paulus@verizonbusiness.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090708010805070908050803
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Mark Paulus wrote:
>> Yes, I am.  It's a SD-ADSAIDE-S1, with a sil3611ct80 chip on board.
>>
>> My question would be, what makes the 2.6.22 kernel different enough
>> than the 2.6.18 kernel that this setup is causing problems in .22.
>> Is .18 masking the problems, or is .22 just looking at things with
>> tighter tolerences, so it's more sensitive?
> 
> That's to be investigated.  There's another report of similar problem.
> Can you please add yourself to the following bugzilla and add your log
> there?
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=9505

In case you don't like bugzilla, I'm attaching proposed patch here too.
 Please test the attached patch and report whether it fixes the problem.

Thanks.

-- 
tejun

--------------090708010805070908050803
Content-Type: text/x-patch;
 name="sata_sil-irq-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata_sil-irq-fix.patch"

Index: work/drivers/ata/sata_sil.c
===================================================================
--- work.orig/drivers/ata/sata_sil.c
+++ work/drivers/ata/sata_sil.c
@@ -390,23 +390,19 @@ static void sil_host_intr(struct ata_por
 		sil_scr_read(ap, SCR_ERROR, &serror);
 		sil_scr_write(ap, SCR_ERROR, serror);
 
-		/* Trigger hotplug and accumulate SError only if the
-		 * port isn't already frozen.  Otherwise, PHY events
-		 * during hardreset makes controllers with broken SIEN
-		 * repeat probing needlessly.
+		/* Sometimes spurious interrupts occur, double check
+		 * it's PHYRDY CHG.
 		 */
-		if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
-			ata_ehi_hotplugged(&ap->link.eh_info);
+		if (serror & SERR_PHYRDY_CHG) {
 			ap->link.eh_info.serror |= serror;
+			goto freeze;
 		}
 
-		goto freeze;
+		if (!(bmdma2 & SIL_DMA_COMPLETE))
+			return;
 	}
 
-	if (unlikely(!qc))
-		goto freeze;
-
-	if (unlikely(qc->tf.flags & ATA_TFLAG_POLLING)) {
+	if (unlikely(!qc || (qc->tf.flags & ATA_TFLAG_POLLING))) {
 		/* this sometimes happens, just clear IRQ */
 		ata_chk_status(ap);
 		return;
Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -3923,6 +3923,7 @@ void ata_std_postreset(struct ata_link *
 	/* clear SError */
 	if (sata_scr_read(link, SCR_ERROR, &serror) == 0)
 		sata_scr_write(link, SCR_ERROR, serror);
+	link->eh_info.serror = 0;
 
 	/* is double-select really necessary? */
 	if (classes[0] != ATA_DEV_NONE)

--------------090708010805070908050803--
