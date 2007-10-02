From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/3] ide: add CONFIG_IDE_ARCH_OBSOLETE_INIT
Date: Tue, 2 Oct 2007 23:01:36 +0200
Message-ID: <200710022301.36504.bzolnier@gmail.com>
References: <200709192211.03850.bzolnier@gmail.com> <47029E77.6070605@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:29167 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337AbXJBVTl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 17:19:41 -0400
Received: by nf-out-0910.google.com with SMTP id g13so3415449nfb
        for <linux-ide@vger.kernel.org>; Tue, 02 Oct 2007 14:19:40 -0700 (PDT)
In-Reply-To: <47029E77.6070605@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Tuesday 02 October 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Add CONFIG_IDE_ARCH_OBSOLETE_INIT to drivers/ide/Kconfig and use it instead
> > of defining IDE_ARCH_OBSOLETE_INIT in <arch/ide.h>.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> >  include/asm-arm26/ide.h             |    1 -
> 
>     No such file upstream anymore. Looks good otherwise...

Thanks, patch updated.

Bart
