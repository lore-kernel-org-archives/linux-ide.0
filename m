From: Gene Heskett <gene.heskett@gmail.com>
Subject: Re: Problem with ata layer in 2.6.24
Date: Tue, 29 Jan 2008 09:51:53 -0500
Message-ID: <200801290951.55492.gene.heskett@gmail.com>
References: <200801272122.21823.gene.heskett@gmail.com>
 <479E1D9E.3000900@bobjweil.com> <20080129121201.2f727f5f@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:62198 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718AbYA2OwT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 09:52:19 -0500
In-reply-to: <20080129121201.2f727f5f@core>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Heck <rgheck@bobjweil.com>, Daniel Barkalow <barkalow@iabervon.org>, Zan Lynx <zlynx@acm.org>, Calvin Walton <calvin.walton@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ide Mailing list <linux-ide@vger.kernel.org>

On Tuesday 29 January 2008, Alan Cox wrote:
>> not one problem but lots---is sufficiently widespread that a Mini HOWTO,
>> say, would be really welcome and, I'm guessing, widely used.
>
>We don't see very many libata problems at the distro level and they for
>the most part boil down to
>
>- error messages looking different - Most bugs I get are things like
>media errors (timeout looks different, UNC report looks different)
>
>- broken hardware - I've closed a whole raft of bugs that turn out to be
>new PC systems where even the BIOS doesn't see the drives
>
>- faulty hardware being picked up because we actually do real error
>checking now. We now check for and give some devices more slack while
>still doing error checking. Both IDE layers also added blacklists for
>stuff like the TSScorp DVD drives. Qemu has now had its bugs patched.
>
>- sata_nv with >4GB of RAM, knowing being worked on, no old IDE driver
>anyway
>
>- pata_ali MWDMA with ATAPI, PIO works fine, all a bit of a mystery and
>as it affects only a few chip variants hard to figure out. Workaround
>libata.dma=1
>
>- CS handling. On a few boxes using cable select (particularly on one
>drive and not the other) shows up a problem, normally a failed SRST.
>That's still under investigation.
>
>- Promise timeouts. The old IDE times out then polls the device and finds
>the IRQ was never sent and then recovers so the user sees a short stall
>but no errors. The new libata doesn't do this and pdc202xx_old thus
>produces some error messages on some boxes. Backup polling is on my todo
>list.

As slight change here, I was going to use the same .config as 2.6.24-rc8, but 
just discovered that neither rc8 nor final is finding the drivers for my
dvd writer while using libata, so its not useable.  So I've enable a couple of 
things in the 2.6.24 build that aren't in the 2.6.24-rc8.  When I find the 
magic twanger, I'll rebuild -rc8 with it too.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
River: "He didn't lie down.  They never lie down."
				--"Serenity"
