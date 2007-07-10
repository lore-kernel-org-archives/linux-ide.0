From: Koen Vermeer <koen@vermeer.tv>
Subject: ICH4 support in ata_piix?
Date: Tue, 10 Jul 2007 11:07:22 +0200
Message-ID: <1184058442.5474.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.versatel.nl ([62.58.50.89]:34139 "EHLO smtp2.versatel.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759532AbXGJJOI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 05:14:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hi,

In driver 2.00ac7 (kernel 2.6.20), my ICH4 (82801DBM) ATA controller
(i855 chipset) was supported in ata_piix.c. In newer versions
(2.10ac1/2.6.21 and later), support seems to have been removed.

I'm looking for information on this change. Is it actually removed, or
just moved to some other driver?

Thanks!

Koen

