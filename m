From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/1] ide: ide-generic, add another device exception
Date: Fri, 8 Jun 2007 14:18:55 +0200
Message-ID: <200706081418.56217.bzolnier@gmail.com>
References: <20601315171560711667@wsc.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:48188 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968116AbXFHNJL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 09:09:11 -0400
Received: by ug-out-1314.google.com with SMTP id j3so950343ugf
        for <linux-ide@vger.kernel.org>; Fri, 08 Jun 2007 06:09:11 -0700 (PDT)
In-Reply-To: <20601315171560711667@wsc.cz>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Ingo Korb <ml@akana.de>, linux-ide@vger.kernel.org

On Monday 04 June 2007, Jiri Slaby wrote:
> ide-generic, add another device exception

ide-generic is a generic ISA IDE driver, this one is drivers/ide/pci/generic
(a generic IDE PCI driver) - fixed patch description to avoid confusion.

[ Yes, both drivers need a rename - patches are welcomed. ]

> This device is char device and is grabbed by generic ide driver:
> 00:0b.0 Class ffff: National Semiconductor Corporation 87410 IDE (rev ff) (prog-if ff)
> 	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 
> Disallow generic driver to grab it by adding next condition. Also
> consolidate exceptions to one bigger 'switch (dev->vendor)'.
> 
> Cc: Ingo Korb <ml@akana.de>
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

applied, thanks.
