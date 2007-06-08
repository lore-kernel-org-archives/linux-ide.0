From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/1] ide: ide-generic, add another device exception
Date: Fri, 8 Jun 2007 22:41:24 +0200
Message-ID: <200706082241.24233.bzolnier@gmail.com>
References: <20601315171560711667@wsc.cz> <200706081418.56217.bzolnier@gmail.com> <20070608135931.GB24346@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:48776 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S969344AbXFHU1l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 16:27:41 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1037063ugf
        for <linux-ide@vger.kernel.org>; Fri, 08 Jun 2007 13:27:39 -0700 (PDT)
In-Reply-To: <20070608135931.GB24346@havoc.gtf.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Ingo Korb <ml@akana.de>, linux-ide@vger.kernel.org


Hi,

On Friday 08 June 2007, Jeff Garzik wrote:
> On Fri, Jun 08, 2007 at 02:18:55PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Monday 04 June 2007, Jiri Slaby wrote:
> > > ide-generic, add another device exception
> > 
> > ide-generic is a generic ISA IDE driver, this one is drivers/ide/pci/generic
> > (a generic IDE PCI driver) - fixed patch description to avoid confusion.
> > 
> > [ Yes, both drivers need a rename - patches are welcomed. ]
> 
> Probably best to do a rename from your side, in git.

AFAIR git-quiltimport of quilt patches should handle this just fine?

My previous description of the issue was a bit too cryptic: besides
changing ide/ide-generic.c and ide/pci/generic.c filenames, ide/Kconfig
(names of config options) and ide/Makefile should be updated accordingly.
Also enhancing Kconfig entries for both drivers to be more verbose would
be more than appropriate.

Since I'm quite time constrained and I'm working on other IDE issues I
would prefer that somebody else handle this task and just send me patches.

8)

Thanks,
Bart
