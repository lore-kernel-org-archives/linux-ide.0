From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH] libata-eh don't waste time retrying media errors (v3)
Date: Wed, 02 May 2012 15:43:05 -0400
Message-ID: <4FA18E49.3040103@teksavvy.com>
References: <4FA043BE.2010009@teksavvy.com> <4FA04714.7050602@teksavvy.com> <20120501215854.GA21677@google.com> <4FA07655.6090506@teksavvy.com> <4FA07932.2090003@teksavvy.com> <4FA0A3F7.7000401@teksavvy.com> <20120502155414.GB21677@google.com> <4FA1898C.5070108@teksavvy.com> <20120502193343.GA6411@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport-out.teksavvy.com ([206.248.143.162]:28377 "EHLO
	ironport-out.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756978Ab2EBTnG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 May 2012 15:43:06 -0400
In-Reply-To: <20120502193343.GA6411@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On 12-05-02 03:33 PM, Tejun Heo wrote:
> On Wed, May 02, 2012 at 03:22:52PM -0400, Mark Lord wrote:
>> ATA and SATA drives have had built-in retries for media errors
>> for as long as they've been commonplace in computers (early 1990s).
>>
>> When libata stumbles across a bad sector, it can waste minutes
>> sitting there doing retry after retry before finally giving up
>> and letting the higher layers deal with it.
>>
>> This patch removes retries for media errors only.
>>
>> Signed-off-by: Mark Lord <mlord@pobox.com>
>> ---
>> version 3: try to improve readability.
>>
>> --- old/drivers/ata/libata-eh.c	2012-04-27 13:17:35.000000000 -0400
>> +++ linux/drivers/ata/libata-eh.c	2012-05-02 15:20:19.946827031 -0400
>> @@ -2046,6 +2046,26 @@
>>  }
>>
>>  /**
>> + *	ata_eh_worth_retry - analyze error and decide whether to retry
>> + *	@qc: qc to possibly retry
>> + *
>> + *	Look at the cause of the error and decide if a retry
>> + * 	might be useful or not.  We don't want to retry media errors
>> + *	because the drive itself has probably already taken 10-30 seconds
>> + *	doing its own internal retries before reporting the failure.
>> + */
>> +static inline int ata_eh_worth_retry(struct ata_queued_cmd *qc)
> 
> Return bool? && maybe split the patch into two - the first separating
> out the logic into a function, the latter changing emedia handling?

I think the two-liner from v2 is better.

Cheers
