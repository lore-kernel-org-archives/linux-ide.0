From: Kurt Roeckx <kurt@roeckx.be>
Subject: Re: sata_promise: Keeps saying SATA link down (SStatus 0 SControl
	0)
Date: Tue, 15 Jan 2008 18:35:57 +0100
Message-ID: <20080115173557.GA3033@roeckx.be>
References: <20080113234320.GA6225@roeckx.be> <18315.7567.747367.84127@harpo.it.uu.se> <20080115000953.GA2799@roeckx.be> <18316.31910.973794.732242@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yergi.telenet-ops.be ([195.130.132.36]:60277 "EHLO
	yergi.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbYAORgl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jan 2008 12:36:41 -0500
Received: from harold.telenet-ops.be (unknown [195.130.133.65])
	by yergi.telenet-ops.be (Postfix) with ESMTP id 7296B5C946F
	for <linux-ide@vger.kernel.org>; Tue, 15 Jan 2008 18:36:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <18316.31910.973794.732242@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

On Tue, Jan 15, 2008 at 10:28:06AM +0100, Mikael Pettersson wrote:
>  > 00:08.0 RAID bus controller: Promise Technology, Inc. PDC20376 (FastTrak 376) (rev 02)
> ...
>  > 00:08.0 0104: 105a:3376 (rev 02)
> 
> Let me guess, this is a Promise chip included on the mainboard
> as a RAID controller, and not an add-on PCI card?

Yes, it's a K8V motherboard which has that onboard.

> If it's a mainboard chip, please enter the BIOS and see if it
> can be configured for non-RAID mode. If it can, please reconfigure
> it and boot Linux. Does it still claim to be a 20376 or is it
> now a 20378?

I can't find an option to turn that off in the BIOS.  If it did, I'd
probably have turned it off already.  I've also opened the case and it
says PDC20376 on the chip.


Kurt

