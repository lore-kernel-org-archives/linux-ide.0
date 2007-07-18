From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] piix/slc90e66: fix PIO1 handling in ->speedproc method (take 2)
Date: Wed, 18 Jul 2007 23:07:27 +0200
Message-ID: <200707182307.27339.bzolnier@gmail.com>
References: <200707132303.39408.bzolnier@gmail.com> <4698FF26.6020500@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:48097 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbXGRVHP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 17:07:15 -0400
Received: by ug-out-1314.google.com with SMTP id j3so325095ugf
        for <linux-ide@vger.kernel.org>; Wed, 18 Jul 2007 14:07:14 -0700 (PDT)
In-Reply-To: <4698FF26.6020500@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 14 July 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Don't call {piix,slc90e66}_dma_2_pio() for PIO modes in
> >   {piix,slc90e66}_tune_chipset().
> 
> > * Add PIO1 handling to {piix,slc90e66}_tune_chipset().
> 
> > * Bump driver version.  
> 
> > v2:
> > * Remove PIO modes from {piix,slc90e66}_dma_2_pio(), they are no longer needed
> >   there (Noticed by Sergei)
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added
