From: Tejun Heo <htejun@gmail.com>
Subject: Re: Infinite loop on MODE-SENSE with a removable ATAPI sata device
 on VIA chipset
Date: Thu, 11 May 2006 00:26:22 +0900
Message-ID: <4462061E.5030007@gmail.com>
References: <E656D53DA4B96C409683999F573A360723E559@sbs.ARCO.local> <446205DF.3050706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.207]:44213 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751463AbWEJP02 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 May 2006 11:26:28 -0400
Received: by wx-out-0102.google.com with SMTP id t16so1270267wxc
        for <linux-ide@vger.kernel.org>; Wed, 10 May 2006 08:26:27 -0700 (PDT)
In-Reply-To: <446205DF.3050706@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dario Oliva <DOliva@ARCOIDE.COM>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Dario Oliva wrote:
>> Tejun Heo wrote:
>>
>>> None attached. :)
>>
>> Oops.
>>> I asked the model because plexstor list some of their drives as PIO
>> only with VIA controllers.  I don't know why.  But
>>> VIA + plextor combination seems to have some problems and your problem
>> might be a similar one.
>>> Have you tried the drive with other controllers?
>>
>> Yes, we have tried other controllers, mainly Intel and nvidia. No
>> problems with either one. Only the motherboard with the VIA controller
>> gives the problem.
>>
> 
> Seems to be the same problem.  You can force PIO mode by adding your 
> device's ID to ata_dma_list[] in libata-core.c.  It will force PIO mode

s/ata_dma_list/ata_dma_blacklist/ of course.

-- 
tejun
