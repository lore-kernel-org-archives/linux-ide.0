From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_mv on Orion: mv_err_intr when shutting down
Date: Sun, 15 Jun 2008 11:18:01 +0900
Message-ID: <48547BD9.8050306@gmail.com>
References: <20080512132611.GA15410@deprecation.cyrius.com> <20080612181851.GA19874@deprecation.cyrius.com> <48526B44.4060600@rtr.ca> <200806131812.38055.elendil@planet.nl> <4852A6D0.8030607@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:23090 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394AbYFOCSJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jun 2008 22:18:09 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1389564tic.23
        for <linux-ide@vger.kernel.org>; Sat, 14 Jun 2008 19:18:07 -0700 (PDT)
In-Reply-To: <4852A6D0.8030607@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Frans Pop <elendil@planet.nl>, linux-ide@vger.kernel.org, nico@cam.org, buytenh@wantstofly.org, Byron Bradley <byron.bbradley@gmail.com>

Mark Lord wrote:
> Mmm.. I suppose .remove() is not supposed to be called, then.
> What does happen, is sd_shutdown() runs ("Stopping disk"),
> and that's that.
> 
> Weird.  I'd have thought there'd be a call somewhere to .port_stop()
> or even .host_stop() on shutdown, but I don't see one anywhere.
> 
> Tejun?
> Don't we try and turn off the hardware (IRQs) after stopping the drives?
> Because these guys are seeing interrupts afterwards (loss of PHY, it
> seems),
> and that looks somewhat risky -- such an interrupt might kill the
> shutdown sequence,
> leaving a machine in limbo.  Or not (?).

We don't call port or host stop during shutdown.  We only do so when the
controller goes away or the module is being unloaded.  All that happens
is spinning down the disks via sd_shutdown().  I don't think drivers are
supposed to put everything into quiesced state when shutting down.  The
system can remain in working state except for ones which require special
care.

The interesting thing here is that sata_mv can see the disk going off
the power, which is kind of cool.  The controller and CPU are watching
itself as it goes off the life support and is drifting awaaaaaayyyy.

The PSU has switched off and power to the drive was cut.  I don't think
anything can go wrong at that point.

Thanks.

-- 
tejun
