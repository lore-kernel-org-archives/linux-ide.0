From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/1] ide: ide-generic, add another device exception
Date: Fri, 8 Jun 2007 09:59:31 -0400
Message-ID: <20070608135931.GB24346@havoc.gtf.org>
References: <20601315171560711667@wsc.cz> <200706081418.56217.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:57155 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966995AbXFHN7d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Jun 2007 09:59:33 -0400
Content-Disposition: inline
In-Reply-To: <200706081418.56217.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Ingo Korb <ml@akana.de>, linux-ide@vger.kernel.org

On Fri, Jun 08, 2007 at 02:18:55PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Monday 04 June 2007, Jiri Slaby wrote:
> > ide-generic, add another device exception
> 
> ide-generic is a generic ISA IDE driver, this one is drivers/ide/pci/generic
> (a generic IDE PCI driver) - fixed patch description to avoid confusion.
> 
> [ Yes, both drivers need a rename - patches are welcomed. ]

Probably best to do a rename from your side, in git.

	Jeff



