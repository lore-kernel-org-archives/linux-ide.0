From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend
 SSD
Date: Thu, 5 Nov 2009 17:18:33 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0911051657490.1166@hs20-bc2-1.build.redhat.com>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>
 <200910221144.04471.bzolnier@gmail.com> <Pine.LNX.4.64.0910231024240.324@hs20-bc2-1.build.redhat.com>
 <200910231644.29919.bzolnier@gmail.com> <Pine.LNX.4.64.0910231050330.3007@hs20-bc2-1.build.redhat.com>
 <20091023175157.3a898525@lxorguk.ukuu.org.uk> <4AE1E78A.2090801@ru.mvista.com>
 <20091023192250.600edc9b@lxorguk.ukuu.org.uk>
 <Pine.LNX.4.64.0910260731460.21316@hs20-bc2-1.build.redhat.com>
 <20091026121804.3789c4c0@lxorguk.ukuu.org.uk>
 <Pine.LNX.4.64.0911042021530.19963@hs20-bc2-1.build.redhat.com>
 <20091105104018.357be391@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39034 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758943AbZKEWSj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Nov 2009 17:18:39 -0500
In-Reply-To: <20091105104018.357be391@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, Daniela Engert <dani@ngrt.de>



On Thu, 5 Nov 2009, Alan Cox wrote:

> On Wed, 4 Nov 2009 20:25:21 -0500 (EST)
> Mikulas Patocka <mpatocka@redhat.com> wrote:
> 
> > Hi
> > 
> > Here is another patch for SSD for VIA UDMA33. Alan, please backport it 
> > into libata.
> 
> I might consider adding the TS device to the blacklist on libata IFF
> - I have the full ID string so I can match device accurately not blanket
>   cripple hardware
> - I had a much more detailed bug report - eg exact dmesg data up to the
>   lock
> - I know which exact controller card(s) it occurs on (rather than
>   blanket "via")
> - If I knew it occurred on libata
> - If I knew it wasn't an IDE and/or shared IDE/libata bug or didn't
>   appear to be one.
> 
> Crippling every other transcend device user on the planet for your
> specific report (that nobody else has so far reported to me) would almost
> certainly be a regression on a massive scale.
> 
> Does your TS device work with other controllers - do you just have a
> faulty unit or marginal cabling ?
> 
> For any real failure case like this I'd expect a pile of entries in
> bugzillas from multiple people. Now it could simply be yours is the first
> in which case I'll look at it a blacklist when I see a few more.
> 
> Alan

The device ID string is: TS64GSSD25-M, serial 002328450083, revision V0826

The south bridge is VIA VT82C586B

The lockup happens on partition scan, sometimes the scan passes and it 
locks up when loading init. It doesn't get further.

The lockup is not dependent on IDE driver. I experienced it with Linux 2.6 
IDE, Linux 2.6 LIBATA, Daniela's OS/2 DANIS506 driver (Daniela, if you 
maintain a blacklist, you can add it there too) - switching to MWDMA 
helped. Linux 2.2 locked up too (it doesn't set transfer mode and relies 
on BIOS) and disabling UDMA in BIOS cured the problem.

I tried to switch to UDMA 0 and UDMA 1, but the lockups didn't go away, 
they just became less frequent. With MWDMA 2 it works reliably.

I tested it in a motherboard with VIA133 IDE and it works there. I think 
it also worked with that VT6421 card, but I can't test it now because I 
moved root to that Transcend SSD and it wouldn't boot of that.

This is the list of PCI devices for the detailed information (note that 
onboard IDE locks-up, not that additional VT6421 controller on a PCI 
card).

Mikulas

BUS 0, DEV 0, FN 0
1106 0597 0000 0000 06 00 00 03
        Bridge - Host bridge
        VIA Technologies, Inc. - VT82C597 [Apollo VP3]
BUS 0, DEV 1, FN 0
1106 8598 0000 0000 06 04 00 00
        Bridge - PCI bridge - Normal decode
        VIA Technologies, Inc. - VT82C598/694x [Apollo MVP3/Pro133x AGP]
BUS 0, DEV 7, FN 0
1106 0586 0000 0000 06 01 00 41
        Bridge - ISA bridge
        VIA Technologies, Inc. - VT82C586/A/B PCI-to-ISA [Apollo VP]
BUS 0, DEV 7, FN 1 (CLAIMED)
1106 0571 0000 0000 01 01 8A 06
        Mass storage controller - IDE interface
        VIA Technologies, Inc. - VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC 
Bus Master IDE
BUS 0, DEV 7, FN 2 (CLAIMED)
1106 3038 0925 1234 0C 03 00 02
        Serial bus controller - USB Controller - UHCI
        VIA Technologies, Inc. - VT82xxxxx UHCI USB 1.1 Controller - USB 
Controller
BUS 0, DEV 7, FN 3
1106 3040 0000 0000 06 04 00 10
        Bridge - PCI bridge - Normal decode
        VIA Technologies, Inc. - VT82C586B ACPI
BUS 0, DEV 8, FN 0 (CLAIMED)
1101 1060 1101 1060 01 00 00 01
        Mass storage controller - SCSI storage controller
        Initio Corporation - INI-A100U2W
BUS 0, DEV 9, FN 0 (CLAIMED)
1106 3038 1106 3038 0C 03 00 62
        Serial bus controller - USB Controller - UHCI
        VIA Technologies, Inc. - VT82xxxxx UHCI USB 1.1 Controller
BUS 0, DEV 9, FN 1 (CLAIMED)
1106 3038 1106 3038 0C 03 00 62
        Serial bus controller - USB Controller - UHCI
        VIA Technologies, Inc. - VT82xxxxx UHCI USB 1.1 Controller
BUS 0, DEV 9, FN 2
1106 3104 1106 3104 0C 03 20 65
        Serial bus controller - USB Controller - EHCI
        VIA Technologies, Inc. - USB 2.0
BUS 0, DEV 9, FN 3 (CLAIMED)
1106 3249 1106 3249 01 04 00 50
        Mass storage controller - RAID bus controller
        VIA Technologies, Inc. - VT6421 IDE RAID Controller
BUS 0, DEV 10, FN 0 (CLAIMED)
8086 1076 8086 1176 02 00 00 00
        Network controller - Ethernet controller
        Intel Corporation - 82541GI Gigabit Ethernet Controller - PRO/1000 
MT Desktop Adapter
BUS 1, DEV 0, FN 0 (CLAIMED)
5333 8A13 5333 8A13 03 00 00 02
        Display controller - VGA compatible controller - VGA
        S3 Inc. - 86c368 [Trio 3D/2X] - Trio3D/2X

