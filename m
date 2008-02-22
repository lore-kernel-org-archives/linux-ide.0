From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] hpt366: fix section mismatch warnings
Date: Fri, 22 Feb 2008 21:57:15 +0100
Message-ID: <200802222157.15480.bzolnier@gmail.com>
References: <20080222194651.GA7154@uranus.ravnborg.org> <47BF2846.1030604@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:28069 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbYBVUqb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Feb 2008 15:46:31 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1409151ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 22 Feb 2008 12:46:30 -0800 (PST)
In-Reply-To: <47BF2846.1030604@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Friday 22 February 2008, Sergei Shtylyov wrote:
> Sam Ravnborg wrote:
> 
> > hpt366: fix section mismatch warnings
> 
> > Fix following warnings:
> > WARNING: o-sparc64/vmlinux.o(.data+0x195a38): Section mismatch in reference from the variable hpt37x_info.0 to the variable .devinit.data:hpt370
> > WARNING: o-sparc64/vmlinux.o(.data+0x195a40): Section mismatch in reference from the variable hpt37x_info.0 to the variable .devinit.data:hpt370a
> > WARNING: o-sparc64/vmlinux.o(.data+0x195a48): Section mismatch in reference from the variable hpt37x_info.0 to the variable .devinit.data:hpt372
> > WARNING: o-sparc64/vmlinux.o(.data+0x195a50): Section mismatch in reference from the variable hpt37x_info.0 to the variable .devinit.data:hpt372n
> 
> > Replace a static array with a small switch resulting in
> > more readable code.
> > Be consistent in use of __devinitconst for const data
> > to avoid section type conflicts.
> > Mark the pci table __devinitconst.
> 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
