From: Gary Poppitz <poppitzg@iomega.com>
Subject: Issues with SIS 964 chipset on SATA
Date: Mon, 7 Feb 2005 12:02:56 -0700
Message-ID: <E0854782-793A-11D9-A80A-000A95D2AC6A@iomega.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Received: from email-mx1.iomega.com ([147.178.1.72]:47076 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S261248AbVBGTBJ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Feb 2005 14:01:09 -0500
Received: from emailmx0.iomega.com (hubble [147.178.1.70])
	by email.iomega.com (Postfix) with ESMTP id CAC881D11
	for <linux-ide@vger.kernel.org>; Mon,  7 Feb 2005 12:01:03 -0700 (MST)
Received: from royntex01.iomegacorp.com (unknown [147.178.90.120])
	by emailmx0.iomega.com (Postfix) with ESMTP id C13D36D4
	for <linux-ide@vger.kernel.org>; Mon,  7 Feb 2005 19:01:03 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

We tracked down a problem with the 964 chipset with a 0x180 ID code 
that may save someone on the list some time.

The chip will only transfer multiples of 4 bytes. Anything else will 
cause it to hang.

Our specific case occurred in cdrom.c in cdrom_get_disc_info.

There the code asks for 2 bytes to get the data length and in our case, 
got a value of 34 bytes to read.

Both transfers would fail if not rounded up.


The next part that is interesting is that this error caused the process 
to hang. There was an assertion failure in ata_qc_complete for 
qc->flags & ATA_QUEUE_ACTIVE.

Again, in our case, when the 2 byte transfer failed, the attempt at the 
next read would hang the process when it attempted to queue the 
command. There is wait for lock which never gets satisfied.

It may be that this SIS error has uncovered an issue in the Linux code. 
If anyone who understands the command queueing process would like more 
trace data, I will try to provide it.

Gary Poppitz
Iomega

