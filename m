From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Possible corruption over AHCI
Date: Sun, 06 Jan 2013 22:08:50 -0600
Message-ID: <50EA4A52.2030800@gmail.com>
References: <alpine.LNX.2.00.1301031441140.19998@winds.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:47714 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413Ab3AGEIw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jan 2013 23:08:52 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so22741702ieb.33
        for <linux-ide@vger.kernel.org>; Sun, 06 Jan 2013 20:08:52 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1301031441140.19998@winds.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Byron Stanoszek <bstanoszek@comtime.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On 01/03/2013 02:45 PM, Byron Stanoszek wrote:
> Hi Jeff, all,
>
> I'm having a data corruption issue while storing data to a specific type of
> Compact Flash card connected over AHCI. It seems that when two (or more)
> processes are writing to disk at the same time, and a sync() happens, every
> once in a while some data from one process's file writes will appear in
> place
> of data in the other file.
>
> Here are the specifics of my hardware:
>
> I'm using the built-in CF card slot on a Siemens 627C Industrial PC,
> which is
> connected to the motherboard via an AHCI chipset. The CF card is
> bootable. The
> BIOS is configured to use "RAID" mode ("Enhanced" or "AHCI" mode will
> not boot
> the CF card).
>
> AHCI chipset in use:
> 00:1f.2 0104: 8086:282a (rev 05)
> 00:1f.2 RAID bus controller: Intel Corporation 82801 Mobile SATA
> Controller [RAID mode] (rev 05)
>
> CF card with the problem:  SanDisk Ultra 8GB   (model SDCFH-008G)
> CF card that always works: SanDisk Extreme 8GB (model SDCFX-008G)
>
> Filesystem: ReiserFS
>
> Kernels tested to show symptoms: 3.0.14, 3.4.11, 3.7.1
>
> I can get the problem to reproduce almost 50% of the time by having a
> program
> drop a 50MB core dump in the background (over and over again) to the disk,
> while in the meantime I rsync over a 190MB gzipped file over to the disk
> from a
> remote PC. After that, I "sync", and then I clear the kernel's clean cache
> using "echo 1 > /proc/sys/vm/drop_caches".
>
> 50% of the time, rereading the gzipped file will show one or more 4K
> chunks of
> data from the core dump (or other process writing to disk) come out in
> random
> locations in the file, compared to what the file showed before clearing the
> cache. In other words, after the write and sync is complete, the cached
> file in
> Linux memory shows correct, but the copy stored on disk is wrong.
>
> I've reproduced the problem on several 627C PCs and Ultra cards now. If
> I use
> the same Ultra card on any other type of PC (using ata_piix or pata_jmicron
> drivers, since the Siemens PC is the only system I have with an AHCI
> chipset),
> it works fine. If I use an Extreme card instead on the Siemens PC, it works
> fine (even after 1000 transfers).
>
> I tried mounting and recreating the ReiserFS using the "notail" option,
> still
> same problem.
>
> I tried limiting the disk to use UDMA/33 or PIO4 mode, still same
> problem. (The
> Ultra disk normally comes up as UDMA/66, and the Extreme disk normally
> comes up
> as UDMA/100).
>
> I verified NCQ is not being used.
>
> Assuming this is a problem in the AHCI driver for the moment, what other
> options can I tweak to try to narrow down the problem? Are there any
> relevant
> AHCI features I can turn on/off by changing the source?
>
> I've attached the dmesg & lspci of the Siemens PC.
>
> Thanks and best regards,
>   -Byron

My first inclination is that this isn't very likely to be a problem in 
the AHCI driver. It's the most widely used storage driver on modern PCs 
so it seems unlikely that this sort of problem would show up there at 
this point.

I assume there's some kind of SATA to PATA bridge involved in the chain 
(likely on the motherboard). It's possible that some combination of 
timing changes between the cards, the controller operating mode and/or 
the different host controller causes a bug to occur in either the CF 
card or the bridge chip.
