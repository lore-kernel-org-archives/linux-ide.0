From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: State of resume for AHCI?
Date: Thu, 01 Jun 2006 13:19:14 -0700
Message-ID: <447F4BC2.8060808@goop.org>
References: <447F23C2.8030802@goop.org> <447F3250.5070101@rtr.ca> <20060601183904.GR4400@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:29377 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965295AbWFAUTS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Jun 2006 16:19:18 -0400
In-Reply-To: <20060601183904.GR4400@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Mark Lord <lkml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> It's a lot more complicated than that, I'm afraid. ahci doesn't even
> have the resume/suspend methods defined, plus it needs more work than
> piix on resume.
>   
Hannes Reinecke's patch implements those functions, basically by 
factoring out the shutdown and init code and calling them at 
suspend/resume time as well.

Is that correct/sufficient?  Or should something else be happening?

    J
