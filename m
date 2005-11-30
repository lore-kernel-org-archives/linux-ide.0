From: "plink" <plink0025@fmail.co.uk>
Subject: hda and ide errors after acpi s3 resume, ich4-m controller, PIIX driver
Date: Tue, 29 Nov 2005 16:19:03 -0800
Message-ID: <1133309943.4904.248622863@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:24277 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751419AbVK3ATE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Nov 2005 19:19:04 -0500
Received: from frontend1.internal (mysql-sessions.internal [10.202.2.149])
	by frontend1.messagingengine.com (Postfix) with ESMTP id 2BCE7D19839
	for <linux-ide@vger.kernel.org>; Tue, 29 Nov 2005 19:19:03 -0500 (EST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a laptop and i'm having a problem concerning acpi s3 and my ide
driver. basically, after resume from acpi s3, the hard drive is
inaccessible for about a minute and a half. dmesg shows these hda and
ide errors immdediately after a resume from s3:

hda: lost interrupt
evevent-0299: *** Error: No installed handler for fixed event
[00000002]
Restarting tasks... done
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0x50 { DriveReady SeekComplete }
ide: failed opcode was: unknown
hda: status error: status=0x50 { DriveReady SeekComplete }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
hda: status error: status=0x50 { DriveReady SeekComplete }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
hda: lost interrupt
hda: status error: status=0x50 { DriveReady SeekComplete }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
hda: status error: status=0x50 { DriveReady SeekComplete }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
ide0: reset: success

I posted this on the acpi-devel mailing list and was told that it
sounded like a problem with the ide driver and directed to this list. I
have an ich4-m ide controller and i'm using the PIIX ide driver, kernel
2.6.13.4. I'm no expert, but it looks like the acpi resume routine is
trying to wake up the hard drive in a way that the ide isn't compatible
with, and after a few tries just resets the drive. After the reset
everything, the drive is fine, but i'm worried about these errors, isn't
reseting the drive bad for it? hdparm has it marked as dangerous, and it
adds time that i cant do anything after s3 resume. If anybody can help
me, I'd really appreciate it.

-Jaime Kitsmiller

-- 
http://www.fastmail.fm - Faster than the air-speed velocity of an
                          unladen european swallow

