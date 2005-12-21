From: Terrence Martin <tmartin@physics.ucsd.edu>
Subject: Re: Kernel or patch suggestions for DMA enables Marvell Driver
Date: Wed, 21 Dec 2005 12:26:53 -0800
Message-ID: <43A9BA8D.9040200@physics.ucsd.edu>
References: <43A86AF2.2080508@physics.ucsd.edu> <E1EooUH-0008VA-Vj@highlab.com> <43A87273.2060403@physics.ucsd.edu> <43A88218.1040205@physics.ucsd.edu> <E1Eoq94-00009u-SS@highlab.com> <43A8BF6B.1090006@physics.ucsd.edu> <Pine.LNX.4.63.0512211451500.7522@dingo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from newport.ucsd.edu ([132.239.73.89]:385 "EHLO newport.ucsd.edu")
	by vger.kernel.org with ESMTP id S932497AbVLUU1B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Dec 2005 15:27:01 -0500
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
I am not sure if the email I sent got through. I am resending the 
motherboard info as well as I have some good news.

The are three motherboards

Supermicro X6DVL-EG2 EM64T
Supermicro X6DHR-TG EM64T
Supermicro  H8DAR-T Opteron

So I compiled 2.6.15-r5 without MSI enabled. The system booted and the 
disks are up and running. hdparm gives 65MB/s for a single disk. I am 
going to raid0 these disks and see what I can get when actually writing 
data.

Looking at MSI though it seems to indicate that without it I cannot get 
PCI-Express to work? It is not critical but I would like to be able to 
use PCI-E on the motherboard that supports it (two PCI-E Slots). I am 
happy to help with figuring out why there is this incompatibility with 
this feature.

Terrence

