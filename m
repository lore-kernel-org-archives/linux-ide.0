From: Gary Poppitz <poppitzg@iomega.com>
Subject: More SIL 3112 intrigue
Date: Thu, 10 Mar 2005 11:09:54 -0700
Message-ID: <f18da98a12644f676a04edf0ff38962e@iomega.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Received: from email-mx1.iomega.com ([147.178.1.72]:6554 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S262778AbVCJSG7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Mar 2005 13:06:59 -0500
Received: from emailmx0.iomega.com (hubble [147.178.1.70])
	by email.iomega.com (Postfix) with ESMTP id 248921823
	for <linux-ide@vger.kernel.org>; Thu, 10 Mar 2005 11:06:51 -0700 (MST)
Received: from royntex01.iomegacorp.com (unknown [147.178.90.120])
	by emailmx0.iomega.com (Postfix) with ESMTP id 189626D7
	for <linux-ide@vger.kernel.org>; Thu, 10 Mar 2005 18:06:51 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

As you might remember, the 3112 was giving us grief by sending a flood 
of interrupts when doing the IDENTIFY ATAPI  DEVICE (0xA1) command.

This was on a rev 1,1 chip.

When we tried a rev 1.21 chip, the problem was  corrected.

Now it appears that even the rev 1.21 chip will flood us with 
interrupts when doing the
IDENTIFY ATA  DEVICE (0xEC) command.

Im getting to not like Silicon Image.

