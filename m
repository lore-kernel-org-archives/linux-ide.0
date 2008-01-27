From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: Linux 2.6.24 sata_promise SATA300TX4 problems
Date: Sun, 27 Jan 2008 18:32:52 +0100
Message-ID: <479CC044.8010401@how.dk>
References: <479B0A39.2050700@how.dk>	<18331.53035.493189.308501@harpo.it.uu.se>	<479BD2E2.2060307@how.dk> <18331.59497.908868.283142@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:53415 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbYA0Rcz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 12:32:55 -0500
In-Reply-To: <18331.59497.908868.283142@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Hi Mikael,

Thanks!

It works perfectly at 1.5Gbps :-)

I think that because it fails at 3Gbps it might eventually fail at 
1.5Gbps also... And the error handling was not robust (in my setup with 
these drives at 3Gbps).

If I can help investigate further, I'm happy to do that. I have a spare 
controller card so I could try swapping them.  Do you have any 
suggestions for what I should try next?

Best regards,

Peter

Mikael Pettersson wrote:
> Peter Favrholdt writes:
>  > If it is not too much of a hassle, could you please make a 1.5Gbps patch 
>  > for 2.6.24 for me to try out? If it solves the problem (without me ever 
>  > touching the cables) we know for sure it is speed-related and not due to 
>  > kernel version.
> 
> No problem. I had intended to drop that patch after 2.6.24-rc8 as it
> ought to be obsolete, but then again it might not be. It's available here:
> <http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-limit-sataii-to-1.5Gbps-2.6.24>

