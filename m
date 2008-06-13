From: Frans Pop <elendil@planet.nl>
Subject: Re: sata_mv on Orion: mv_err_intr when shutting down
Date: Fri, 13 Jun 2008 19:10:39 +0200
Message-ID: <200806131910.40516.elendil@planet.nl>
References: <20080512132611.GA15410@deprecation.cyrius.com> <200806131812.38055.elendil@planet.nl> <4852A6D0.8030607@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml15.kpnxchange.com ([213.75.38.115]:8127 "EHLO
	hpsmtp-eml15.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750832AbYFMRKn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jun 2008 13:10:43 -0400
In-Reply-To: <4852A6D0.8030607@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, nico@cam.org, buytenh@wantstofly.org, Byron Bradley <byron.bbradley@gmail.com>

On Friday 13 June 2008, Mark Lord wrote:
> > But on poweroff:
> >
> > Will now halt.
> > sd 0:0:0:0: [sda] Synchronizing SCSI cache
> > sd 0:0:0:0: [sda] Stopping disk
> > Power down.
> > qnap_ts209_power_off: triggering power-off...
> > ata1: exception Emask 0=EF=BF=BD
> >
> > So no sign of anything getting called here.
>
> Mmm.. I suppose .remove() is not supposed to be called, then.
> What does happen, is sd_shutdown() runs ("Stopping disk"),
> and that's that.
>
> Weird.  I'd have thought there'd be a call somewhere to .port_stop()
> or even .host_stop() on shutdown, but I don't see one anywhere.

One additional note: this does look like a regression from 2.6.25 which=
=20
does _not_ show the last line on poweroff.
