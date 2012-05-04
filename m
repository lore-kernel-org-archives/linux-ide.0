From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-eh don't waste time retrying media errors (v3)
Date: Thu, 03 May 2012 22:25:49 -0400
Message-ID: <4FA33E2D.1040204@garzik.org>
References: <4FA043BE.2010009@teksavvy.com> <4FA04714.7050602@teksavvy.com> <20120501215854.GA21677@google.com> <4FA07655.6090506@teksavvy.com> <4FA07932.2090003@teksavvy.com> <4FA0A3F7.7000401@teksavvy.com> <20120502155414.GB21677@google.com> <4FA1898C.5070108@teksavvy.com> <20120502193343.GA6411@google.com> <4FA18E49.3040103@teksavvy.com> <20120502194603.GB6411@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:63586 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756703Ab2EDCZw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 May 2012 22:25:52 -0400
Received: by qadb17 with SMTP id b17so733380qad.19
        for <linux-ide@vger.kernel.org>; Thu, 03 May 2012 19:25:52 -0700 (PDT)
In-Reply-To: <20120502194603.GB6411@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <kernel@teksavvy.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 05/02/2012 03:46 PM, Tejun Heo wrote:
> On Wed, May 02, 2012 at 03:43:05PM -0400, Mark Lord wrote:
>>>> +static inline int ata_eh_worth_retry(struct ata_queued_cmd *qc)
>>>
>>> Return bool?&&  maybe split the patch into two - the first separating
>>> out the logic into a function, the latter changing emedia handling?
>>
>> I think the two-liner from v2 is better.
>
> Heh, I don't know.  It probably doesn't matter all that much either
> way.  Let's let Jeff decide. ;)

Queued v3.  If anyone is motivated to make additional changes, base them 
on top of v3...



