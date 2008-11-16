From: Harri Olin <harri.olin@gmail.com>
Subject: Re: sata_mv, io stucks
Date: Sun, 16 Nov 2008 14:35:13 +0200
Message-ID: <49201381.9020704@gmail.com>
References: <48F88449.1000704@ngs.ru> <49003B9C.1010303@ngs.ru> <4900A12F.3030307@rtr.ca> <491EE84B.1010600@gmail.com> <491F4096.9090701@rtr.ca> <491F5E42.8010906@gmail.com> <491FA4D8.1010708@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:41046 "EHLO
	gw01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbYKPMfV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Nov 2008 07:35:21 -0500
In-Reply-To: <491FA4D8.1010708@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, Artem Bokhan <aptem@ngs.ru>

Mark Lord wrote:
> Harri Olin wrote:
> ..
>>>>>>> Two marvell controllers, 16 disks, software raid10, IO stucks on 
>>>>>>> different disks, kernel 2.6.26.5.
>>>>>>> With default ubuntu's 8.04 2.6.24 kernel the problem can not be 
>>>>>>> repeated
> This could very well be due to one/several of the as-yet un-addressed
> chipset errata for the 6081.  Someday we'll have software workarounds
> for those, but I'm (still) waiting on Marvell for stuff.
>

I was going through logs for the last night and noticed something:
Currently I have only 7 disks connected to 6081 controller, port 5 is 
free, and now stalls have been happening only on ports 0, 2 and 3. So it 
seems something on high port is affecting corresponding lower port too.

> Harri / Artem:  what type/speed of slots are your 6081 controllers in?
> PCI, or PCI-X?   Bus speed?
>

As mentioned earlier, 33MHz, 66MHz and 133MHz. Motherboards are: some 
Asus board with VIA chipset, Supermicro P4SCI and Supermicro X7SBE. I 
think P4SCI has 66MHz 64bit PCI, not PCI-X.

-- 
Harri.

