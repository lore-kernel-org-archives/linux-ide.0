From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: [patch][9/9] block: remove bio walking
Date: Thu, 9 Sep 2004 15:53:13 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200409091553.13918.bzolnier@elka.pw.edu.pl>
References: <200409082127.04331.bzolnier@elka.pw.edu.pl> <20040909090314.A24950@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:35289 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S264261AbUIINz5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Sep 2004 09:55:57 -0400
In-Reply-To: <20040909090314.A24950@flint.arm.linux.org.uk>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>

On Thursday 09 September 2004 10:03, Russell King wrote:
> On Wed, Sep 08, 2004 at 09:27:04PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > [patch] block: remove bio walking
> > 
> > IDE driver was the only user of bio walking code.

was in -bk10 :-(

> The MMC driver also uses this.  Please don't remove.

OK I'll just drop this patch but can't we also use scatterlists in MMC?

The point is that I now think bio walking was a mistake and accessing
bios directly from low-level drivers is a layering violation (thus
all the added complexity). Moreover with fixed IDE PIO and without
bio walking code it should be possible to shrink struct request by
removing all "current" entries.

Bartlomiej
