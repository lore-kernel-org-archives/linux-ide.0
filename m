From: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: IDE problems in 2.6.12-rc1-bk1 onwards (was Re: 2.6.12-rc3-mm1)
Date: Mon, 2 May 2005 13:24:29 +0100
Message-ID: <015d01c54f11$e5f3ddd0$0f01a8c0@max>
References: <03be01c54e77$83d86980$0f01a8c0@max> <58cb370e0505011141a2b3c58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tim.rpsys.net ([194.106.48.114]:64941 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261224AbVEBMYe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 May 2005 08:24:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz:
> Both problems should be fixed by "convert IDE device drivers to
> driver-model" patch but I need to resync it against latest kernels.

Thanks for the tip. I found that patch and applied the parts for the drivers 
I use. This cured the oops and also allowed "hot unplugging" to finally work 
under 2.6 for CF cards! Is there a timeline for when this goes into mainline 
and/or -mm?

I can still get an oops from the vfs layer if I try to access a card just 
after I remove it suggesting there are some timeout issues somewhere but 
this is a *massive* improvement on where things were before! I'm really 
pleased to see this :)

Thanks,

Richard 

