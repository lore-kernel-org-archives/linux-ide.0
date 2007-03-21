From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFT] libata hpa support
Date: Wed, 21 Mar 2007 18:34:55 +0000
Message-ID: <20070321183455.00f4732b@lxorguk.ukuu.org.uk>
References: <20070223170625.GA29931@athena.road.mcmartin.ca>
	<20070321130140.GA4328@athena.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48569 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933215AbXCURbg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Mar 2007 13:31:36 -0400
In-Reply-To: <20070321130140.GA4328@athena.road.mcmartin.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Kyle McMartin <kyle@canonical.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, mjg59@ubuntu.com

On Wed, 21 Mar 2007 09:01:41 -0400
Kyle McMartin <kyle@canonical.com> wrote:

> On Fri, Feb 23, 2007 at 12:06:25PM -0500, Kyle McMartin wrote:
> > 
> 
> Bummer. It appears to fail horribly on a MacBook. Unfortunately I have
> no clue what's special (but I assume something to do with EFI bringup) about
> them, nor any hardware. Alan, Jeff, any ideas?

I'm testing a variant of it at the moment with no problems on x86. My
first thought would be to check for endianness problems and the like but
I don't see any.

It may also fail to allow any resizing if the Macbook issues a security
freeze from the firmware before the OS boots, if so we won't be able to
resize the HPA or set/change passwords on the disk. If they are doing
that then its a fairly sensible security choice.
