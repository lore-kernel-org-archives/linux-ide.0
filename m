From: Ian Leonard <ian@smallworld.cx>
Subject: Re: Highpoint & ide probing problem
Date: Fri, 17 Sep 2004 09:06:18 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <414A9AFA.7060403@smallworld.cx>
References: <4147EDDD.8030001@smallworld.cx> <41483BB0.9090401@latech.edu> <41484A89.1030404@smallworld.cx> <4148B3CC.5010605@latech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:9599 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S268568AbUIQIGT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Sep 2004 04:06:19 -0400
In-Reply-To: <4148B3CC.5010605@latech.edu>
List-Id: linux-ide@vger.kernel.org
To: Ryan Bourgeois <rgb005@latech.edu>
Cc: linux-ide@vger.kernel.org

Ryan Bourgeois wrote:
> Alright, you don't have to worry about RAID anyway, so you're set 
> there.    I assume the onboard controller is handled by the PIIXn 
> (CONFIG_BLK_DEV_PIIX) driver since it's standard Intel.  The Highpoint 

Yes I have.

> controller will definately be handled by the HPT36X/37X driver 
> (CONFIG_BLK_DEV_HPT366).
> If your kernel is not configured with support for the above, you need to 
> do so, especially the HPT driver, as generic support is unlikely to work 
> properly with the Highpoint (didn't work right for my Highpoint).
> 
> Apparently Itox does not provide the manual for this mobo via their 
> website, so I can't help you with BIOS settings that may be proprietary 
> to that board.  None of the boards I've experience with mention "auto" 
> or "enhanced mode" for SATA controllers, so I don't know what these 
> settings imply for software configuration.

Strange, all the ones I have see do. That doesn't mean I know what they 
do - I have never seen a full description. However it has something to 
do with the relationship with the PATA and SATA drives. I would guess 
that an old driver may only handle 4 drives (not the full compliment of 
8, or in my case 10) so the bios specifies which ones you want to use. 
An enhanced driver allows all.

It would appear the Highpoint driver isn't getting this right.

> If it is the case that your kernel is configured as per above, then this 
> definately needs to be CC'd to the list (I've done so) for other 
> suggestions, as at the moment I can't think of anything.  I know, I 
> dried up quickly, but my brain is offline at the moment...
> 
> Sorry I couldn't be of more help, but hey, I tried  >8)

Indeed you did, and I thank you for that. Do you think I should copy 
this to the main list?



-- 
Ian Leonard

Please ignore spelling and punctuation - I did.
