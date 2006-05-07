From: Moritz Heiber <moe@lunar-linux.org>
Subject: Re: Issues with AHCI and SATAII using JMD360
Date: Sun, 7 May 2006 14:04:43 +0200
Message-ID: <20060507140443.7ae89a68.moe@lunar-linux.org>
References: <20060507043702.052e3f56.moritz-heiber@arcor.de>
	<445D6298.7090003@gmail.com>
Reply-To: Moritz Heiber <moe@lunar-linux.org>, linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:56755 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751195AbWEGMEp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 May 2006 08:04:45 -0400
In-Reply-To: <445D6298.7090003@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, 07 May 2006 11:59:36 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Moritz Heiber wrote:
> > Hello,
> > 
> > as I skimmed through the mailinglist archives I noticed that support
> > for the JMD360 SATA chipset has just been added recently and so I
> > went ahead and tried to make use of my motherboard's SATAII
> > capabilities. Unfortunately, I did not succeed at it.
> > 
> > I'm using a ASRock 939Dual-SATA2 mainboard equipped with a JMD360
> > SATA controller chip. A Hitachi Deskstar 7K250 (HDT722516DLA380),
> > which is supposed to support SATAII, is attached to the only
> > available SATAII compliant socket using the correct cables. The
> > harddrive is recognized correctly as SATAII device by the AMI BIOS
> > (latest revision 1.8.0).
> 
> What does the BIOS say exactly?  SATA II is a vague term.  It
> comprises several features.  Some call NCQ-capable drives SATA-II
> while others consider 3.0Gbps link SATA-II.

The manufacturer's url [1] states the following:

"PCI E SATA2 controller on board, optimizing the support for SATA2 HDD"

The BIOS and the manual [2] also state a speed advantage of 3.0Gbps.

[1] http://www.asrock.com/product/939Dual-SATA2.htm
[2] http://www.asrock.com/Drivers/Manual/939Dual-SATA2.pdf
    (Page 6)

> > I'm running 2.6.16.14 without any apparent patches (obviously
> > through Lunar Linux).
> > 
> > So I'm wondering, is it just me .. or might the driver actually do
> > something wrong here? Could it be a mismatching PCI_ID?
> > 
> > Any hints on how I'd be able to solve this problem would be highly
> > appreciated. I can, of course, provide more data or apply some
> > further testing incase you want me to.
> 
> I've googled and the drive does support 3Gbps.  There are several 
> possibilities.
> 
> * jumper on the drive which limits it to 1.5Gbps is closed

Negative. I double checked. Neither the drive's technical
specifications nor a visual inspection show a jumper or switch of any
sorts. Also, as a reminder .. the BIOS actually shows the drive as
being connected as SATAII capable device. So its (AFAIC) not a hardware
issue.

> * both the controller and drive support 3Gbps but somehow they fail
> to negotiate at that speed.

I guess that is the most likely explainations. Any way of solving that
issue?
 
> * BIOS limits link spd to 1.5Gbps using SControl in the hope for 
> improving compatibility

Giving that a thought .. the board's only PCIe slot is already occupied
by a pretty advanced video card. Could it be that the _bus_ is simply
outrun in terms of available bandwidth?

> More info can be obtained by printing SCR_CONTROL, just print the
> result of scr_read(ap, SCR_CONTROL) from
> libata.c::sata_print_link_status(), which prints the SStatus value.

I'm going to try to follow that lead. There doesn't seem to be any sort
of tool or application that runs the exact same test yet, is there?
hdparm fails on me.

> Whatever the reason is, don't torture yourself over it.  It simply
> isn't worth.  1.5Gbps is more than enough for any drive on market
> today.

Well, I'm just making an effort to get the best out of the hardware I
bought. I might fail at some point .. but at least I can say I tried.
 
Regards,

Moritz
