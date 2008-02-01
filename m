From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2.6 patch] ide/ppc/pmac.c section fixes
Date: Fri, 1 Feb 2008 23:49:14 +0100
Message-ID: <200802012349.14449.bzolnier@gmail.com>
References: <20080130200320.GI29368@does.not.exist>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:18239 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757285AbYBAWhL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Feb 2008 17:37:11 -0500
Received: by wr-out-0506.google.com with SMTP id c48so1351421wra.23
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 14:37:10 -0800 (PST)
In-Reply-To: <20080130200320.GI29368@does.not.exist>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 30 January 2008, Adrian Bunk wrote:
> This patch fixes the following section mismatch:
> 
> <--  snip  -->
> 
> ...
> WARNING: vmlinux.o(.text+0x3b641c): Section mismatch in reference from the function .pmac_ide_setup_device() to the function .init.text:.pmac_ide_setup_dma()
> ...
> 
> <--  snip  -->
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

applied

[ thanks for all patches, especially for fixup-after-Bart ones ;) ]
