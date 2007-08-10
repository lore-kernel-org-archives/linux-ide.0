From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/11] it8213/piix/slc90e66: remove {it8213,piix,slc90e66}_dma_2_pio()
Date: Fri, 10 Aug 2007 20:44:45 +0400
Message-ID: <46BC95FD.20104@ru.mvista.com>
References: <200708042206.22546.bzolnier@gmail.com> <46B5F305.5040206@ru.mvista.com> <200708092140.22179.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:56088 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932447AbXHJQme (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Aug 2007 12:42:34 -0400
In-Reply-To: <200708092140.22179.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>>Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

>>    Sigh... when I was talking about getting rid of that function, I meant 
>>that we need to also decouple UltraDMA from PIO -- which is what this patch 
>>misses...

> Addressed in the follow-up patch.

    That's good, thanks. :-)

>>    Actually, I intended to decouple DMA form PIO in this drivers completely 
>>but that would be a next step...

> DMA and PIO timings are shared on these controllers (except when DTE bit is
> set, then PIO0 timings are always used and DMA timings are independent)...?

   Yeah, but one do not need to toggle IORDY/prefetch enables for DMA modes -- 
actually, this is a buglet -- despite what Intel's manuals say...

> Bart

MBR, Sergei
