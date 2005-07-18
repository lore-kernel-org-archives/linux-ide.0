From: Kelly McDonald <Kelly.McDonald@vistashare.com>
Subject: Promise SATA 300 TX2+ works w/ sata_promise
Date: Mon, 18 Jul 2005 10:16:56 -0400
Message-ID: <1121696216.11954.5.camel@shadrach>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta10.adelphia.net ([68.168.78.202]:63741 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S261759AbVGRORI
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Jul 2005 10:17:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Jeff,

I added my promise Sata 300 TX2+ to the sata_promise driver:


lspci: 

0000:02:0a.0 Unknown mass storage controller: Promise Technology, Inc.:
Unknown device 3d73 (rev 02)


change made: (2.6.11.11 kernel)

163,164d162
<       { PCI_VENDOR_ID_PROMISE, 0x3d73, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
<         board_2037x },

Haven't tried on-board ide pata yet.

Regards, 
Kelly McDonald.

-- 

