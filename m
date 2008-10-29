From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] cmd64x: set IDE_HFLAG_SERIALIZE explictly for CMD646
Date: Thu, 30 Oct 2008 02:31:12 +0300
Message-ID: <4908F240.2020606@ru.mvista.com>
References: <200810272058.54522.bzolnier@gmail.com> <200810292242.39729.bzolnier@gmail.com> <4908EACC.5060601@ru.mvista.com> <200810300010.06303.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:2401 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753025AbYJ2XbS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Oct 2008 19:31:18 -0400
In-Reply-To: <200810300010.06303.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>>>>> * Set IDE_HFLAG_SERIALIZE explictly for CMD646.
>>>>>>>           
>>>>>>>               
>>>>>>  Was that some kernel.org bug that this is fixing?
>>>>>>         
>>>>>>             
>>>>> Nope (AFAIK).
>>>>>       
>>>>>           
>>>>     User report then?
>>>>     
>>>>         
>>> Nope as far as my inbox tells me.
>>>   
>>>       
>>    Then whar's the reason? :-)
>>     
>
> From the patch description:
>
> 	* Set IDE_HFLAG_SERIALIZE explictly for CMD646.
>
> 	* Remove no longer needed ide_cmd646 chipset type (which has
> 	  a nice side-effect of fixing handling of unexpected IRQs).
>
> The latter is possible because of the former
> (see ide-probe.c::init_irq() for details).
>   

   Ah, got it at last. But I doubt that 646 *really* needs serialization...

MBR, Sergei


