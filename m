From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [RFC][PATCH 0/3] OF-platform PATA driver
Date: Sat, 24 Nov 2007 05:35:32 +0300
Message-ID: <20071124053532.0e7cc322@kernel.crashing.org>
References: <20071123175229.GA27143@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41333 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753354AbXKXCf7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 21:35:59 -0500
In-Reply-To: <20071123175229.GA27143@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Fri, 23 Nov 2007 20:52:29 +0300
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
> 

I vote for of_platform_device, since we seem to dodge the clash
with platform_device here.

The code looks good, so I'm going to ack all 3 patches and if there will
be no more nagging, I'm inclined to ask Kumar to queue this for the next merge window.



-- 
Sincerely, Vitaly
