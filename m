From: Terrence Martin <tmartin@physics.ucsd.edu>
Subject: Re: Interesting Performance with Marvell
Date: Wed, 21 Dec 2005 21:33:39 -0800
Message-ID: <43AA3AB3.404@physics.ucsd.edu>
References: <43A9FA5A.7000704@physics.ucsd.edu> <E1EpH5b-0001UY-D5@highlab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dsl093-032-179.snd1.dsl.speakeasy.net ([66.93.32.179]:61909
	"EHLO partlyharmless.local") by vger.kernel.org with ESMTP
	id S932382AbVLVFdj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Dec 2005 00:33:39 -0500
In-Reply-To: <E1EpH5b-0001UY-D5@highlab.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sebastian Kuzminsky <seb@highlab.com>
Cc: linux-ide@vger.kernel.org

Sebastian Kuzminsky wrote:

>Terrence Martin <tmartin@physics.ucsd.edu> wrote:
>  
>
>>Sebastian what are the mfg of the Marvell controller you are using?
>>    
>>
>
>Sonnet.  It's their "Tempo-X 8 SATA" card.  PCI-X, 8 external SATA
>ports and no internal ports.  I'll post performance numbers soon or
>after Newtonmas.
>
>Who made you 8-port card?
>
>
>  
>
Supermicro is the manufacturer of the board. As far as I can tell it is 
just a PCI-X SATA controller with the Marvell chipset driving 8 
interfaces. I am evaluating various SATA controllers, raid and non-raid 
to see if any actually can provide decent performance. So far 3ware 
9550SX is ok, the Areca 1110 is not that impressive using their driver 
at least. The Marvell 8 port addin card is comparable to the onboard 
Marvell 4 port for reads delivering 190MB/s but it is much slower on 
writes for some reason.

I know that drivers can make a significant difference. With 3ware 9500 
4LP cards the 3ware driver provides about twice the performance of the 
one that comes with redhats RHEL4.2 kernels. I have not tried kernel.org 
kernels on that card. 9550SX is a 3ware provided driver.

I just see a lot of variance between cards and cost seldom seems to 
indicate performance. The supermicro card is about $125US so is good 
value if I can figure out why the poor write performance compared to the 
onboard. The onboard I am happy with so far. My opterons have the 
marvell onboard as well, 4 port. I will be checking those next.

Terrence




