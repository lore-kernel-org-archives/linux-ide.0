From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH libata-dev#upstream-fixes] libata: force PIO on IOMEGA ZIP 250 ATAPI
Date: Sun, 10 Jun 2007 19:03:57 +0200
Message-ID: <200706101903.57602.bzolnier@gmail.com>
References: <20070610055236.GI29122@htj.dyndns.org> <20070610162230.52f9ec81@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:53801 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbXFJQtc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Jun 2007 12:49:32 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1305011ugf
        for <linux-ide@vger.kernel.org>; Sun, 10 Jun 2007 09:49:31 -0700 (PDT)
In-Reply-To: <20070610162230.52f9ec81@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, calvin.walton@gmail.com

On Sunday 10 June 2007, Alan Cox wrote:
> On Sun, 10 Jun 2007 14:52:36 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
> > IOMEGA ZIP 250 ATAPI claims MWDMA0 support but fails SETXFERMODE if
> > asked to configure itself to MWDMA0.  Force PIO.
> 
> This is only really a temporary fix. It appears to manage MWDMA0 in some
> cases with old IDE..

Tejun, please add the comment that this is a libata issue so nobody ever
tries to sync this blacklist entry with ide-dma.c.

Thanks,
Bart
