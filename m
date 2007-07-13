From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/12] cs5535: PIO fixes
Date: Fri, 13 Jul 2007 19:28:07 +0400
Message-ID: <46979A07.2030100@ru.mvista.com>
References: <200707081534.31610.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:44383 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761969AbXGMP0F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jul 2007 11:26:05 -0400
In-Reply-To: <200707081534.31610.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Fix cs5535_tuneproc() to pass PIO transfer mode value instead of PIO mode
>   number to cs5535_set_speed() (fixes random PIO timings being programmed
>   and a possible OOPS).  Do a little cleanup while at it.

> * Fix cs5535_set_speed() to check if the mate device is present (fixes PIO0
>   taskfile timings being used if there is no other device on the cable).

> * Use cs5535_tuneproc() in cs5535_dma_check().  The old code had the same
>   issue as cs5535_tuneproc() and add additionally caused 0x00-0x04 transfer
>   mode values (== default PIO, default PIO w/ IORDY + two invalid values)
>   being set on the device instead of values 0x08-0x0c (XFER_PIO_[0,4]).

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

