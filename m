From: Nicolas Pitre <nico@cam.org>
Subject: Re: sata_mv on Orion: mv_err_intr when shutting down
Date: Fri, 13 Jun 2008 15:31:47 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806131529131.23110@xanadu.home>
References: <20080512132611.GA15410@deprecation.cyrius.com>
 <200806131812.38055.elendil@planet.nl> <4852A6D0.8030607@rtr.ca>
 <200806131910.40516.elendil@planet.nl>
 <alpine.LFD.1.10.0806131459130.23110@xanadu.home> <4852C865.4080704@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:49023 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbYFMTb5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jun 2008 15:31:57 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K2F00C7428ZY290@VL-MO-MR004.ip.videotron.ca> for
 linux-ide@vger.kernel.org; Fri, 13 Jun 2008 15:31:47 -0400 (EDT)
In-reply-to: <4852C865.4080704@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Frans Pop <elendil@planet.nl>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Lennert Buytenhek <buytenh@wantstofly.org>, Byron Bradley <byron.bbradley@gmail.com>

On Fri, 13 Jun 2008, Mark Lord wrote:

> Nicolas Pitre wrote:
> ..
> > FWIW, I also see that partial "exception Emask"message whenever power to the
> > device is abruptly removed.
> ..
> 
> Well, yes, you should see it.  That's what it is telling us ("power lost").
> 
> It's just kind of odd (but thus far harmless) to also see it at shutdown.
> This indicates that the drive is being powered off
> before the CPU is powered off -- perhaps a peculiarity of the platform ?

It is well possible that the CPU is able to survive a few 
additional milliseconds on thin air after main power is out.


Nicolas
