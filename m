From: Christoph Hellwig <hch@lst.de>
Subject: strange CONFIG_BLK_DEV_IDECS ifdefs
Date: Sun, 16 May 2004 10:52:24 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040516085224.GA15680@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([212.34.189.10]:7599 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263380AbUEPIw0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 May 2004 04:52:26 -0400
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-6.6) with ESMTP id i4G8qOQc015719
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 16 May 2004 10:52:24 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id i4G8qOMb015717
	for linux-ide@vger.kernel.org; Sun, 16 May 2004 10:52:24 +0200
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

there's two really strange ifdefs for ide-cs in ide.c:

 - first ide_unregister is resetting hwif->irq only if
   CONFIG_BLK_DEV_IDECS is not set.  This seems really braindead as
   apparently the other drivers don't care (otherwise they wouldn't work
   with CONFIG_BLK_DEV_IDECS), but OTOH I don't see a way ide-cs would
   care for either variant, too - it doesn't touch the hwif anymore
   after unregister.
 - ide_delay_50ms is not sleeping with CONFIG_BLK_DEV_IDECS.  Andre told
   me this was because the pcmcia code didn't allow sleeping in the
   probe routine once upon a time - that's not true anymore, in fact
   ide-cs is calling schedule_timeout just after calling ide_register
   currently..

Is there someone with ide-cs hardware to test whether killing the ifdefs
makes any difference?
