From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: System freeze when transferring large files (libata)
Date: Sat, 10 Jul 2004 09:11:00 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40EFEAE4.3060201@pobox.com>
References: <opsavn7spjfmr65f@mail.broadpark.no> <opsaxaq20rfmr65f@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8412 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266244AbUGJNL0
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Jul 2004 09:11:26 -0400
In-Reply-To: <opsaxaq20rfmr65f@mail.broadpark.no>
List-Id: linux-ide@vger.kernel.org
To: Arve Knudsen <aknuds-1@broadpark.no>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Arve Knudsen wrote:
> I thought I'd add that this is on an Asus A7N8X-X motherboard, and the  
> filesystem is ext3.
> 
> On Fri, 09 Jul 2004 18:03:18 +0200, Arve Knudsen 
> <aknuds-1@broadpark.no>  wrote:
> 
>> I've been having this problem lately when transferring large amounts 
>> of  data to my Maxtor DiamondMax Plus 9 SATA 120GB drive, which is 
>> connected  to a Promise SATA150 TX2 Plus controller. It happened once 
>> with an -mm  kernel, but I figured it was probably down to instability 
>> in the -mm  patchset. However it just happened to me again with a 
>> vanilla 2.6.6  kernel, when untarring a backup. The system froze 
>> completely, I couldn't  even use alt+sysrq+b to reboot. Are there any 
>> known issues with the  Promise driver that can lead to such lockups? 
>> I've recently run a disc  check which found no problems (it wasn't 
>> Maxtor's own though, but  Seagate's as the Maxtor tools won't work 
>> with the controller).


No known bugs at least.  Promise seems to be more stable than most, in fact.

Maybe you have an intermittent problem with your SATA cables.

	Jeff


