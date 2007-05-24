From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6 fix queue] aec62xx: kill speedproc() method wrapper
Date: Thu, 24 May 2007 17:18:31 +0400
Message-ID: <465590A7.1080107@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200705152343.12956.bzolnier@gmail.com> <464B1310.2080808@ru.mvista.com> <200705240133.03704.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:64963 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756875AbXEXNRA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 09:17:00 -0400
In-Reply-To: <200705240133.03704.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
>>Bartlomiej Zolnierkiewicz wrote:

>>>>There's no reason to have the speedproc() method wrapper for the two quite
>>>>different chip families, so just get rid of it.

>>>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>>applied

>>    I forgot to notice/mention the side effect: there would be no speedproc() 
>>method installed if hwif->dma_base happens to be 0.

> It doesn't sound too nice since ->autotune is always set and ->tuneproc
> uses ->speedproc unconditionally (=> OOPS).

    Yeah, I have overlooked that -- will need to be reworked.

> Looks like we really need an extra

> if (atp850)
> 	choose atp850 speedproc
> else
> 	choose atp86x speedproc

    Yeah, I'll add this to the initial if statement dealing with serialization.

> before hwif->dma_base check... or maybe even separate ->init_hwif
> methods for atp850 and atp86x.

    Probably doesn't worth it...

> Thanks,
> Bart

WBR, Sergei
