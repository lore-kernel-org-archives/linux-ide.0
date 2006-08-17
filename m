From: Roger Heflin <rheflin@atipa.com>
Subject: Re: What determines which interrupts are shared under Linux?
Date: Thu, 17 Aug 2006 08:18:52 -0500
Message-ID: <44E46CBC.6060500@atipa.com>
References: <44E1D760.6070600@atipa.com>	 <1155654379.24077.286.camel@localhost.localdomain>	 <44E1E719.6020005@atipa.com>	 <1155657316.24077.293.camel@localhost.localdomain>	 <44E208AD.8060505@atipa.com>  <44E3A22F.20400@rtr.ca> <1155775180.15195.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 125.14.cm.sunflower.com ([24.124.14.125]:61466 "EHLO
	mail.atipa.com") by vger.kernel.org with ESMTP id S932468AbWHQNSo
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Aug 2006 09:18:44 -0400
In-Reply-To: <1155775180.15195.16.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
> Ar Mer, 2006-08-16 am 18:54 -0400, ysgrifennodd Mark Lord:
>> Roger Heflin wrote:
>>> It looks like the older DMA recovery code never works on this chipset,
>>> once it goes into DMA recovery it never comes out of it. 
> 
> DMA recovery is fairly broken in drivers/ide especially if it tries to
> change mode. libata does not have this problem and I have no plans to
> even try and fix the drivers/ide code for this issue as its a major
> piece of work.
> 
> 

If already figured that since I was pretty sure all of it was
being rolled to libata.   I was able to switch that controller and
disk to the libata sata_nv.

                                 Roger
