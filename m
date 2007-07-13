From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 9/12] sis5513: add ->udma_filter method for chipset_family >= ATA_133
Date: Fri, 13 Jul 2007 21:48:40 +0200
Message-ID: <200707132148.40965.bzolnier@gmail.com>
References: <200707081538.32621.bzolnier@gmail.com> <469655EC.3090303@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:44974 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbXGMVa4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 17:30:56 -0400
Received: by ug-out-1314.google.com with SMTP id j3so647448ugf
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 14:30:55 -0700 (PDT)
In-Reply-To: <469655EC.3090303@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Thursday 12 July 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Add sis5513_ata133_udma_filter() for chipset_family >= ATA_133,
> >   use it to filter UDMA6 mode if ATA133 bit is disabled.
> 
> > * Remove no longer needed UDMA6 limiting logic from sis5513_tune_chipset().
> 
> > * Bump driver version.
> 
> > There should be no functionality changes caused by this patch.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added
