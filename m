From: Marc MERLIN <marc@merlins.org>
Subject: Re: Does Intel Sandy Bridge MB Sata support port multipliers?
Date: Mon, 20 Jun 2011 07:25:44 -0700
Message-ID: <20110620142544.GC21438@merlins.org>
References: <20110620045138.GB21438@merlins.org> <4DFF1642.4040404@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:42703 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112Ab1FTOZs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2011 10:25:48 -0400
Content-Disposition: inline
In-Reply-To: <4DFF1642.4040404@seoss.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@seoss.co.uk>
Cc: linux-ide@vger.kernel.org

On Mon, Jun 20, 2011 at 10:43:30AM +0100, Tim Small wrote:
> On 20/06/11 05:51, Marc MERLIN wrote:
> > I upgraded the system and was hoping to use onboard sata (it's a Sandy
> > Bridge lga1155).
> 
> Which chipset?  Perhaps lspci of the ahci controller device?
 
00:1f.2 SATA controller: Intel Corporation Unknown device 1c02 (rev 05)

> > When I plug my PMP into that, the other drives are not detected.
> >
> > Where do I find the list of SATA drivers that support PMP.
> 
> It's dependant on the hardware and the driver...
> 
> https://ata.wiki.kernel.org/index.php/SATA_hardware_features
 
Thanks, I tried searching for this page on google and came up empty handed. 
I guess this page needs a few more links, and maybe the whole wiki
can be linked somewhere in /usr/src/linux/Documentation/ ?
 
> > Are newer intel MBs with onboard SATA supposed to work?
> 
> I believe Intel limit PMP support to certain chipsets and versions (for
> "product differentiation" marketing reasons).  I have an H67 motherboard
> here, and PMP is supported on all 6 ports, but only in "CBS" mode (i.e.
> poor performance if you try to access two drives concurrently).
> 
> I'm currently wrestling with PMP support on Marvell AHCI devices....
> 
> It seems to work on an 88SE9125 with recent firmware, but not working
> with an 88SE9123 with older firmware.  I'm planning on doing further
> debug later today.
 
I see.

> > ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems apst 
> 
> no "pmp" in that flag list :-(

Ok, so I guess that answers this question.

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
