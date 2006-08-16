From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: More ATA corner cases
Date: Wed, 16 Aug 2006 13:39:22 +0100
Message-ID: <1155731962.24077.346.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1930 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751135AbWHPMTY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Aug 2006 08:19:24 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Any objection to me adding a new cable type for "40 wire ATA66 capable"
to indicate the laptop vendor has been sneaky and we should do full UDMA
ranges regardless of drive or other controller reporting.

Alan

