From: Gary Poppitz <poppitzg@iomega.com>
Subject: old rev of Sil 3112 causes hang
Date: Mon, 28 Feb 2005 14:33:10 -0700
Message-ID: <d98308d552fc858dbbcd5fb9f34c9619@iomega.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Received: from email-mx2.iomega.com ([147.178.1.73]:6574 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S261755AbVB1Va1
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Feb 2005 16:30:27 -0500
Received: from emailmx0.iomega.com (hubble [147.178.1.70])
	by email.iomega.com (Postfix) with ESMTP id 5AE891A8A
	for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2005 14:30:23 -0700 (MST)
Received: from royntex01.iomegacorp.com (unknown [147.178.90.120])
	by emailmx0.iomega.com (Postfix) with ESMTP id 4EA7A6DD
	for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2005 21:30:23 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Another tidbit to save somebody some time. We had a SiiG SC-SAT212 SATA 
card that caused our system to hang. It uses the Silicon Image 3112.

Turns out it was sending interrupts back after a IDENTIFY_DEVICE 
command which the driver ignored. This caused the irq to be shut off 
and then we were hung.

Turns out that the 3112 version was 1.1 but we had another card and its 
3112 was rev 1.21.

This one worked correctly. So, if you have one of these cards, make 
sure the 3112 is at least a 1.21 rev.


