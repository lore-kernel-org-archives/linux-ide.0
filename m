From: "Kyle Wong" <kylewong@southa.com>
Subject: Confused, libata NCQ supported or not?
Date: Sat, 8 Jan 2005 18:02:25 +0800
Message-ID: <001701c4f569$27d8b020$9d02a8c0@southa.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [152.101.81.89] ([152.101.81.89]:30414 "HELO southa.com")
	by vger.kernel.org with SMTP id S261957AbVAHJxO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Jan 2005 04:53:14 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I'm planning to buy several NCQ enabled harddisks for software RAID purpose.
>From http://linux.yyz.us/sata/sata-status.html#ahci, I got:

"AHCI (Intel ICH[67] currently)
Summary: Full NCQ support, full SATA control including hotplug and PM.
libata driver status: Production."

however, at http://linux.yyz.us/sata/software-status.html

"Even though some SATA host controllers on the market already support
command queueing (a.k.a. "TCQ"), libata does not yet support it."

"Queueing will be enabled in libata soon, but to do so requires a long
stretch of testing on a large variety of controllers and drives. This is
very time-intensive, and is the largest part of this task."

So .... does libata can do NCQ or not now?

Kyle


