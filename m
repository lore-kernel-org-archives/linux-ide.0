From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Fixed PATCH] hpt366: fix section mismatch warnings
Date: Sun, 24 Feb 2008 15:33:51 +0100
Message-ID: <200802241533.51671.bzolnier@gmail.com>
References: <20080222194651.GA7154@uranus.ravnborg.org> <20080223212222.GA16568@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:30810 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbYBXQcA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Feb 2008 11:32:00 -0500
Received: by ug-out-1314.google.com with SMTP id z38so457567ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 24 Feb 2008 08:31:59 -0800 (PST)
In-Reply-To: <20080223212222.GA16568@uranus.ravnborg.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Saturday 23 February 2008, Sam Ravnborg wrote:
> hpt366: fix section mismatch warnings
> 
> Fix following warnings:
> WARNING: o-sparc64/vmlinux.o(.data+0x195a38): Section mismatch in reference from the variable hpt37x_info.0 to the variable .devinit.data:hpt370
> WARNING: o-sparc64/vmlinux.o(.data+0x195a40): Section mismatch in reference from the variable hpt37x_info.0 to the variable .devinit.data:hpt370a
> WARNING: o-sparc64/vmlinux.o(.data+0x195a48): Section mismatch in reference from the variable hpt37x_info.0 to the variable .devinit.data:hpt372
> WARNING: o-sparc64/vmlinux.o(.data+0x195a50): Section mismatch in reference from the variable hpt37x_info.0 to the variable .devinit.data:hpt372n
> 
> Replace a static array with a small switch resulting in
> more readable code.
> Mark the pci table __devinitconst.
> 
> A lot of variables are const but annotated __devinitdata.
> Annotating them __devinitconst would cause a section type
> conflict error when build for 64 bit powerpc.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> ---

thanks, applied

> The first patch I posted caused a section type conflict when
> build for 64 bit powerpc. The actual cause of this is know and unavoidable
> when we start to declare variables const.
> The patch attached is much simpler as the transition from __devinitdata
> to __devinitconst turned out to be bogus.

Weird, I thought that the main purpose of __devinitconst was to replace
const + __devinitdata?
