From: Jim Paris <jim@jtan.com>
Subject: Re: timeout errors on sata_sil24 with port multiplier & PCI-X
Date: Fri, 9 Mar 2007 22:13:27 -0500
Message-ID: <20070310031327.GA16482@jim.sh>
References: <20070309221628.GA12330@jim.sh> <20070309233151.GD14319@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:50716 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752796AbXCJDOP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 22:14:15 -0500
Content-Disposition: inline
In-Reply-To: <20070309233151.GD14319@curie-int.orbis-terrarum.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

> > If not I think my next course of action will be to try swapping the
> > controller to a PCIe SiI3132, then maybe give Robin H. Johnson's
> > 2.6.20 port of the PMP patches a try.
> 
> Here's paste of the equivalent stuff on my patches. Notice that it takes 49
> seconds to bring the disk array up :-(.
>
> Feb 28 20:30:52 [kernel] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x42 frozen
> Feb 28 20:30:52 [kernel] ata1: (irq_stat 0x00b00090, PHY RDY changed)

>From the "PHY RDY changed" I assume that's when you're bringing it up
for the first time?  Mine also takes a while, but that doesn't bother
me -- my problem is frequent random timeouts that cause the same sorts
of delays during normal use.

> Also, afaik there has been no resolution of the performance issue - while the
> controller shows 3Gb, the actual combined speeds I get are only at the 1.5Gb
> level.

1.5Gb without the timeouts/hard resets would be fine with me :)

-jim
