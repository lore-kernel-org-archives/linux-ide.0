From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: sata_sil data corruption, possible workarounds
Date: Sat, 15 Dec 2012 15:55:44 -0600
Message-ID: <50CCF1E0.9070804@gmail.com>
References: <kahap3$mur$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:43780 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab2LOVzs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Dec 2012 16:55:48 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so4315780iay.19
        for <linux-ide@vger.kernel.org>; Sat, 15 Dec 2012 13:55:48 -0800 (PST)
In-Reply-To: <kahap3$mur$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bl0 <bl0-052@playker.info>
Cc: linux-ide@vger.kernel.org

On 12/15/2012 02:02 AM, bl0 wrote:
> I have a PCI card based on Silicon Image 3114 SATA controller. Like many
> people in the past I have experienced silent data corruption.
> I am lucky to have a hardware configuration where it is easy to reproduce
> this behavior with 100% rate by copying a file from a USB stick plugged
> into another PCI card. My motherboard has nvidia chipset.
>
> Going through messages and bug reports about this problem, someone mentioned
> that PCI cache line size may be relevant. I did some testing with different
> CLS values and found that the problem of data corruption is solved if
> either
> A). CLS is set to 0, before or after sata_sil kernel driver is loaded
>    # setpci -d 1095:3114 CACHE_LINE_SIZE=0
> where 1095:3114 is the device id as shown by 'lspci -nn'. The same command
> can also be used in grub2 (recent versions) shell or configuration file
> before booting linux.
> or
> B). CLS is set to a sufficiently large value, only after sata_sil is loaded.
>    # setpci -d 1095:3114 CACHE_LINE_SIZE=28
> (value is hexadecimal, in 4-byte units, here it's 160 bytes)
> What is a sufficiently large value depends on the value that is set before
> the driver is loaded. If the value before the driver is loaded is 32 or 64
> bytes, I have to increase it (after the driver is loaded) to 128 or 160
> bytes, respectively.
>
> In sata_sil.c source in sil_init_controller it writes some hardware-specific
> value depending on PCI cache line size. By lowering this value I can get it
> to work with lower CLS. The lowest value 0 works with CLS 64 bytes. If the
> CLS is 32 bytes, I have to increase the CLS.

The meaning of that value from the datasheet is: "This bit field is used 
to specify the system cacheline size in terms of 32-bit words. The upper 
2 bits are not used, resulting a maximum size of 64 32-bit words. With 
the SiI3114 as a master, initiating a read transaction, it issues PCI 
command Read Multiple in place, when empty space in its FIFO is larger 
than the value programmed in this register."

I think this value is likely the key. The cache line size itself 
shouldn't make any difference with this controller as it only really 
affects Memory Write & Invalidate (MWI) and the driver doesn't try to 
enable that for this device. But it's being used to derive the value 
written into this register.

Can you add in some output to figure out what values are being written 
to this register and see which values are working or not working?

>
> Data corruption is the biggest problem for me and these workarounds help but
> another problem remains, sometimes when accessing multiple PCI devices at
> the same time sata becomes inaccessible and times out with log messages
> similar to:
> [  411.351805] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
> frozen
> [  411.351824] ata3.00: cmd c8/00:00:00:af:00/00:00:00:00:00/e0 tag 0 dma
> 131072 in
> [  411.351826]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4
> (timeout)
> [  411.351830] ata3.00: status: { DRDY }
> [  411.351843] ata3: hard resetting link
> [  411.671775] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [  411.697059] ata3.00: configured for UDMA/100
> [  411.697080] ata3: EH complete
>
> Reboot is needed to access sata drives again. If I had the root filesystem
> on a sata drive it would probably crash the system.
>
> Another thing that may be related. Comparing lspci output reveals that when
> accessing multiple PCI devices at the same time, the flag DiscTmrStat
> (Discard Timer Status) gets toggled on for device "00:08.0 PCI bridge:
> nVidia Corporation nForce2 External PCI Bridge". I don't know if it's
> normal or not.

I'm not an expert on the whole PCI bridge/delayed completion stuff but 
it appears that this means that a device (either the host bridge/CPU or 
a device behind that bridge) initiated a delayed transaction for a read, 
but then didn't retry the request to pick up the read data later. From 
what I can tell this seems abnormal, at least in most cases.

Can you post the full lspci -vv output? Do the problems only occur if 
there are multiple devices plugged in behind that bridge?

>
> Finally, the same simple test that I use on Linux does not produce data
> corruption on FreeBSD. Either this problem doesn't occur there or it's not
> trivial to reproduce.
>
> This bug has been around for so long. I hope someone will find this
> information useful.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

