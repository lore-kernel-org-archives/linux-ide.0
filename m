From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] amd74xx: don't configure udma mode higher than BIOS did
Date: Mon, 5 Feb 2007 13:24:42 +0000
Message-ID: <20070205132442.1516678b@localhost.localdomain>
References: <20070205075836.GG1625@htj.dyndns.org>
	<20070205112410.5a3c3182@localhost.localdomain>
	<45C72012.7050605@gmail.com>
	<45C723FF.2060405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39018 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932368AbXBENLq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 08:11:46 -0500
In-Reply-To: <45C723FF.2060405@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

> To prevent that, the value is cached on driver probe and written back on
> driver detach on pata_amd, which is necessary even when there is no

Which is useless.

> suspend/resume as mode programming alters the content of the register.
> amd74xx cannot be unloaded, so caching is enough.  Also, doesn't
> suspend/resume cycle store and restore PCI space anyway?

If I load the driver after a kexec or after a suspend/resume cycle both
of which are quite valid your code breaks.

Alan
