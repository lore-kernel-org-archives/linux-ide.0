From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: drivers/ide/pci/cs5535.c: array overrun
Date: Thu, 26 Jul 2007 21:11:21 +0200
Message-ID: <200707262111.21296.bzolnier@gmail.com>
References: <06FDA0246543E443ABBB36B1FCD5CC0603CF3360@SAUSEXMB2.amd.com> <20070724155952.GA13874@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:63144 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936094AbXGZT7k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 15:59:40 -0400
Received: by ug-out-1314.google.com with SMTP id j3so591347ugf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 12:59:39 -0700 (PDT)
In-Reply-To: <20070724155952.GA13874@cosmic.amd.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: bunk@stusta.de, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Tuesday 24 July 2007, Jordan Crouse wrote:
> > The Coverity checker spotted the following array overrun in 
> > drivers/ide/pci/cs5535.c:
> 
> <-- snip -->
> 
> >	if (speed >= XFER_UDMA_0 && speed <= XFER_UDMA_7)
> >		reg |= cs5535_udma_timings[speed - XFER_UDMA_0];

Not a bug per se since the upper layer will never feed this function
with speed > XFER_UDMA_4 (thanks to ->ultra_mask being set to 0x1f).

Worth fixing anyway.

> Fix is attached.  Somebody got overzealous - the 5535 only supports
> up to UDMA4, which matches the array.

applied, thanks

Bart
