From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.7] new NVIDIA libata SATA driver
Date: Wed, 16 Jun 2004 21:20:10 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040617012009.GA10879@havoc.gtf.org>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984B1@mail-sc-6-bk.nvidia.com> <200406170312.42324.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([216.162.42.101]:56546 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266352AbUFQBUR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jun 2004 21:20:17 -0400
Content-Disposition: inline
In-Reply-To: <200406170312.42324.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andrew Chew <achew@nvidia.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, Jun 17, 2004 at 03:12:42AM +0200, Bartlomiej Zolnierkiewicz wrote:
> Removing IDs from amd74xx.c is a bad idea,
> it breaks boot on systems already using these IDs.

(FWIW for Andrew)

I'm going to apply Andrew's patch, but without the PCI id removals.

Then, I'll apply a patch that adds Kconfig questions

	Include hardware that conflicts with libata SATA driver?
	(in drivers/ide)
and
	Include hardware that conflicts with IDE driver?
	(in libata, drivers/scsi)

and apply the associated ifdefs to the low-level drivers.

This is necessary to both enable conflict prevention, and also make sure
we don't break existing setups in the move to libata for SATA stuff.

	Jeff



