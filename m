From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 0/3] OF-platform PATA driver
Date: Tue, 27 Nov 2007 18:37:08 +0300
Message-ID: <20071127153708.GA12490@localhost.localdomain>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:7257 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752252AbXK0PcR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 10:32:17 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, Vitaly Bordug <vitb@kernel.crashing.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jeff@garzik.org>

Hi all,

Here is the second spin of the OF-platform PATA driver and
related patches.

Changes since RFC:
- nuked drivers/ata/pata_platform.h;
- powerpc bits: proper localbus node added.


Thanks for the previous review! This time I'm collecting acks,
don't be shy to give 'em generously. ;-)


Good luck,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
