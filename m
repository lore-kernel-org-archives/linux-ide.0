From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
Subject: Re: [patch 3/3] ata: SWNCQ should be enabled by default
Date: Sat, 29 Mar 2008 19:22:01 +0100
Message-ID: <47EE88C9.3020805@dunaweb.hu>
References: <200803282133.m2SLXlWk011463@imap1.linux-foundation.org> <47EE465E.80401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dunaweb.hu ([81.17.184.3]:43010 "EHLO mail.dunaweb.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753461AbYC2S2e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Mar 2008 14:28:34 -0400
In-Reply-To: <47EE465E.80401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, hancockr@shaw.ca

Tejun Heo =EDrta:
> akpm@linux-foundation.org wrote:
>> From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
>>
>> unchangelogged patch.
>>
>> Signed-off-by: Zoltan Boszormenyi <zboszor@dunaweb.hu>
>> Cc: Robert Hancock <hancockr@shaw.ca>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>
> Nacked-by: Tejun Heo <htejun@gmail.com>
>
> Sorry, there are remaining issues to resolve before enabling ADMA by=20
> default.

Sorry, this is NOT ADMA. SWNCQ is completely independent from ADMA.


