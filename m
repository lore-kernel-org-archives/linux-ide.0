From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: PATCH: Add CFA modes
Date: Sat, 19 Nov 2011 17:35:19 +0400
Message-ID: <4EC7B097.7060805@mvista.com>
References: <1155232332.24077.7.camel@localhost.localdomain> <4EC7AF27.2050704@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37164 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587Ab1KSNgP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Nov 2011 08:36:15 -0500
Received: by bke11 with SMTP id 11so4554167bke.19
        for <linux-ide@vger.kernel.org>; Sat, 19 Nov 2011 05:36:14 -0800 (PST)
In-Reply-To: <4EC7AF27.2050704@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello.

On 19-11-2011 17:29, Sergei Shtylyov wrote:

>>> From nobody Mon Sep 17 00:00:00 2001
>> From: root<root@hraefn.swansea.linux.org.uk>
>> Date: Thu Aug 10 18:06:38 2006 +0100
>> Subject: [PATCH] Add compact flash support

>> The CFA world has some additional rules and drive modes we need to support for
>> newer expansion cards and on embedded boxes

> Sorry, this is very old patch,

>> @@ -1913,6 +1945,8 @@ static const struct ata_timing ata_timin
>> { XFER_UDMA_4, 0, 0, 0, 0, 0, 0, 0, 30 },
>> { XFER_UDMA_3, 0, 0, 0, 0, 0, 0, 0, 45 },
>>
>> + { XFER_MW_DMA_4, 25, 0, 0, 0, 55, 20, 80, 0 },
>> + { XFER_MW_DMA_3, 25, 0, 0, 0, 65, 25, 100, 0 },
>
> I keep wondering where you got these 25 ns setup timings and where such
> numbers for modes 0-2 came from -- they're not in any spec.

> MBR, Sergei

    Ignore this mail -- I hit "send" too soon. :-/

MBR, Sergei
