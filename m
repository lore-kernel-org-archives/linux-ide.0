From: Jens Axboe <axboe@suse.de>
Subject: Re: State of resume for AHCI?
Date: Fri, 2 Jun 2006 08:03:24 +0200
Message-ID: <20060602060323.GS4400@suse.de>
References: <447F23C2.8030802@goop.org> <447F3250.5070101@rtr.ca> <20060601183904.GR4400@suse.de> <447F4BC2.8060808@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:56605 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751138AbWFBGBd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Jun 2006 02:01:33 -0400
Content-Disposition: inline
In-Reply-To: <447F4BC2.8060808@goop.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Mark Lord <lkml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org

On Thu, Jun 01 2006, Jeremy Fitzhardinge wrote:
> Jens Axboe wrote:
> >It's a lot more complicated than that, I'm afraid. ahci doesn't even
> >have the resume/suspend methods defined, plus it needs more work than
> >piix on resume.
> >  
> Hannes Reinecke's patch implements those functions, basically by 
> factoring out the shutdown and init code and calling them at 
> suspend/resume time as well.
> 
> Is that correct/sufficient?  Or should something else be happening?

No that's it, I know for a fact that suspend/resume works perfectly with
the 10.1 suse kernel. You can give that a shot, if you want.

-- 
Jens Axboe

