From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] m68k: Fix falconide `data_adr' typo
Date: Tue, 6 May 2008 17:57:35 +0200
Message-ID: <200805061757.35775.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0805052114380.15634@anakin>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:11507 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764979AbYEFQER (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 May 2008 12:04:17 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1383071nfc.21
        for <linux-ide@vger.kernel.org>; Tue, 06 May 2008 09:04:15 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0805052114380.15634@anakin>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>

On Monday 05 May 2008, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert@linux-m68k.org>
> 
>     commit 9567b349f7e7dd7e2483db99ee8e4a6fe0caca38
>     Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>     Date:   Mon Apr 28 23:44:36 2008 +0200
> 
>     ide: merge ->atapi_*put_bytes and ->ata_*put_data methods
> 
> introduced a typo (`data_adr' instead of `data_addr'), leading to a compile
> failure.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks Geert.
