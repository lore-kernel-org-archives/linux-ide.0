From: Philip Armstrong <phil@kantaka.co.uk>
Subject: Re: (fwd) Re: Bug#289770: kernel-image-2.6.10-1-686: 2.6.10 fails to set up DMA on my IBM thinkpad
Date: Wed, 12 Jan 2005 17:56:05 +0000
Message-ID: <20050112175605.GA1827@kantaka.co.uk>
References: <20050111195345.GI2618@stro.at> <20050112120245.GA24839@kantaka.co.uk> <200501121352.33520.bzolnier@elka.pw.edu.pl> <20050112133524.GA27287@kantaka.co.uk> <41E52A38.9060108@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dsl-217-155-153-11.zen.co.uk ([217.155.153.11]:55739 "EHLO
	217.155.153.11") by vger.kernel.org with ESMTP id S261271AbVALR4K
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Jan 2005 12:56:10 -0500
Content-Disposition: inline
In-Reply-To: <41E52A38.9060108@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Prarit Bhargava <prarit@sgi.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>, maximilian attems <debian@sternwelten.at>, linux-ide@vger.kernel.org, 289770@bugs.debian.org

On Wed, Jan 12, 2005 at 08:46:32AM -0500, Prarit Bhargava wrote:
> Philip and Bartlomiej,
> 
> I've been tracking an almost identical problem on my IA64 platform with 
> a bk pull that is about a month old. 
> 
> I tracked it down to a duplicate vector request of 0x38 = 56 by the 
> mmtimer -- take a look at /proc/interrupts, /proc/ioports, /proc/iomem 
> and see if anything has requested the specific area that your CD is 
> trying to get.

Interrupts and iomem seem pretty much the same, but ioports looks like
the following:

bucephalus:~# diff -W 80 --side-by-side 2.6.8/ioports 2.6.10/ioports
0000-001f : dma1                        0000-001f : dma1
0020-0021 : pic1                        0020-0021 : pic1
0040-005f : timer                     | 0040-0043 : timer0
                                      > 0050-0053 : timer1
0060-006f : keyboard                    0060-006f : keyboard
0070-0077 : rtc                         0070-0077 : rtc
0080-008f : dma page reg                0080-008f : dma page reg
00a0-00a1 : pic2                        00a0-00a1 : pic2
00c0-00df : dma2                        00c0-00df : dma2
00f0-00ff : fpu                         00f0-00ff : fpu
01f0-01f7 : ide0                        01f0-01f7 : ide0
0200-0207 : ns558-pnp                   0200-0207 : ns558-pnp
03bc-03be : parport0                    03bc-03be : parport0
03c0-03df : vga+                        03c0-03df : vga+
03f6-03f6 : ide0                        03f6-03f6 : ide0
03f8-03ff : serial                      03f8-03ff : serial
04d0-04d1 : pnp 00:0a                   04d0-04d1 : pnp 00:0a
0530-0533 : Crystal audio controller    0530-0533 : Crystal audio
controller
0cf8-0cff : PCI conf1                   0cf8-0cff : PCI conf1
1000-100f : 0000:00:07.1              <
  1000-1007 : ide0                    <
15e0-15ef : pnp 00:0a                   15e0-15ef : pnp 00:0a
4000-40ff : PCI CardBus #02             4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02             4400-44ff : PCI CardBus #02
4800-48ff : PCI CardBus #06             4800-48ff : PCI CardBus #06
4c00-4cff : PCI CardBus #06             4c00-4cff : PCI CardBus #06
8400-841f : 0000:00:07.2                8400-841f : 0000:00:07.2
  8400-841f : uhci_hcd                    8400-841f : uhci_hcd
d000-dfff : PCI Bus #01                 d000-dfff : PCI Bus #01
                                      > ef00-ef3f : 0000:00:07.3
efa0-efbf : 0000:00:07.3                efa0-efbf : 0000:00:07.3
  ef00-efaf : pnp 00:0a               | fcf0-fcff : 0000:00:07.1
    ef00-ef3f : 0000:00:07.3          |   fcf8-fcff : pnp 00:1c
fcf8-fcff : pnp 00:1c                 <

cheers,

Phil

-- 
http://www.kantaka.co.uk/ .oOo. public key: http://www.kantaka.co.uk/gpg.txt
