From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata for SATA HDs.
Date: Tue, 9 Aug 2005 14:04:11 -0400
Message-ID: <20050809180411.GD10315@havoc.gtf.org>
References: <42EEA9D5.5080304@superbug.demon.co.uk> <42F8B264.5010706@rtr.ca> <42F8EE0B.7000706@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:21384 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964904AbVHISEL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Aug 2005 14:04:11 -0400
Content-Disposition: inline
In-Reply-To: <42F8EE0B.7000706@superbug.demon.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

On Tue, Aug 09, 2005 at 06:55:23PM +0100, James Courtier-Dutton wrote:
> Mark Lord wrote:
> >James Courtier-Dutton wrote:
> >
> >>Google did not help me.
> >>
> >>Can I use the kernel libata and do commands like this now? :
> >>hdparm -S60 /dev/sda
> >
> >
> >Yes, but only if you manually apply the "libata-passthru" patch.
> >
> >The copy (below) works with 2.6.12, and I'm including it here
> >for the benefit of the many who aren't yet ready to adopt a new
> >religion (git) just for obtaining this vital functionality.
> >
> >Cheers
> >
> 
> So, why hasn't that patch got into the kernel?

Because there are several reports of it causing problems, when used on a
loaded system.

	Jeff



