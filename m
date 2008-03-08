From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problem with ahci and a external sata disk
Date: Sat, 08 Mar 2008 09:42:46 +0900
Message-ID: <47D1E106.2020501@gmail.com>
References: <200802191646.39277.jareguero@telefonica.net> <200803071403.43113.jareguero@telefonica.net> <200803071515.43686.jareguero@telefonica.net> <200803072333.12877.jareguero@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:34517 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbYCHAmx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Mar 2008 19:42:53 -0500
Received: by rv-out-0910.google.com with SMTP id k20so397233rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 07 Mar 2008 16:42:52 -0800 (PST)
In-Reply-To: <200803072333.12877.jareguero@telefonica.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jose Alberto Reguero <jareguero@telefonica.net>
Cc: linux-ide@vger.kernel.org

Jose Alberto Reguero wrote:
>> I noticed that :
>>   R/W multiple sector transfer: Max = 1   Current = 0
>>
>> It is important?

Nope, it's just for PIOs.

> I did more tests. I put:
> 
> options libata force=4:1.5g,udma0
> 
> and the ICRC errors still appear. But only writing. I try with the device at 
> top speed(3G) and reading the errors don't appear.

UDMA mode shouldn't affect anything unless the drive is actually PATA
bridged over SATA and configuring lower UDMA mode makes it transfer data
slower and changes transfer pattern on the link.

> Another thing is that when limiting the speed to 1.5G, the real read speed 
> don't seem to change and is about 2 times the read speed that I have with a 
> SATA-I device. Is like limiting the speed to 1.5G don't do nothing. 

1.5Gbps means 150Mbytes/s and harddrives are yet to reach such
performance level, so 1.5 or 3.0 doesn't really make any difference
performance-wise yet.

> I will try the disk in a SATA-I port.

Can you also give a shot at shorter cable?

Thanks.

-- 
tejun
