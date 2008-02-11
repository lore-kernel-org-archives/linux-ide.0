From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 2/3 2.6.24-git] ARM/RPC: Use HAVE_PATA_PLATFORM to select pata platform driver
Date: Mon, 11 Feb 2008 23:59:23 +0000
Message-ID: <20080211235923.GY18658@trinity.fluff.org>
References: <20080202161636.269848721@fluff.org.uk> <20080202161756.505881942@fluff.org.uk> <47A9A0D9.4090308@garzik.org> <20080206124659.GB21027@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.145.97.151]:54688 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbYBKX7f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 18:59:35 -0500
Content-Disposition: inline
In-Reply-To: <20080206124659.GB21027@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org, htejun@gmail.com, Linux ARM Kernel <linux-arm-kernel@lists.arm.linux.org.uk>

On Wed, Feb 06, 2008 at 12:46:59PM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 06, 2008 at 06:58:17AM -0500, Jeff Garzik wrote:
> > ACK patch series...  would it be ok to send via the ARM maintainer?
> > 
> > I would prefer to add this at the same time as its user...
> 
> I've only seen the one patch, and I suspect that it depends on patches
> to other architectures (to convert other architectures to use the new
> variable.)

Hmm, that is a difficult one. If I send it via RMK, then it assumes
that Jeff applies the core patch first and gets his pull request off
first. If I send via Jeff, I have to hope RMK doesn't try and modify
any of the RPC code (unlikely, these machines have been out of production
for a few years now).

Even worse, the rest of the patches have to also be applied in order
as they remove from the depends line...

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

