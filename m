From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Old errata docs
Date: Mon, 25 Feb 2008 17:37:57 +0000
Message-ID: <20080225173757.3ffe70d9@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35030 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753441AbYBYRsA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Feb 2008 12:48:00 -0500
Received: from core (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id m1PHbwJK019691
	for <linux-ide@vger.kernel.org>; Mon, 25 Feb 2008 17:37:58 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>

Does anyone have in their posession the old errata docs for the HPT370
controller. I'm seeing two reports now where there is some kind of FIFO
corruption pattern (shifted data and duplicated dwords) on the drives
which are UDMA100 blacklisted, so presumably more is required for the
workaround.

Alan
