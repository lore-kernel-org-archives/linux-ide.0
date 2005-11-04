From: Daniel Drake <dsd@gentoo.org>
Subject: Re: [PATCH] via82cxxx IDE: Support multiple controllers (v2)
Date: Fri, 04 Nov 2005 10:52:36 +0000
Message-ID: <436B3D74.3080807@gentoo.org>
References: <43146CC3.4010005@gentoo.org>	 <58cb370e05083008121f2eb783@mail.gmail.com>	 <43179CC9.8090608@gentoo.org> <58cb370e050927062049be32f8@mail.gmail.com> <433B179A.8010600@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:45400 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1161141AbVKDKwk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Nov 2005 05:52:40 -0500
In-Reply-To: <433B179A.8010600@gentoo.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, posting@blx4.net, vsu@altlinux.ru

Daniel Drake wrote:
> Support multiple controllers in the via82cxxx IDE driver, revised patch. 
> Cable detection and ISA bridge finding have been moved into their own 
> functions.
> 
> Unfortunately I won't have access to a via82cxxx machine until December 
> now, this patch is only compile-tested.

I went home a little earlier than expected and tested this patch on my 
single-controller via machine. It works fine. Is this ok to be merged?

> Signed-off-by: Daniel Drake <dsd@gentoo.org>
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux-2.6.14-rc1/drivers/ide/pci/via82cxxx.c.orig	2005-09-28 22:31:22.000000000 +0100
> +++ linux-2.6.14-rc1/drivers/ide/pci/via82cxxx.c	2005-09-28 23:06:50.000000000 +0100
