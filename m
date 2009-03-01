From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: 2.6.28.7 boot problems
Date: Sun, 01 Mar 2009 13:22:38 -0600
Message-ID: <49AAE07E.5000806@gmail.com>
References: <40f01080902251346v5f73ed43nacc07bf65c98a727@mail.gmail.com>	 <49A8AB75.9020006@gmail.com> <40f01080902280827taf007cq613609fb42b9b24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.217.174]:55119 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505AbZCATWm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Mar 2009 14:22:42 -0500
Received: by gxk22 with SMTP id 22so4115912gxk.13
        for <linux-ide@vger.kernel.org>; Sun, 01 Mar 2009 11:22:40 -0800 (PST)
In-Reply-To: <40f01080902280827taf007cq613609fb42b9b24@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Schepler <aschepler@gmail.com>
Cc: linux-ide@vger.kernel.org

Andrew Schepler wrote:
> Robert Hancock wrote:
>> Sounds like you don't have the chipset-specific IDE driver enabled for your
>> hardware (I don't see any of them enabled in this list). I think that
>> IDE_GENERIC used to drive the controller in this case, but not anymore, as
>> it can only do so in a crappy, non-DMA way.
> 
> Thanks Robert.
> 
> After more research, I determined my motherboard is a Gigabyte
> Technology GA-K8U-939.  Its docs say it has a ULi M1689 chipset, which
> supports Dual Serial ATA.  So I tried enabling ATA, ATA_SFF, and
> SATA_ULI.  The kernel printed out a couple new lines about sata0 and
> sata1, but didn't find any hd[a-d] or otherwise get any farther.
> 
> Then I tried just turning on as many chipsets as I could (skipping a
> few whose help pages had dangerous-sounding warnings).  Using this
> kernel, the alim15x3 driver (CONFIG_BLK_DEV_ALI15X3) did manage to
> find hda and finish booting.  But I got several messages from the
> kernel looking like:
> 
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown

It looks like you're getting some CRC errors - could be you have a bad 
IDE cable, or some other hardware problem, or (I would guess more 
likely) the driver is picking the wrong UDMA mode or setting up the 
controller improperly in some other way. As I mention below, you'll 
likely want to try the libata driver instead.

> 
> Next I tried out Debian's
> linux-image-2.6.28-1-amd64_2.6.28-1_i386.deb.  It also loaded hda
> using the alim15x3 driver, and gave the same messages as above.
> 
> Do those messages suggest the wrong driver is being used?  That
> there's a (not-yet critical) hardware problem on my hard disk, which
> older kernels don't notice?
> 
> Now I'm going to go try some e2fsck -cc /dev/hda3 and/or badblocks -n
> /dev/hda[12] to see if any disk problems turn up that way.
> 
> Attached is my dmesg from Debian's kernel.

If you're using a modern distribution, I would say you should try 
disabling the old IDE drivers under CONFIG_IDE entirely, and try the 
libata driver instead. This will mean all your drives will show up as 
sdX instead of hdX, which may mean you need to make adjustments to your 
boot setup (mounting by label or by UUID, possibly) so that you can 
still mount the root file system.
