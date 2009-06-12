From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7.5/9] siimage: use ide_dma_test_irq()
Date: Fri, 12 Jun 2009 23:32:37 +0400
Message-ID: <4A32AD55.5000108@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <4A301BD3.80307@ru.mvista.com> <200906112239.20009.sshtylyov@ru.mvista.com> <200906121822.57529.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:34252 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754924AbZFLTck (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Jun 2009 15:32:40 -0400
In-Reply-To: <200906121822.57529.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>> Remove interrupt bit test (not trusted anyway) from siimage_io_dma_t=
est_irq()
>> and siimage_mmio_dma_test_irq() -- this allows to replace the former=
 function
>> with now identical ide_dma_test_irq()...
>>
>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>>    =20
>
> drivers/ide/siimage.c: In function =E2=80=98siimage_mmio_dma_test_irq=
=E2=80=99:
> drivers/ide/siimage.c:351: warning: unused variable =E2=80=98addr=E2=80=
=99
>  =20

   Saw that but apparently forgot to fix. Sigh... :-/

MBR, Sergei


