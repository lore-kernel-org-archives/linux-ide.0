From: Terrence Martin <tmartin@physics.ucsd.edu>
Subject: Re: Kernel or patch suggestions for DMA enables Marvell Driver
Date: Wed, 21 Dec 2005 10:15:51 -0800
Message-ID: <43A99BD7.3060802@physics.ucsd.edu>
References: <43A86AF2.2080508@physics.ucsd.edu> <E1EooUH-0008VA-Vj@highlab.com> <43A87273.2060403@physics.ucsd.edu> <43A88218.1040205@physics.ucsd.edu> <E1Eoq94-00009u-SS@highlab.com> <43A8BF6B.1090006@physics.ucsd.edu> <Pine.LNX.4.63.0512211451500.7522@dingo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from newport.ucsd.edu ([132.239.73.89]:59629 "EHLO newport.ucsd.edu")
	by vger.kernel.org with ESMTP id S932485AbVLUSP5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Dec 2005 13:15:57 -0500
In-Reply-To: <Pine.LNX.4.63.0512211451500.7522@dingo.iwr.uni-heidelberg.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Cc: Sebastian Kuzminsky <seb@highlab.com>, linux-ide@vger.kernel.org

Bogdan Costescu wrote:
> On Tue, 20 Dec 2005, Terrence Martin wrote:
>
>> sata_mv 0000:03:04.0: 32 slots 4 ports unknown mode IRQ via MSI
>
> This line seems to suggest that you have MSI enabled in your kernel 
> config. Both me and Jeff Garzik had to disable it in order to get the 
> driver to work with our Marvell controllers. However, your log shows 
> the driver proceeding further than in my case, so maybe you have a 
> setup that would allow using MSI - what mainboard is this ? (you 
> mentioned Supermicro, but not the model number, unless I missed it...)
>
These are X6DHR-TG and X6DVL-EG2

I also have a similar problem with my Supermicro opterons which as far 
as I can tell have the same controllers. The opterons are H8DAR-T

I can disable MSI and see if that helps.

Terrence






