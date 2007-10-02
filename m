From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/4] hpt366: MWDMA filter for SATA cards (take 2)
Date: Tue, 02 Oct 2007 16:21:55 +0400
Message-ID: <470237E3.2020108@ru.mvista.com>
References: <200709300004.43335.sshtylyov@ru.mvista.com> <200710012312.45552.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:22149 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752677AbXJBMWO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 08:22:14 -0400
In-Reply-To: <200710012312.45552.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>The Marvell bridge chips used on HighPoint SATA cards do not seem to support
>>the MWDMA modes (at least that caould be seen in their so-called drivers :-),
>>so the driver needs to account for this -- to achieve this:

>>- add mdma_filter() method from the original patch by Bartlomiej Zolnierkewicz
>> with his consent,

>> also adding the method callout to ide_rate_filter();

    Ugh, forgot to remove this part -- it's no longer true.

>>- install the method for all chips to only return empty mask if a SATA drive
>>  is detected on HPT372{AN]/374 chips...

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> applied

Thanks,
Sergei
