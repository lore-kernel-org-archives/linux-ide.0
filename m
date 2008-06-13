From: Nicolas Pitre <nico@cam.org>
Subject: Re: sata_mv on Orion: mv_err_intr when shutting down
Date: Fri, 13 Jun 2008 15:01:03 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806131459130.23110@xanadu.home>
References: <20080512132611.GA15410@deprecation.cyrius.com>
 <200806131812.38055.elendil@planet.nl> <4852A6D0.8030607@rtr.ca>
 <200806131910.40516.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:58665 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbYFMTBT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jun 2008 15:01:19 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K2F00BH30TR3XO0@VL-MH-MR002.ip.videotron.ca> for
 linux-ide@vger.kernel.org; Fri, 13 Jun 2008 15:01:03 -0400 (EDT)
In-reply-to: <200806131910.40516.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, buytenh@wantstofly.org, Byron Bradley <byron.bbradley@gmail.com>

On Fri, 13 Jun 2008, Frans Pop wrote:

> On Friday 13 June 2008, Mark Lord wrote:
> > > But on poweroff:
> > >
> > > Will now halt.
> > > sd 0:0:0:0: [sda] Synchronizing SCSI cache
> > > sd 0:0:0:0: [sda] Stopping disk
> > > Power down.
> > > qnap_ts209_power_off: triggering power-off...
> > > ata1: exception Emask 0???
> > >
> > > So no sign of anything getting called here.
> >
> > Mmm.. I suppose .remove() is not supposed to be called, then.
> > What does happen, is sd_shutdown() runs ("Stopping disk"),
> > and that's that.
> >
> > Weird.  I'd have thought there'd be a call somewhere to .port_stop()
> > or even .host_stop() on shutdown, but I don't see one anywhere.
> 
> One additional note: this does look like a regression from 2.6.25 which 
> does _not_ show the last line on poweroff.

FWIW, I also see that partial "exception Emask"message whenever power to 
the device is abruptly removed.


Nicolas
