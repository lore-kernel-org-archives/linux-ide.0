From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: Infinite loop on MODE-SENSE with a removable ATAPI sata device
 on VIA chipset
Date: Thu, 11 May 2006 09:57:09 +0800
Message-ID: <446299F5.8010008@tw.ibm.com>
References: <E656D53DA4B96C409683999F573A360723E559@sbs.ARCO.local> <446205DF.3050706@gmail.com> <4462061E.5030007@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:8913 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965118AbWEKB5a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 May 2006 21:57:30 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4B1vMpF000873
	for <linux-ide@vger.kernel.org>; Wed, 10 May 2006 21:57:22 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4B1vLYQ239820
	for <linux-ide@vger.kernel.org>; Wed, 10 May 2006 19:57:21 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k4B1vLHV017177
	for <linux-ide@vger.kernel.org>; Wed, 10 May 2006 19:57:21 -0600
In-Reply-To: <4462061E.5030007@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Dario Oliva <DOliva@ARCOIDE.COM>, jgarzik@pobox.com, linux-ide@vger.kernel.org, =?ISO-8859-1?Q?Reinhard_Brandst=E4dter?= <r.brandstaedter@gmx.at>

Tejun Heo wrote:
> Tejun Heo wrote:
> 
>> Dario Oliva wrote:
>>
>>> Tejun Heo wrote:
>>>
>>>> I asked the model because plexstor list some of their drives as PIO
>>>
>>> only with VIA controllers.  I don't know why.  But
>>>
>>>> VIA + plextor combination seems to have some problems and your problem
>>>
>>> might be a similar one.
>>>
>>>> Have you tried the drive with other controllers?
>>>
>>>
>>> Yes, we have tried other controllers, mainly Intel and nvidia. No
>>> problems with either one. Only the motherboard with the VIA controller
>>> gives the problem.
>>>
>>
>> Seems to be the same problem.  You can force PIO mode by adding your
>> device's ID to ata_dma_list[] in libata-core.c.  It will force PIO mode
> 
> 
> s/ata_dma_list/ata_dma_blacklist/ of course.
> 

I've gotten a VIA VT6421 adapter. Will try to test it with some ATAPI devices
for this problem.

--
albert


