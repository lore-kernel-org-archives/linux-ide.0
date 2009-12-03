From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 16/86] pata_efar: MWDMA0 is unsupported
Date: Thu, 03 Dec 2009 15:50:14 -0500
Message-ID: <4B182486.6050505@garzik.org>
References: <20091125170218.5446.13513.sendpatchset@localhost>	<20091125170415.5446.15073.sendpatchset@localhost>	<20091125172552.6817e3da@lxorguk.ukuu.org.uk>	<200911261553.58941.bzolnier@gmail.com> <20091126151546.6c891014@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:62744 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbZLCUuJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 15:50:09 -0500
In-Reply-To: <20091126151546.6c891014@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/26/2009 10:15 AM, Alan Cox wrote:
> On Thu, 26 Nov 2009 15:53:58 +0100
> Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>  wrote:
>
>> On Wednesday 25 November 2009 06:25:52 pm Alan Cox wrote:
>>> On Wed, 25 Nov 2009 18:04:15 +0100
>>> Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>  wrote:
>>>
>>>> From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
>>>> Subject: [PATCH] pata_efar: MWDMA0 is unsupported
>>>>
>>>> MWDMA0 timings cannot be met with the PIIX based controller
>>>> programming interface.
>>>
>>> The efar documentation makes no reference to not being capable of MWDMA0,
>>> so where does this come from ? No MWDMA0 is an Intel erratum it appears.
>>
>> No MWDMA0 support is a common issue on all 'PIIX-like' controllers.
>>
>> In case of this chipset while the (preliminary) documentation claims MWDMA0
>> support on the 'FEATURES' page the later 'programming guide' part describes
>> only PIO0-4, SWDMA2, MWDMA1-2 and UDMA0-4 transfer modes as supported.
>
> Cool - I only have the original docs.

ACK Bart's patch, then?

This thread was a bit unclear, and I want to be certain (well, as 
certain as we can be :))

	Jeff



