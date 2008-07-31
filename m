From: Scott Wood <scottwood@freescale.com>
Subject: Re: libata badness
Date: Thu, 31 Jul 2008 15:37:39 -0500
Message-ID: <20080731203739.GA17718@ld0162-tx32.am.freescale.net>
References: <95646AC3-5385-4F59-8EBA-20F811168A87@kernel.crashing.org> <20080731190259.GJ26938@trinity.fluff.org> <836C281D-4D3A-4547-98D9-143A690698AF@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:53716 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbYGaUhn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Jul 2008 16:37:43 -0400
Content-Disposition: inline
In-Reply-To: <836C281D-4D3A-4547-98D9-143A690698AF@kernel.crashing.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>

On Thu, Jul 31, 2008 at 03:24:31PM -0500, Kumar Gala wrote:
> >it would be helpful to compile a kernel with verbose fault information
> >turned on.
> 
> Doesn't seem to provide too much more info on ppc.

I'm pretty sure it does the same thing on ppc as on all the other
architectures.

> just says the file/ line number of the badness.

...which is a lot more useful than an address in someone else's kernel
image.

-Scott
