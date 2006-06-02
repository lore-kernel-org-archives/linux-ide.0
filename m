From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: State of resume for AHCI?
Date: Thu, 01 Jun 2006 20:39:24 -0700
Message-ID: <447FB2EC.7050701@goop.org>
References: <447F23C2.8030802@goop.org> <447F3250.5070101@rtr.ca>	 <20060601183904.GR4400@suse.de>  <447F4BC2.8060808@goop.org> <1149210165.13451.4.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:63434 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751240AbWFBDj2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Jun 2006 23:39:28 -0400
In-Reply-To: <1149210165.13451.4.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Jens Axboe <axboe@suse.de>, Mark Lord <lkml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org

zhao, forrest wrote:
> According to our test of Hannes's patch, it's not sufficient to support
> AHCI suspend/resume.
>   
Yes.  I merged it into mm2, and it didn't make any difference.
> Now I'm writing a patch to try to provide complete support for AHCI
> suspend/resume and will send out patch soon, hopefully by the end of
> today.
Great, looking forward to it.

    J
