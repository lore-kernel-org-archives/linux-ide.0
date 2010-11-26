From: Atila <atila.alr@dpf.gov.br>
Subject: Re: Faulty drive data recovery
Date: Fri, 26 Nov 2010 16:45:08 -0200
Message-ID: <4CF00034.4080600@dpf.gov.br>
References: <4CED1B5F.8000700@dpf.gov.br> <4CED376A.40502@ngs.ru> <AANLkTikhpPg4XMiDs8B7Jq=YC-xLYtemsarW5=EADkQM@mail.gmail.com> <AANLkTikcPDOxcnb5tGMz9_mEgKntdwHHstO1CipMXv5+@mail.gmail.com> <4CEFEE90.3030209@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhost1.dpf.gov.br ([200.169.41.12]:10946 "EHLO
	mailhost1.dpf.gov.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250Ab0KZSzt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Nov 2010 13:55:49 -0500
In-Reply-To: <4CEFEE90.3030209@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Greg Freemyer <greg.freemyer@gmail.com>, Artem Bokhan <aptem@ngs.ru>, linux-ide@vger.kernel.org

Em 26/11/2010 15:29, Tejun Heo escreveu:
> Hello,
>
> On 11/24/2010 06:00 PM, Greg Freemyer wrote:
>>>>> HI, I'm trying to recover data from a damaged hard disk, which has
>>>>> plenty of bad sectors, but also has many good ones. The problem is that
>>>>> when a bad sector is found, the drive keeps trying to read it, instead
>>>>> of giving up and just move on, so the average data read rate is around
>>>>> 5Kb/s. With such rates, it will take more than an year to finish. Since
>>>>> I'm using gnu ddrescue (which logs bad sectors, so one can try then
>>>>> again later), my goal is not waste time with errors, leaving the retries
>>>>> to a second round.
>>>>> So, my first attempt was to drastically lower the timeouts in
>>>>> libata-eh.c. It seems to have improved a little, but I'm not having more
>>>>> than 12Kb/s.
>>>>> Is there any way to minimize retries and make errors finish faster?
> You can directly issue r/w commands using SGIO where you can control
> retry and timeout explicitly.  Hmm... it might be a good idea to allow
> userland to set FAILFAST bit on a block device?

Sounds like a great idea to me. I think it would become popular in
forensics.

I followed Artem Bokhan s' tip on timeout and tried Greg Freemyer s' on
smartctl. Unfortunately this particular drive is only ATA-7, so scterc
wasn't available. But is definitively good to know.

I never played with SGIO before, but there is plenty of time to learn to
use it before ddrescue can finish copying.:)

Thank you all,

Atila

