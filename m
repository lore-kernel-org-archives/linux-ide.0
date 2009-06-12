From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 7.5/9] siimage: use ide_dma_test_irq()
Date: Fri, 12 Jun 2009 18:22:57 +0200
Message-ID: <200906121822.57529.bzolnier@gmail.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <4A301BD3.80307@ru.mvista.com> <200906112239.20009.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f216.google.com ([209.85.220.216]:57023 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbZFLQXE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jun 2009 12:23:04 -0400
Received: by fxm12 with SMTP id 12so739267fxm.37
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2009 09:23:06 -0700 (PDT)
In-Reply-To: <200906112239.20009.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Thursday 11 June 2009 20:39:19 Sergei Shtylyov wrote:
> Remove interrupt bit test (not trusted anyway) from siimage_io_dma_te=
st_irq()
> and siimage_mmio_dma_test_irq() -- this allows to replace the former =
function
> with now identical ide_dma_test_irq()...
>=20
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

drivers/ide/siimage.c: In function =E2=80=98siimage_mmio_dma_test_irq=E2=
=80=99:
drivers/ide/siimage.c:351: warning: unused variable =E2=80=98addr=E2=80=
=99
