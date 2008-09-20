From: "Grant Grundler" <grundler@google.com>
Subject: Re: What's the SB600 64-bit DMA problem?
Date: Sat, 20 Sep 2008 15:28:51 -0700
Message-ID: <da824cf30809201528o27478ae2h5894e39932622d3b@mail.gmail.com>
References: <20080920151712.10515.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:51063 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbYITW3V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Sep 2008 18:29:21 -0400
Received: from zps76.corp.google.com (zps76.corp.google.com [172.25.146.76])
	by smtp-out.google.com with ESMTP id m8KMSt0o008526
	for <linux-ide@vger.kernel.org>; Sat, 20 Sep 2008 23:28:56 +0100
Received: from ug-out-1314.google.com (ugfj3.prod.google.com [10.66.186.3])
	by zps76.corp.google.com with ESMTP id m8KMSrwL008613
	for <linux-ide@vger.kernel.org>; Sat, 20 Sep 2008 15:28:53 -0700
Received: by ug-out-1314.google.com with SMTP id j3so1206096ugf.36
        for <linux-ide@vger.kernel.org>; Sat, 20 Sep 2008 15:28:52 -0700 (PDT)
In-Reply-To: <20080920151712.10515.qmail@science.horizon.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: linux-ide@vger.kernel.org

On Sat, Sep 20, 2008 at 8:17 AM, George Spelvin <linux@horizon.com> wrote:
> I just got a couple of MSI KA92 (AMD 790FX-based) motherboards with
> 8 GiB of RAM each.  I noticed on boot that the SB600 AHCI implementation
> had a 32-bit DMA limitation, and looking in the archives, it
> appears that folks from AMD think it doesn't need to be there.

URL?
Just want to be sure I'm looking at the same thread.

> So, by way of cautious expoeriment, I removed that quirk from the
> appropriate part of drivers/ata/ahci.c and did the following test:
> - Place the system drives on a plug-in SiI3232 controller
> - Install one scratch drive on the SB600
> - Run "badblocks -s -b512 -w -t random -t 0 /dev/sda 9999999 0", and
>  repeat for consecutive 1e7-sector ranges.
>
> This produced no errors in an hour or so.
>
> Next step:
> - Install the system drives on the SB600 ports.
> - boot "init=/bin/sh" so the root file system is read-only
> - "echo check > /sys/block/mdX/md/sync_action"
>
> This also reported no errors.  The next step is to run e2fsck on those
> file systems.
>
> Can anyone suggest any other tests to confirm the presence or absence
> of the 64-bit DMA bug?  My impression from the previous discussion was
> that it was pretty obvious.

It's obvious if the memory corruption causes a system crash or
data corruption visible to an application that is looking for it.

To be certain,  you just need to confirm that the IO buffers
are guaranteed to (a) not be mapped for DMA via the GART
(setting 64-bit DMA mask should have the result) and (b) the
physical addresses of the buffers are above 4GB.

(b) is easier to prove by using an application that consumes more
than 4GB of RAM and verifies the data is not corrupted at any time.
Oracle would be such an app but I'm hoping someone can point
at something simpler. (no, firefox doesn't count :)

hth,
grant

>
> Here's the lspci -nn output:
>
> 00:00.0 Host bridge [0600]: ATI Technologies Inc RD790 Northbridge only dual slot PCI-e_GFX and HT3 K8 part [1002:5956]
> 00:03.0 PCI bridge [0604]: ATI Technologies Inc RD790 PCI to PCI bridge (external gfx0 port B) [1002:5979]
> 00:04.0 PCI bridge [0604]: ATI Technologies Inc RD790 PCI to PCI bridge (PCI express gpp port A) [1002:597a]
> 00:05.0 PCI bridge [0604]: ATI Technologies Inc RD790 PCI to PCI bridge (PCI express gpp port B) [1002:597b]
> 00:09.0 PCI bridge [0604]: ATI Technologies Inc RD790 PCI to PCI bridge (PCI express gpp port E) [1002:597e]
> 00:0b.0 PCI bridge [0604]: ATI Technologies Inc RD790 PCI to PCI bridge (external gfx1 port A) [1002:5980]
> 00:0c.0 PCI bridge [0604]: ATI Technologies Inc RD790 PCI to PCI bridge (external gfx1 port B) [1002:5981]
> 00:12.0 SATA controller [0106]: ATI Technologies Inc SB600 Non-Raid-5 SATA [1002:4380]
> 00:13.0 USB Controller [0c03]: ATI Technologies Inc SB600 USB (OHCI0) [1002:4387]
> 00:13.1 USB Controller [0c03]: ATI Technologies Inc SB600 USB (OHCI1) [1002:4388]
> 00:13.2 USB Controller [0c03]: ATI Technologies Inc SB600 USB (OHCI2) [1002:4389]
> 00:13.3 USB Controller [0c03]: ATI Technologies Inc SB600 USB (OHCI3) [1002:438a]
> 00:13.4 USB Controller [0c03]: ATI Technologies Inc SB600 USB (OHCI4) [1002:438b]
> 00:13.5 USB Controller [0c03]: ATI Technologies Inc SB600 USB Controller (EHCI) [1002:4386]
> 00:14.0 SMBus [0c05]: ATI Technologies Inc SBx00 SMBus Controller [1002:4385] (rev 14)
> 00:14.1 IDE interface [0101]: ATI Technologies Inc SB600 IDE [1002:438c]
> 00:14.2 Audio device [0403]: ATI Technologies Inc SBx00 Azalia [1002:4383]
> 00:14.3 ISA bridge [0601]: ATI Technologies Inc SB600 PCI to LPC Bridge [1002:438d]
> 00:14.4 PCI bridge [0604]: ATI Technologies Inc SBx00 PCI to PCI Bridge [1002:4384]
> 00:18.0 Host bridge [0600]: Advanced Micro Devices [AMD] Family 10h [Opteron, Athlon64, Sempron] HyperTransport Configuration [1022:1200]
> 00:18.1 Host bridge [0600]: Advanced Micro Devices [AMD] Family 10h [Opteron, Athlon64, Sempron] Address Map [1022:1201]
> 00:18.2 Host bridge [0600]: Advanced Micro Devices [AMD] Family 10h [Opteron, Athlon64, Sempron] DRAM Controller [1022:1202]
> 00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] Family 10h [Opteron, Athlon64, Sempron] Miscellaneous Control [1022:1203]
> 00:18.4 Host bridge [0600]: Advanced Micro Devices [AMD] Family 10h [Opteron, Athlon64, Sempron] Link Control [1022:1204]
> 01:00.0 Mass storage controller [0180]: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller [1095:3132] (rev 01)
> 02:00.0 Mass storage controller [0180]: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller [1095:3132] (rev 01)
> 03:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller [10ec:8168] (rev 01)
> 04:00.0 RAID bus controller [0104]: Promise Technology, Inc. Device [105a:3f20]
> 05:00.0 VGA compatible controller [0300]: ATI Technologies Inc RV370 5B60 [Radeon X300 (PCIE)] [1002:5b60]
> 05:00.1 Display controller [0380]: ATI Technologies Inc RV370 [Radeon X300SE] [1002:5b70]
> 06:00.0 Mass storage controller [0180]: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller [1095:3132] (rev 01)
> 07:00.0 FireWire (IEEE 1394) [0c00]: VIA Technologies, Inc. IEEE 1394 Host Controller [1106:3044] (rev c0)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
