From: Marcin Kuk <marcin.kuk@gmail.com>
Subject: toshiba ide - ide dma setting
Date: Tue, 8 Feb 2005 20:39:22 +0100
Message-ID: <28d670ae0502081139464d51c@mail.gmail.com>
Reply-To: Marcin Kuk <marcin.kuk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from rproxy.gmail.com ([64.233.170.204]:22700 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261644AbVBHTjX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2005 14:39:23 -0500
Received: by rproxy.gmail.com with SMTP id z35so943345rne
        for <linux-ide@vger.kernel.org>; Tue, 08 Feb 2005 11:39:22 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi.

I have a problem to allow DMA setting to my harddisk.
I have Toshiba Satellite 320CDT laptop.

I found this question in letter's archive:
http://search.luky.org/linux-kernel.2003/msg35013.html

And the answer:
http://www.ussg.iu.edu/hypermail/linux/kernel/0306.0/0308.html

This is part of my dmesg from 2.4.26 kernel:
.........
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: TOSHIBA MK4006MAV, ATA DISK drive
hdc: CD-220EA, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 8007552 sectors (4100 MB), CHS=7944/16/63
hdc: attached ide-cdrom driver.
hdc: ATAPI 20X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: [PTBL] [993/128/63] hda1 hda2 hda3 hda4
............

I know that is problem with bridge used for ide handle.
I tried a lot of kernels:
> 2.4.26 and 2.6.10 series.
Please tell me with patch will solve my problem for 2.6.10 kernel or
what can I do for enabling DMA?

Another question:
In my bios I can choose two variant for my IDE:
* Standard IDE
* Enhanced IDE
Which should I choose?
I tried both and I dont's see any difference.

Sorry if my english is poor.

Regards

Marcin Kuk
