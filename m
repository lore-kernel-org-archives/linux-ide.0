From: "Andrew Lyon" <andrew.lyon@gmail.com>
Subject: ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0) r0xj0
Date: Thu, 28 Dec 2006 02:12:48 +0000
Message-ID: <f4527be0612271812p7282de31j98462aebde16e5a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:45785 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964869AbWL1CMu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Dec 2006 21:12:50 -0500
Received: by ug-out-1314.google.com with SMTP id 44so4038070uga
        for <linux-ide@vger.kernel.org>; Wed, 27 Dec 2006 18:12:48 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Hi,

My system is gigabyte ds3 motherboard with onboard SATA JMicron
20360/20363 AHCI Controller (rev 02), drive connected is WDC
WD740ADFD-00 20.0, I am running 2.6.18.6 32 bit, under heavy i/o I get
the following messaegs:

ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)

Is this condition dangerous?

I plan to upgrade to 2.6.19 soon as I have problems with a sata dvd
writer but I have to wait for a driver that I need to catch up, this
system cannot be down for long as it runs mythtv.

Andy
