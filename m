From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] amd74xx: don't configure udma mode higher than BIOS did
Date: Mon, 5 Feb 2007 13:22:47 +0000
Message-ID: <20070205132247.6f611e3c@localhost.localdomain>
References: <20070205075836.GG1625@htj.dyndns.org>
	<20070205112410.5a3c3182@localhost.localdomain>
	<45C72012.7050605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39015 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932371AbXBENJx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 08:09:53 -0500
In-Reply-To: <45C72012.7050605@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

> If BIOS hasn't run, UDMA timing wouldn't have been programmed and as
> such the speed won't be limited.  So, there should be no harm done in
> that case.  Even if something goes really wrong, the worst happens is
> capping speed to udma33.

Which is bad and leaves people with mysterious performance problems that
randomly appear in a new release. You have error handling code that will
do UDMA change down, you've fixed the disk side detect. We don't need to
destroy the pata_amd driver as well nor the IDE AMD driver.

You get whatever the chip has loaded. The BIOS may pick PIO modes only,
the BIOS may not have been run so the UDMA bits could be arbitary. You
may even get wrongly capped values.

Also another case you broke is kexec.

> So, I think the benefit (correct configuration on most machines) easily
> outweighs the danger (incorrectly capping speed to working udma33 on
> non-PC).

Yours is the first complaint I've seen about this hardware detection in
*THREE* years. Its a bigger problem with libata but thats because of the
drive side detect and also because currently we work on the basis in
libata that host side detect defines cable, while old ide (when behaving
and correctly working) works on the basis that if the host says 80wire and
the drive says 40 wire (or vice versa) then its 40.

Alan
