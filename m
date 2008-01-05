From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: delete filenames/versions from comments
Date: Sat, 5 Jan 2008 14:15:06 +0100
Message-ID: <200801051415.06557.bzolnier@gmail.com>
References: <fa.CAem1qRl3AG/KJjVoPZU/Cn8U1g@ifi.uio.no> <477C2EE8.50301@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:39433 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587AbYAENYa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jan 2008 08:24:30 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2907255ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 05 Jan 2008 05:24:29 -0800 (PST)
In-Reply-To: <477C2EE8.50301@shaw.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Thursday 03 January 2008, Robert Hancock wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Delete filenames/versions from comments.
> > 
> > I'm leaving decisions about adding DRV_VERSION defines and MODULE_VERSION()-s
> > to maintainers of the respective drivers.
> > 
> > While at it:
> > 
> > * Remove unused VERSION define from ide.c.
> > 
> > * Remove unused/stale DRV_VERSION define from au1xxx-ide.c.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> How about getting rid of this stupid thing in drivers/ide/ide.c:
> 
> #define	REVISION	"Revision: 7.00alpha2"
> 
> which is used in:
> 
> printk(KERN_INFO "Uniform Multi-Platform E-IDE driver " REVISION "\n");
> 
> It's been 7.00alpha2 for god knows how long, so clearly this version 
> number is not useful..

Yep, care to make a patch removing it?

Thanks,
Bart
