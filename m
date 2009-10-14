From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pata_sc1200: Fix crash on boot
Date: Wed, 14 Oct 2009 14:12:29 +0200
Message-ID: <200910141412.29467.bzolnier@gmail.com>
References: <20091006150737.9610.81541.stgit@localhost.localdomain> <20091013185637.870369c8.akpm@linux-foundation.org> <20091014130046.0aa13166@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:34594 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755778AbZJNMNs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Oct 2009 08:13:48 -0400
In-Reply-To: <20091014130046.0aa13166@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@linux.intel.com>, jeff@garzik.org, linux-kernel@vger.kernel.org, stable@kernel.org, "Alexandros C. Couloumbis" <alex@ozo.com>, linux-ide@vger.kernel.org

On Wednesday 14 October 2009 14:00:46 Alan Cox wrote:
> > This patch applies to 2.6.31 and 2.6.30 (at least).  How far back
> > should it be ported?
> 
> No idea. I was just getting it fixed for the maintainer while waiting for
> something else to build.

BTW do you happen to know who is the current maintainer of this driver
(ditto for other PATA drivers)?

MAINTAINERS lists only:

	SERIAL ATA (SATA) SUBSYSTEM
	P:      Jeff Garzik
	M:      jgarzik@pobox.com
	L:      linux-ide@vger.kernel.org
	T:      git git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
	S:      Supported
	F:      drivers/ata/
	F:      include/linux/ata.h
	F:      include/linux/libata.h

but this driver surely ain't SATA.
