From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/3] libata: prefix sata register print outs with 0x
Date: Wed, 12 Apr 2006 10:20:46 +0900
Message-ID: <443C55EE.9020009@gmail.com>
References: <1144761989558-git-send-email-htejun@gmail.com> <443BE634.7060406@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.205]:51998 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751246AbWDLBVC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 21:21:02 -0400
Received: by xproxy.gmail.com with SMTP id t10so912423wxc
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 18:20:59 -0700 (PDT)
In-Reply-To: <443BE634.7060406@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Prefix SStatus and SControl values with 0x as they are hex.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> NAK, libata always prints out device id, register, etc. values in hex. 
> Basically anything other than things like sectors or bytes is printed in 
> hex.  Therefore, the "0x" is largely redundant.
> 
> The prefix/base is implicit in the context.
> 

The reason why I submitted this patch was messages like the following...

ata2: SATA link down (SStatus 11 SControl 310)

When it was three digits, it was okay.  But two or just one digits look 
just weird.  Maybe what's needed is %03.

Well, no big deal either way.

-- 
tejun
