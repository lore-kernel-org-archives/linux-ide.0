From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata: pata_platform: Disable prereset logic.
Date: Wed, 23 May 2007 11:29:37 +0200
Message-ID: <46540981.9080603@gmail.com>
References: <20070523064408.GA29593@linux-sh.org> <4653F62C.4070700@gmail.com> <20070523083026.GA29851@linux-sh.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060408010508000708070509"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:39950 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757432AbXEWJaA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 May 2007 05:30:00 -0400
Received: by nz-out-0506.google.com with SMTP id o37so158612nzf
        for <linux-ide@vger.kernel.org>; Wed, 23 May 2007 02:30:00 -0700 (PDT)
In-Reply-To: <20070523083026.GA29851@linux-sh.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060408010508000708070509
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Paul Mundt wrote:
> On Wed, May 23, 2007 at 10:07:08AM +0200, Tejun Heo wrote:
>> Paul Mundt wrote:
>>> On a number of boards the current prereset logic seems to misbehave:
>>>
>>> scsi0 : pata_platform
>>> ata1: PATA max PIO0 cmd 0xb06001f0 ctl 0xb06003f6 bmdma 0x00000000 irq 0
>>> ata1: device not ready (errno=-19), forcing hardreset
>>> ata1: BUG: prereset() requested invalid reset type
>>>
>>> This triggers when there is no card inserted in the slot.
>>>
>>> Simply disabling the prereset gets rid of this, and doesn't seem to cause
>>> any problems for either PCMCIA or CF cards when they're actually present.
>> NACK.  The BUG printking needs fixing but you can't just kill
>> prereset().  Did it work properly on 2.6.21.1?  Can you modify
>> ata_wait_ready() such that it prints out the status value while waiting?
>>
> ata_wait_ready() works fine, it reports 0xff immediately (and this is
> what I would expect when there is no card inserted).

Does the attached patch fix your problem?

-- 
tejun

--------------060408010508000708070509
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a6de57e..79f2175 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3368,7 +3368,7 @@ int ata_std_prereset(struct ata_port *ap
 	 */
 	if (!(ap->flags & ATA_FLAG_SKIP_D2H_BSY) && !ata_port_offline(ap)) {
 		rc = ata_wait_ready(ap, deadline);
-		if (rc) {
+		if (rc && rc != -ENODEV) {
 			ata_port_printk(ap, KERN_WARNING, "device not ready "
 					"(errno=%d), forcing hardreset\n", rc);
 			ehc->i.action |= ATA_EH_HARDRESET;

--------------060408010508000708070509--
