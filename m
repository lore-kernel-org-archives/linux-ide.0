From: Ric Wheeler <ric@emc.com>
Subject: Re: [PATCH 2/2] libata: turn off NCQ if queue depth is adjusted to
  1
Date: Sun, 01 Oct 2006 08:56:28 -0400
Message-ID: <451FBAFC.4040001@emc.com>
References: <20060930104439.GP25800@htj.dyndns.org> <20060930104500.GQ25800@htj.dyndns.org> <20060930180359.GP4163@kernel.dk> <1159649460.13029.145.camel@localhost.localdomain> <20060930202628.GF5670@kernel.dk> <451F0927.2010804@emc.com> <451F0BF7.1000200@gmail.com> <451F1148.5050604@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([128.222.32.20]:1118 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S932164AbWJAM5y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Oct 2006 08:57:54 -0400
In-Reply-To: <451F1148.5050604@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org


Ric Wheeler wrote:

>
> Tejun Heo wrote:
>
>>
>> Ric, can you press harddisk vendors hard enough such that those model 
>> and revision numbers squeeze out of them?
>>
>> Thanks.
>
>
> I will certainly push to get drive vendors to work with us on this. It 
> is in everyone's interest to have the drives avoid stressing features 
> that are not stable ;-)
>
> Even better, we can usually try to work the bugs out with vendors 
> before the drives become public which should help minimize the issues.
>
Just thinking out loud, but it would be really helpful to get drive 
vendor's a basic set of tests for Linux systems -  error handling, 
performance, SMART features, etc - that would run natively on linux. 

We would need to get something really easy to deploy, like a live CD 
image with the test suite that could be booted on a pc, to get into an 
environment that is used to booting DOS based floppies...


