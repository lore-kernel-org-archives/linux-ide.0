From: "Arve Knudsen" <aknuds-1@broadpark.no>
Subject: Re: System freeze when transferring large files (libata)
Date: Sat, 10 Jul 2004 18:52:45 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <opsaxk57cgfmr65f@mail.broadpark.no>
References: <opsavn7spjfmr65f@mail.broadpark.no> <opsaxaq20rfmr65f@mail.broadpark.no> <40EFEAE4.3060201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.broadpark.no ([217.13.4.2]:52950 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S266296AbUGJQvR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Jul 2004 12:51:17 -0400
In-Reply-To: <40EFEAE4.3060201@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sat, 10 Jul 2004 09:11:00 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:

> Arve Knudsen wrote:
>> I thought I'd add that this is on an Asus A7N8X-X motherboard, and the   
>> filesystem is ext3.
>>  On Fri, 09 Jul 2004 18:03:18 +0200, Arve Knudsen  
>> <aknuds-1@broadpark.no>  wrote:
>>
>>> I've been having this problem lately when transferring large amounts  
>>> of  data to my Maxtor DiamondMax Plus 9 SATA 120GB drive, which is  
>>> connected  to a Promise SATA150 TX2 Plus controller. It happened once  
>>> with an -mm  kernel, but I figured it was probably down to instability  
>>> in the -mm  patchset. However it just happened to me again with a  
>>> vanilla 2.6.6  kernel, when untarring a backup. The system froze  
>>> completely, I couldn't  even use alt+sysrq+b to reboot. Are there any  
>>> known issues with the  Promise driver that can lead to such lockups?  
>>> I've recently run a disc  check which found no problems (it wasn't  
>>> Maxtor's own though, but  Seagate's as the Maxtor tools won't work  
>>> with the controller).
>
>
> No known bugs at least.  Promise seems to be more stable than most, in  
> fact.
>
> Maybe you have an intermittent problem with your SATA cables.

I've reproduced the error after untarring approximately 1.7GB to the  
Maxtor disk (after adding noapic and nolapic to my kernel parameters, as  
suggested by Patrick Dreker), but I was able to untar 12GB to my Seagate  
disk (the main drive) successfully on the same controller. I will try to  
swap cables/ports later, and see if writing to the Maxtor still hangs.

Question: Is it possible to have the kernel abort an i/o operation which  
is obviously stuck, so that a possible disk problem doesn't cause the  
whole system to hang?

Thanks

Arve Knudsen
