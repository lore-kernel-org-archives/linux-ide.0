From: Tejun Heo <htejun@gmail.com>
Subject: Re: PROBLEM: Silicon Image 3112 Lockups
Date: Wed, 07 Sep 2005 11:42:08 +0900
Message-ID: <431E5380.8010601@gmail.com>
References: <Pine.LNX.4.63.0509061835230.2270@xmission.xmission.com> <431E4A0A.3060504@gmail.com> <431E4CDA.6090909@pobox.com> <431E519A.2090905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:38264 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750798AbVIGCmO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Sep 2005 22:42:14 -0400
Received: by zproxy.gmail.com with SMTP id 13so1114626nzn
        for <linux-ide@vger.kernel.org>; Tue, 06 Sep 2005 19:42:14 -0700 (PDT)
In-Reply-To: <431E519A.2090905@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jeremy Smith <alceste@xmission.com>, Alexander Shaposhnikov <shaposh@isp.nsc.ru>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Paul Taylor <Paul.Taylor@siliconimage.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
> 
>> Tejun Heo wrote:
>>
>>>  In the following mail, I've attached a patch which might alleviate 
>>> errors during writes (as Alexander was reporting CRC errors with 
>>> write commands), but it won't do any good if you're getting errors 
>>> during reading.
>>>
>>> http://marc.theaimsgroup.com/?l=linux-ide&m=112602112819183&w=2
>>
>>
>>
>> Note that I would put BIG CAPITAL LETTER WARNINGS on that patch, since 
>> it messes with the voltage.
>>
> 
>  Alexander & Jeremy.
> 
>  It's as Jeff said.
> 
>  TRY THE PATCH AT YOUR OWN RISK.  IT MIGHT FRY PHY OF YOUR DRIVE. 
> (enough capitals?)
> 
>  Even if you're brave enough to try, DO NOT GO OVER 600mV.  600mV is at 
> least inside specified limits.  Also, it won't change anything regarding 
> read errors.  All it does is increasing voltage swing while transmitting 
> data (writes).

  Oh.. it might affect writes if errors are occurring due to CRC errors 
during command trasmit.  If you're getting ABRT errors instead of 
ICRC's, it might indicate that commands are being mistransferred (again, 
I'm not sure at all).

-- 
tejun
