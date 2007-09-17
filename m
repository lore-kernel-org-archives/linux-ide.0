From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] [POWERPC] Remove unused variabls from drivers/ide/ppc/pmac.c
Date: Mon, 17 Sep 2007 12:16:07 +0200
Message-ID: <200709171216.08058.bzolnier@gmail.com>
References: <20070917140644.f62abe1e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:28266 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbXIQLG7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 07:06:59 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1117543nfb
        for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 04:06:57 -0700 (PDT)
In-Reply-To: <20070917140644.f62abe1e.sfr@canb.auug.org.au>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: paulus@samba.org, ppc-dev <linuxppc-dev@ozlabs.org>, linux-ide@vger.kernel.org

On Monday 17 September 2007, Stephen Rothwell wrote:
> Removes these warnings:
> 
> /home/sfr/kernels/linus/drivers/ide/ppc/pmac.c: In function 'pmac_ide_dma_check':
> /home/sfr/kernels/linus/drivers/ide/ppc/pmac.c:1807: warning: unused variable 'map'
> /home/sfr/kernels/linus/drivers/ide/ppc/pmac.c:1805: warning: unused variable 'pmif'
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

applied
