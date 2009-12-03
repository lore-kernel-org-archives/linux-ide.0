From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_it8213: MWDMA0 is unsupported
Date: Thu, 03 Dec 2009 16:04:42 -0500
Message-ID: <4B1827EA.4050608@garzik.org>
References: <200911261728.36433.bzolnier@gmail.com> <200911261800.55025.bzolnier@gmail.com> <4B0EB986.2010801@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:51951 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbZLCVEi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 16:04:38 -0500
In-Reply-To: <4B0EB986.2010801@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/26/2009 12:23 PM, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
>
>>> MWDMA0 timings cannot be met with the PIIX based controller
>>> programming interface.
>
>>> This change should be safe as this is how we have been doing
>>> things in IDE it8213 host driver for years.
>
>>> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>>> ---
>>> Verified with the documentation (similar case as with pata_efar).
>
>> Uhhh, no...
>
>> Too many damn drivers.
>
>> Too much damn duplication.
>
>> Too much damn subtle differences here and there.
>
>> The hardware is probably fine for MWMDA0 when it comes to
>> pata_{efar,it8213},
>> it just not documented properly in the data sheet.
>
> How so with pata_efar? The active/recovery bitfields are still 2-bit
> wide, no?

So....  pata_it8213 is fine for MWDMA0, then?

	Jeff




