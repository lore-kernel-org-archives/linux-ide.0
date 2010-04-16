From: "Keshav P.R." <skodabenz@rocketmail.com>
Subject: GPT fdisk
Date: Fri, 16 Apr 2010 23:36:16 +0530 (IST)
Message-ID: <721544.69241.qm@web95511.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from n8-vm0.bullet.mail.in.yahoo.com ([202.86.4.189]:41927 "HELO
	n8-vm0.bullet.mail.in.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757592Ab0DPSGU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Apr 2010 14:06:20 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

Hi, I am Keshav from India. I read https://ata.wiki.kernel.org/index.php/ATA_4_KiB_sector_issues page which was very informative. I currently do not have any 4K sector drives but regarding GPT-4K sector support, check out this software http://rodsbooks.com/gdisk/ . This is currently the best GPT software (which is also cross-platform).

I also have a question :- If I have a 4K sector internal HDD (without any jumpers etc. ie. the drive shows itself as 4K logical sector size), will there be any difference in behaviour of linux with these drives with respect to Legacy-IDE SATA mode and AHCI SATA mode options available in the BIOS ? Thank you.



