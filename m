From: Tejun Heo <tj@kernel.org>
Subject: Re: Faulty drive data recovery
Date: Fri, 26 Nov 2010 18:29:52 +0100
Message-ID: <4CEFEE90.3030209@kernel.org>
References: <4CED1B5F.8000700@dpf.gov.br> <4CED376A.40502@ngs.ru> <AANLkTikhpPg4XMiDs8B7Jq=YC-xLYtemsarW5=EADkQM@mail.gmail.com> <AANLkTikcPDOxcnb5tGMz9_mEgKntdwHHstO1CipMXv5+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51902 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302Ab0KZRbJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Nov 2010 12:31:09 -0500
In-Reply-To: <AANLkTikcPDOxcnb5tGMz9_mEgKntdwHHstO1CipMXv5+@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Artem Bokhan <aptem@ngs.ru>, Atila <atila.alr@dpf.gov.br>, linux-ide@vger.kernel.org

Hello,

On 11/24/2010 06:00 PM, Greg Freemyer wrote:
>>>> HI, I'm trying to recover data from a damaged hard disk, which has
>>>> plenty of bad sectors, but also has many good ones. The problem is that
>>>> when a bad sector is found, the drive keeps trying to read it, instead
>>>> of giving up and just move on, so the average data read rate is around
>>>> 5Kb/s. With such rates, it will take more than an year to finish. Since
>>>> I'm using gnu ddrescue (which logs bad sectors, so one can try then
>>>> again later), my goal is not waste time with errors, leaving the retries
>>>> to a second round.
>>>> So, my first attempt was to drastically lower the timeouts in
>>>> libata-eh.c. It seems to have improved a little, but I'm not having more
>>>> than 12Kb/s.
>>>> Is there any way to minimize retries and make errors finish faster?

You can directly issue r/w commands using SGIO where you can control
retry and timeout explicitly.  Hmm... it might be a good idea to allow
userland to set FAILFAST bit on a block device?

-- 
tejun
