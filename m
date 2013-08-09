From: 'Tejun Heo' <tj@kernel.org>
Subject: Re: [PATCH 2/2] ata: pata_samsung_cf: add missing __iomem annotation
Date: Fri, 9 Aug 2013 10:13:06 -0400
Message-ID: <20130809141306.GD20515@mtj.dyndns.org>
References: <000101ce94c2$52ad79f0$f8086dd0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f45.google.com ([209.85.128.45]:46685 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030274Ab3HIONM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 10:13:12 -0400
Received: by mail-qe0-f45.google.com with SMTP id x7so2370818qeu.18
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 07:13:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <000101ce94c2$52ad79f0$f8086dd0$@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-ide@vger.kernel.org

On Fri, Aug 09, 2013 at 02:35:57PM +0900, Jingoo Han wrote:
> From e15fc1811b2ce01358de00c34e4a69a52bb1e9c5 Mon Sep 17 00:00:00 2001
> From: Jingoo Han <jg1.han@samsung.com>
> Date: Fri, 9 Aug 2013 14:24:35 +0900
> Subject: [PATCH 2/2] ata: pata_samsung_cf: add missing __iomem annotation
> 
> Added missing __iomem annotation and staticized local symbol
> in order to fix the following sparse warnings:
> 
> drivers/ata/pata_samsung_cf.c:244:14: warning: symbol 'pata_s3c_data_xfer' was not declared. Should it be static?
> drivers/ata/pata_samsung_cf.c:423:20: warning: incorrect type in argument 1 (different address spaces)
> drivers/ata/pata_samsung_cf.c:423:20:    expected void const volatile [noderef] <asn:2>*addr
> drivers/ata/pata_samsung_cf.c:423:20:    got void *
> drivers/ata/pata_samsung_cf.c:425:9: warning: incorrect type in argument 2 (different address spaces)
> drivers/ata/pata_samsung_cf.c:425:9:    expected void volatile [noderef] <asn:2>*addr
> drivers/ata/pata_samsung_cf.c:425:9:    got void *
> drivers/ata/pata_samsung_cf.c:448:37: warning: incorrect type in argument 1 (different address spaces)
> drivers/ata/pata_samsung_cf.c:448:37:    expected void *s3c_ide_regbase
> drivers/ata/pata_samsung_cf.c:448:37:    got void [noderef] <asn:2>*ide_addr
> drivers/ata/pata_samsung_cf.c:463:37: warning: incorrect type in argument 1 (different address spaces)
> drivers/ata/pata_samsung_cf.c:463:37:    expected void *s3c_ide_regbase
> drivers/ata/pata_samsung_cf.c:463:37:    got void [noderef] <asn:2>*ide_addr
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to libata/for-3.12.

Thanks.

-- 
tejun
