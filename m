From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC][PATCH 0/3] OF-platform PATA driver
Date: Fri, 23 Nov 2007 19:49:33 -0500
Message-ID: <4747751D.4060802@garzik.org>
References: <20071123175229.GA27143@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50922 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588AbXKXAtk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 19:49:40 -0500
In-Reply-To: <20071123175229.GA27143@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

Anton Vorontsov wrote:
> Hi all,
> 
> Here is the PATA Platform driver using OF infrastructure.
> 
> Mostly it's just a wrapper around a bit modified pata_platform
> driver.
> 
> Patches are well split for the easier review:
> 
> First one factors out platform_device specific bits and modifies
> pata_platform to be a library-alike driver (with platform_device
> default binding).
> 
> Second patch is OF-driver itself which is using pata_platform
> "library".
> 
> Third patch is PowerPC specific, but I'm still Cc'ing linux-ide,
> just to show how we're using it.
> 
> 
> As an alternative approach we can use plain pata_platform
> driver, but I'm not sure how Linux OF bindings' ideologists will
> or will not like it.
> 
> So, these patches are strongly Request For Comments. Feel free
> to train your nitpicking skills ;-), and/or vote for the option
> you most pleased about (or suggest another?).

Seems reasonable from a libata point of view...


(pata_platform maintainer CC'd)

	Jeff


