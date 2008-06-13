From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv on Orion: mv_err_intr when shutting down
Date: Fri, 13 Jun 2008 15:20:05 -0400
Message-ID: <4852C865.4080704@rtr.ca>
References: <20080512132611.GA15410@deprecation.cyrius.com> <200806131812.38055.elendil@planet.nl> <4852A6D0.8030607@rtr.ca> <200806131910.40516.elendil@planet.nl> <alpine.LFD.1.10.0806131459130.23110@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4125 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbYFMTUH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jun 2008 15:20:07 -0400
In-Reply-To: <alpine.LFD.1.10.0806131459130.23110@xanadu.home>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
Cc: Frans Pop <elendil@planet.nl>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, buytenh@wantstofly.org, Byron Bradley <byron.bbradley@gmail.com>

Nicolas Pitre wrote:
..
> FWIW, I also see that partial "exception Emask"message whenever power to 
> the device is abruptly removed.
..

Well, yes, you should see it.  That's what it is telling us ("power lost").

It's just kind of odd (but thus far harmless) to also see it at shutdown.
This indicates that the drive is being powered off
before the CPU is powered off -- perhaps a peculiarity of the platform ?

Cheers
