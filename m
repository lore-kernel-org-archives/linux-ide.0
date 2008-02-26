From: Mark Lord <liml@rtr.ca>
Subject: Re: Sata-MV, Intergated Sata Device Support
Date: Tue, 26 Feb 2008 10:55:01 -0500
Message-ID: <47C43655.1050907@rtr.ca>
References: <1176673884.5109.30.camel@Desktop> <47C35203.20402@garzik.org> <47C3585D.8070701@rtr.ca> <47C35A85.3020307@garzik.org> <alpine.DEB.0.99.0802260024400.22022@ubuntu-saeed.il.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3485 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027AbYBZPwF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Feb 2008 10:52:05 -0500
In-Reply-To: <alpine.DEB.0.99.0802260024400.22022@ubuntu-saeed.il.marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed <saeed@marvell.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, jon@ngndg.com, LKML <linux-kernel@vger.kernel.org>

saeed wrote:
> 
> On Mon, 25 Feb 2008, Jeff Garzik wrote:
> 
>>> ...
>>>
>>> Saeed:  isn't this what your SOC patches already implemented for us?
>>> As near as I can tell, sata_mv now already has support for the 60x1C0.
>> Saeed's stuff didn't support PCI though, and Jon Li is definitely talking
>> about PCI...
> yes, my patch added support for the SoC sata like in the 5182, and this 
> is what Jon Li was concerned about. he mentioneded the 60x1C0 pci device 
> just to suggest to use it's code for the SoC sata as it is very similar.
..

I don't think I understand your english there.

Does the current sata_mv driver work as-is with the chipset this person wants?
If not, then exactly what has to change to make it work?

Thanks
