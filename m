From: Ric Wheeler <ric@emc.com>
Subject: Re: [PATCH 2/2] libata: turn off NCQ if queue depth is adjusted to
  1
Date: Sat, 30 Sep 2006 20:52:24 -0400
Message-ID: <451F1148.5050604@emc.com>
References: <20060930104439.GP25800@htj.dyndns.org> <20060930104500.GQ25800@htj.dyndns.org> <20060930180359.GP4163@kernel.dk> <1159649460.13029.145.camel@localhost.localdomain> <20060930202628.GF5670@kernel.dk> <451F0927.2010804@emc.com> <451F0BF7.1000200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([128.222.32.20]:22408 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751743AbWJAA6C (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Sep 2006 20:58:02 -0400
In-Reply-To: <451F0BF7.1000200@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org


Tejun Heo wrote:

> Ric Wheeler wrote:
>
>
>> We have to be careful with the blacklisting - specifically, drive 
>> model is often less critical than the version of the firmware (which 
>> gets updated as people work drives through qualification, etc).
>> Updating drive firmware for end users is pretty rare (and almost all 
>> tools are still DOS based ;-)).
>>
>> Certain drives should default to non-NCQ (based on model), but we 
>> should be able to enable it if the firmware supports it.
>>
>> Most of the newest drives are fine, but we will still need something 
>> like Tejun's fix to be able to turn it off for the odd cases that 
>> show up in certain odd applications, etc.
>
>
> Ric, can you press harddisk vendors hard enough such that those model 
> and revision numbers squeeze out of them?
>
> Thanks.

I will certainly push to get drive vendors to work with us on this. It 
is in everyone's interest to have the drives avoid stressing features 
that are not stable ;-)

Even better, we can usually try to work the bugs out with vendors before 
the drives become public which should help minimize the issues.





