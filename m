From: "Arve Knudsen" <aknuds-1@broadpark.no>
Subject: Re: System freeze when transferring large files (libata)
Date: Mon, 12 Jul 2004 15:44:02 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <opsa01rofkfmr65f@mail.broadpark.no>
References: <opsavn7spjfmr65f@mail.broadpark.no> <opsaxaq20rfmr65f@mail.broadpark.no> <40EFEAE4.3060201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.broadpark.no ([217.13.4.2]:5099 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S266837AbUGLNmZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jul 2004 09:42:25 -0400
Received: from mail.broadpark.no (37.80-203-48.nextgentel.com [80.203.48.37])
	by mail.broadpark.no (Postfix) with ESMTP id 44C612B59
	for <linux-ide@vger.kernel.org>; Mon, 12 Jul 2004 15:42:54 +0200 (MEST)
In-Reply-To: <40EFEAE4.3060201@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I switched ports/cables, and lockup (DMA timeout) still occurs with the  
Maxtor only. I take it we can rule out the possibility of a quirk related  
to the combination Promise/Maxtor? Looks like I'll be replacing this drive  
with a Seagate soon.

Regards

Arve Knudsen

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
>
> 	Jeff
>
>


