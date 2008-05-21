From: Tejun Heo <htejun@gmail.com>
Subject: Re: Fwd: confusion about libata.force=80c
Date: Wed, 21 May 2008 14:57:09 +0900
Message-ID: <4833B9B5.7060601@gmail.com>
References: <57947bf80805141120v615ef957g323114637d171f0a@mail.gmail.com> <57947bf80805200222j19efa2d2n7ff89fe026745ba1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:64930 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754940AbYEUF5S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 May 2008 01:57:18 -0400
Received: by py-out-1112.google.com with SMTP id p76so4386pyb.10
        for <linux-ide@vger.kernel.org>; Tue, 20 May 2008 22:57:15 -0700 (PDT)
In-Reply-To: <57947bf80805200222j19efa2d2n7ff89fe026745ba1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Sylla <tsylla@gmail.com>
Cc: linux-ide@vger.kernel.org

Tom Sylla wrote:
> Anyone have a comment? All I am asking for now is if this *should*
> work or not. Is force=80c supposed to do what I want?
> 
> 
> ---------- Forwarded message ----------
> From: Tom Sylla <tsylla@gmail.com>
> Date: Wed, May 14, 2008 at 2:20 PM
> Subject: confusion about libata.force=80c
> To: linux-ide@vger.kernel.org
> 
> 
> I have a platform with a single CompactFlash socket connected to a
> Broadcom HT1000's PATA port. With libata's pata_serverworks, it ends
> up using drive-side 80-conductor cable detection (Broadcom provides no
> cable bits for the BIOS to report what is attached). The
> CompactFlashes I am using mis-report the cable type, and
> pata_serverworks limits to UDMA2. I tried to use the recent addition
> of libata.force, but it does not seem to work like I would expect it
> to. An excerpt from dmesg:
> 
> scsi4 : pata_serverworks
> scsi5 : pata_serverworks
> ata5: PATA max UDMA/66 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
> ata6: PATA max UDMA/66 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
> ata5: FORCE: cable set to 80c
> ata5.00: ATA-4: CF CARD, 20080308, max UDMA/66
> ata5.00: 15662304 sectors, multi 0: LBA
> ata5.00: limited to UDMA/33 due to 40-wire cable
> ata5.00: configured for UDMA/33
> 
> The force parameter is certainly getting accepted, but then 3 lines
> later, it believes it has a 40 conductor cable.
> 
> I have attached the full dmesg. This is vanilla 2.6.25.3 with "options
> libata force=80c" added in the initrd.
> 
> Yes, I know I should just get a more well-behaved device, but both of
> the high-speed (UDMA) CFs I am using mis-report the cable detection. I
> would bet many other high-speed CFs do the same. I have already
> contacted the CF manufacturer to look into it. For now, though, I'd
> like to run UDMA4, and the force parameter seems like it would do what
> I want.
> 
> Is force=80c what I want? Should it work?

It should but is overridden by device side cable detection upto 2.6.25. 
  2.6.26 will have it fixed.  force=udma66 should work.

-- 
tejun
