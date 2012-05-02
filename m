From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH] libata-eh don't waste time retrying media errors (v2)
Date: Wed, 02 May 2012 15:10:42 -0400
Message-ID: <4FA186B2.8010907@teksavvy.com>
References: <4FA043BE.2010009@teksavvy.com> <4FA04714.7050602@teksavvy.com> <20120501215854.GA21677@google.com> <4FA07655.6090506@teksavvy.com> <4FA07932.2090003@teksavvy.com> <4FA0A3F7.7000401@teksavvy.com> <20120502155414.GB21677@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport-out.teksavvy.com ([206.248.143.162]:2248 "EHLO
	ironport-out.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755608Ab2EBTKn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 May 2012 15:10:43 -0400
In-Reply-To: <20120502155414.GB21677@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On 12-05-02 11:54 AM, Tejun Heo wrote:
> On Tue, May 01, 2012 at 11:03:19PM -0400, Mark Lord wrote:
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
>> version 2; the original patch changed more than intended.
>>
>> --- linux/drivers/ata/libata-eh.c.orig	2012-04-27 13:17:35.000000000 -0400
>> +++ linux/drivers/ata/libata-eh.c	2012-05-01 22:40:00.182425015 -0400
>> @@ -2122,7 +2122,8 @@
>>  		if (qc->flags & ATA_QCFLAG_IO ||
>>  		    (!(qc->err_mask & AC_ERR_INVALID) &&
>>  		     qc->err_mask != AC_ERR_DEV))
>> -			qc->flags |= ATA_QCFLAG_RETRY;
>> +			if (!(qc->err_mask & AC_ERR_MEDIA))
>> +				qc->flags |= ATA_QCFLAG_RETRY;
> 
> It can be combined like the following,
> 
> 	if (!(qc->err_mask & AC_ERR_MEDIA) &&
> 	    (qc->flags & ATA_QCFLAG_IO ||
> 	     (!(qc->err_mask & AC_ERR_INVALID) &&
> 	      qc->err_mask != AC_ERR_DEV)))
> 
> which doesn't look any prettier.

Yeah, I considered that.  But really a bit main reason it looks fugly
is the historical insistence on wrapping lines longer than 80 chars.

		if (qc->flags & ATA_QCFLAG_IO ||
		 (!(qc->err_mask & AC_ERR_INVALID) && qc->err_mask != AC_ERR_DEV))
			if (!(qc->err_mask & AC_ERR_MEDIA))
				qc->flags |= ATA_QCFLAG_RETRY;

Anything else I try there ends up just as ugly.  :)
