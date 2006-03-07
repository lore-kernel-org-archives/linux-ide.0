From: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: libata: why do we need to define ATA_ENABLE_PATA instead of a CONFIG option?
Date: Mon, 6 Mar 2006 17:04:44 -0800
Message-ID: <20060307010444.GA6799@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.siteground.net ([207.218.208.2]:51129 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932570AbWCGBEH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Mar 2006 20:04:07 -0500
Received: from adsl-69-227-37-145.dsl.pltn13.pacbell.net ([69.227.37.145]:25611 helo=localhost.localdomain)
	by serv01.siteground.net with esmtpa (Exim 4.52)
	id 1FGQcQ-0002dN-2a
	for linux-ide@vger.kernel.org; Mon, 06 Mar 2006 19:04:06 -0600
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Currently, we can use the piix ide driver for Intel ICH5 IDE controllers, or
use ata_piix (libata) by #defining ATA_ENABLE_PATA manually at
inclulde/linux/libata.h.  Why not have a CONFIG option to enable libata for such
drivers instead of a #define in the code? I was wondering if there is any
reason it is done this way.

Thanks,
Kiran
