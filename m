From: Tejun Heo <htejun@gmail.com>
Subject: Re: PROBLEM: Silicon Image 3112 Lockups
Date: Wed, 07 Sep 2005 11:34:02 +0900
Message-ID: <431E519A.2090905@gmail.com>
References: <Pine.LNX.4.63.0509061835230.2270@xmission.xmission.com> <431E4A0A.3060504@gmail.com> <431E4CDA.6090909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.206]:48345 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750743AbVIGCeK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Sep 2005 22:34:10 -0400
Received: by wproxy.gmail.com with SMTP id i2so874383wra
        for <linux-ide@vger.kernel.org>; Tue, 06 Sep 2005 19:34:07 -0700 (PDT)
In-Reply-To: <431E4CDA.6090909@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jeremy Smith <alceste@xmission.com>, Alexander Shaposhnikov <shaposh@isp.nsc.ru>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Paul Taylor <Paul.Taylor@siliconimage.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>>  In the following mail, I've attached a patch which might alleviate 
>> errors during writes (as Alexander was reporting CRC errors with write 
>> commands), but it won't do any good if you're getting errors during 
>> reading.
>>
>> http://marc.theaimsgroup.com/?l=linux-ide&m=112602112819183&w=2
> 
> 
> Note that I would put BIG CAPITAL LETTER WARNINGS on that patch, since 
> it messes with the voltage.
> 

  Alexander & Jeremy.

  It's as Jeff said.

  TRY THE PATCH AT YOUR OWN RISK.  IT MIGHT FRY PHY OF YOUR DRIVE. 
(enough capitals?)

  Even if you're brave enough to try, DO NOT GO OVER 600mV.  600mV is at 
least inside specified limits.  Also, it won't change anything regarding 
read errors.  All it does is increasing voltage swing while transmitting 
data (writes).

  Thanks.

-- 
tejun
