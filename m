From: "Oliver Korpilla" <Oliver.Korpilla@gmx.de>
Subject: [SATA] SATA_SIL and ATI SB400 chipset
Date: Sun, 6 Mar 2005 10:35:27 +0100 (MET)
Message-ID: <25661.1110101727@www58.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received: from mail.gmx.net ([213.165.64.20]:32701 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261285AbVCFJf3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Mar 2005 04:35:29 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hello!

I'm sorry to bug you like this, but I have a problem I hope you can help me
find about your SATA_SIL driver.

I have a brandnew computer for a project and its components aren't even
listed with names in lspci. AMD64 3500+, MSI RS480M2 with ATI RS480+SB400
controllers, 2GB 2.5 Dual DDR400 3200 RAM, Seagate 250 GB SATA drive with
NCQ, ... I guess you get it's rather new (we were allowed to spend a state
grant on it, so it isn't mine, I'm just building/configuring it for my
office).

The Debian AMD64 port netinstall doesn't recognize the disk, even if in IDE
controller mode in the BIOS and even when the SATA_SIL is modprobed into the
kernel.

But I've hooked a IDE-ATA harddrive with a Sarge install for i386 to it,
compiled a kernel 2.6.11 for it, and loaded your SATA_SIL driver for it,
which probed the device and allowed me to use it. It's working perfectly as
my 1st SCSI drive this way, and I compiled your driver into my kernel and it
boots perfectly from SATA.

Problem is, I want to do an install from the Sarge netinstall media to get a
full AMD64-compatible install. If I load the SATA_SIL module there, no
probing happens and my SATA drive isn't recognized, even if I modprobe the
module on the shell.

Problem seems to be that the simplified busybox version or something similar
of modprobe is used, which doesn't match modprobe's behaviour. But I guess
by giving the right parameters on loading your module I could force it into
being loaded correctly, with the same parameters it recognizes the hardware
when booted with kernel 2.6.11.

Do you agree?

Do you think, I could force your module into recognizing the hardware with
module parameters??

It would be very kind of you to help me out on this and I'd be very
grateful, especially since it works already so fine with 2.6.11 hack. But I
have several of this boxes to install, and I want them to run x86-64 native,
not i386 from another box' harddrive...

I'm not on the list, so could you CC: me if you answer.

Thanks and with kind regards,
Oliver Korpilla

-- 
SMS bei wichtigen e-mails und Ihre Gedanken sind frei ...
Alle Infos zur SMS-Benachrichtigung: http://www.gmx.net/de/go/sms
