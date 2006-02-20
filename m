From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: make ata_sg_setup_one() trim zero length sg
Date: Mon, 20 Feb 2006 05:16:47 -0500
Message-ID: <43F9970F.9010903@pobox.com>
References: <20060217075309.GA31835@htj.dyndns.org> <43F6416D.50807@pobox.com> <43F68809.8040700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:63696 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964835AbWBTKQv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 05:16:51 -0500
In-Reply-To: <43F68809.8040700@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
> 
>> Tejun Heo wrote:
>>
>>> This patch makes ata_sg_setup_one() trim sg entry (thus making
>>> qc->n_elem zero) if padding results in zero length sg entry.
>>>
>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>>
>>> ---
>>>
>>> Jeff, currently, in both sg_setup() and sg_setup_one() cases, zero
>>> length sg entry can reach low level driver fill_sg() function which
>>> could possibly cause weird problems.  This and a following patch kill
>>> such cases.
>>
>>
>>
>> Can you redo this series against vanilla upstream (and/or 
>> #upstream-fixes)?
>>
> 
> Hello, Jeff.
> 
> Actually, this series is already against the vanilla upstream[1].  The 
> order is...
> 
> libata: fix WARN_ON() condition in *_fill_sg() [2]
> libata: make ata_sg_setup_one() trim zero length sg [3]
> libata: fix qc->n_elem == 0 case handling in ata_qc_next_sg [4]

Sorry, I should have been more specific.

These changes should go into 2.6.16-rc, and should be based off the 
vanilla Linus tree.  Too many "vanilla upstreams" running around...

	Jeff




