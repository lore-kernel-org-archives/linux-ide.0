From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Promise SX4[-M]
Date: Wed, 19 Oct 2005 22:58:02 -0400
Message-ID: <435707BA.4050104@pobox.com>
References: <435703BE.602@latech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:33448 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751714AbVJTC6I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Oct 2005 22:58:08 -0400
In-Reply-To: <435703BE.602@latech.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ryan Bourgeois <rgb005@latech.edu>
Cc: Linux IDE Mailing List <linux-ide@vger.kernel.org>

Ryan Bourgeois wrote:
> What's the latest status on the Promise SX4 cards?  Has anyone looked 
> into employing the onboard DRAM for anything yet?  I remember at one 
> point we had a nice little dialog going about this card, but I don't 
> know that it really amounted to anything.
> 
> Jeff, if nobody has done anything with this since back whenever, you 
> could pass to me what documentation you have for it and some of the 
> ideas you had for this card and I can see what I can do.  I think it'd 
> be an interesting project for me to start, time permitting.

NDAs (legal stuff) prevents passing around documentation.

I can certainly summarize what is public in the sata_sx4.c driver:

* one ATA engine per port, for executing ATA commands.
* each ATA engine operates on data in on-board RAM
* one HDMA engine, for copying data between host RAM and board RAM
* since there is only one HDMA engine but four ATA engines, its a bit of 
a bottleneck
* no SATA controls, the board uses PATA chips with a SATA bridge
* driver code uses a static memory layout I designed.  This will need to 
  be changed to a dynamic layout, most likely.

I can certainly answer any questions about the driver, and can answer 
questions about the hardware when it pertains to information necessary 
to develop and maintain the open source driver.

	Jeff


