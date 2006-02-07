From: sftf <sftf-misc@mail.ru>
Subject: SATA libata future
Date: Tue, 7 Feb 2006 13:36:58 +0600
Message-ID: <16110458224.20060207133658@mail.ru>
Reply-To: sftf <sftf-misc@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx3.mail.ru ([194.67.23.149]:46629 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S964993AbWBGHiY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Feb 2006 02:38:24 -0500
Received: from [195.162.52.178] (port=33283 helo=SF)
	by mx3.mail.ru with asmtp
	id 1F6NQK-0005QH-00
	for linux-ide@vger.kernel.org; Tue, 07 Feb 2006 10:38:04 +0300
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi!
Would you tell me, please,
what driver will be supported (and better to use)
in the future Linux kernels?

1. ATA/ATAPI/MFM/RLL support
[*] Support for SATA (deprecated)

or

2. SCSI device support->SCSI low-level drivers
[*] Serial ATA (SATA) support 

My "problem" is in second case
more then 15 partions not supported:
before upgrade from 2.6.7 to 2.6.15.1
I have 16 partions on disk.
Oh, and /dev/hdx changed to /dev/sdx.

So what our future fate:
IDE  SATA /dev/hdx with up to 63 partitions or
SCSI SATA /dev/sdx with up to 15 partitions?

Thanks a lot!
Sorry for bad English.
mailto:sftf-misc@mail.ru

