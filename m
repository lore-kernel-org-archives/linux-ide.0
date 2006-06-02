From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: State of resume for AHCI?
Date: Fri, 02 Jun 2006 09:02:45 +0800
Message-ID: <1149210165.13451.4.camel@forrest26.sh.intel.com>
References: <447F23C2.8030802@goop.org> <447F3250.5070101@rtr.ca>
	 <20060601183904.GR4400@suse.de>  <447F4BC2.8060808@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31083 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751059AbWFBBPV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Jun 2006 21:15:21 -0400
In-Reply-To: <447F4BC2.8060808@goop.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jens Axboe <axboe@suse.de>, Mark Lord <lkml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org

On Thu, 2006-06-01 at 13:19 -0700, Jeremy Fitzhardinge wrote:
> Jens Axboe wrote:
> > It's a lot more complicated than that, I'm afraid. ahci doesn't even
> > have the resume/suspend methods defined, plus it needs more work than
> > piix on resume.
> >   
> Hannes Reinecke's patch implements those functions, basically by 
> factoring out the shutdown and init code and calling them at 
> suspend/resume time as well.
> 
> Is that correct/sufficient?  Or should something else be happening?

According to our test of Hannes's patch, it's not sufficient to support
AHCI suspend/resume.

Now I'm writing a patch to try to provide complete support for AHCI
suspend/resume and will send out patch soon, hopefully by the end of
today.

Thanks,
Forrest
