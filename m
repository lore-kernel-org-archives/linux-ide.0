From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata_it8213: MWDMA0 is unsupported
Date: Thu, 26 Nov 2009 20:23:18 +0300
Message-ID: <4B0EB986.2010801@ru.mvista.com>
References: <200911261728.36433.bzolnier@gmail.com> <200911261800.55025.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:27171 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1756432AbZKZRWV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Nov 2009 12:22:21 -0500
In-Reply-To: <200911261800.55025.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>MWDMA0 timings cannot be met with the PIIX based controller
>>programming interface.

>>This change should be safe as this is how we have been doing
>>things in IDE it8213 host driver for years.

>>Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>>---
>>Verified with the documentation (similar case as with pata_efar).

> Uhhh, no...

> Too many damn drivers.

> Too much damn duplication.

> Too much damn subtle differences here and there.

> The hardware is probably fine for MWMDA0 when it comes to pata_{efar,it8213},
> it just not documented properly in the data sheet.

    How so with pata_efar? The active/recovery bitfields are still 2-bit 
wide, no?

> I'll drop those two patches from my tree and take some break..

    Taking a break is good, not sure about dropping yet.

MBR, Sergei
