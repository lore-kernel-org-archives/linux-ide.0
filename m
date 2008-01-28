From: "Thomas Evans" <evans02472@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Mon, 28 Jan 2008 01:51:28 -0500
Message-ID: <864c1e490801272251j300f8010if7bdfc967bee3293@mail.gmail.com>
References: <4794459C.3090200@gmail.com> <4798CC90.4040707@gmail.com>
	 <4798CCDF.9070305@gmail.com> <4798CE10.2050005@gmail.com>
	 <4798D4A2.7030303@gmail.com> <47991AD9.6050804@gmail.com>
	 <47993686.5040405@gmail.com> <479939E3.4020307@gmail.com>
	 <479D0AB5.6070203@gmail.com> <479D256C.1090507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:55914 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbYA1Gv3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jan 2008 01:51:29 -0500
Received: by py-out-1112.google.com with SMTP id u52so2264429pyb.10
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 22:51:28 -0800 (PST)
In-Reply-To: <479D256C.1090507@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

I hate blasting the the list with every minute detail.

On 1/27/08, Tejun Heo <htejun@gmail.com> wrote:
> Hmmm... That's strange.  If PERR makes a difference, it means PCI bus
> side is contributing to the problem but only when PMP is attached while
> directly attached drive works just fine?

I need to get a esata to sata cable - i returned all my duplicate equipment,
so i haven't a 3124 with internal sata ports.  I will try soon.

> Thanks but I'm as lost as you are.  :-(

I backed out my printk's - I must have change the flow somehow.
With only bit 28 set (ignore PERRs) I see:

ata1: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa0000 irq 31
ata2: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa2000 irq 31
ata3: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa4000 irq 31
ata4: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa6000 irq 31
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
ata1.00: hard resetting link
ata1.00: SATA link down (SStatus 0 SControl 10)
ata1.01: hard resetting link
ata1.01: SATA link down (SStatus 0 SControl 4000320)
ata1.02: hard resetting link
ata1.02: SATA link down (SStatus 0 SControl 4000320)
ata1.03: hard resetting link
ata1.03: SATA link down (SStatus 0 SControl 4000320)
ata1.04: hard resetting link
ata1.04: SATA link down (SStatus 0 SControl 4000320)
ata1.05: hard resetting link
ata1.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.06: hard resetting link
ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 4000320)
ata1.05: failed to IDENTIFY (I/O error, err_mask=0x20)
ata1.15: hard resetting link
ata1: controller in dubious state, performing PORT_RST
ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)

I'm not sure why there are PCI parity errors - I went so far as to
turn off pci parity from the alpha SRM console.  (it used to work fine
with it on).  This hasn't made much diffence above, except that the
err_mask=0x21 when pci parity is on...?

I'll try a non-PMP connected drive hopefully tommorow evening.

Thanks,

...tom
