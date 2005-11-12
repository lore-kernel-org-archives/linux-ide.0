From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: libata-passthrough problem.
Date: Sat, 12 Nov 2005 10:55:52 +0000
Message-ID: <4375CA38.9000905@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:50956 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S932344AbVKLLzt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Nov 2005 06:55:49 -0500
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-35.mail.demon.net with esmtp (Exim 4.42)
	id 1Eatsm-000EKh-In
	for linux-ide@vger.kernel.org; Sat, 12 Nov 2005 11:49:21 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I am using (at 12-Nov-2005)
git clone 
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

uname -r
2.6.15-rc1-gcd52d1ee

I have found that although smartctl correctly displays different 
information for /dev/sda and /dev/sdb,
hdparm does not.
hdparm displays the same info for /dev/sda and /dev/sdb
i.e. hdparm -I /dev/sdb actually returns the information about /dev/sda

See below for details.

Is this a bug in hdparm or libata-devel ?

James


# smartctl -a /dev/sda
smartctl version 5.33 [i686-pc-linux-gnu] Copyright (C) 2002-4 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

Device: ATA      ST3300831AS      Version: 3.01

# smartctl -a /dev/sdb
smartctl version 5.33 [i686-pc-linux-gnu] Copyright (C) 2002-4 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

Device: ATA      ST3160023AS      Version: 3.18

# hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
	Model Number:       ST3300831AS
	Serial Number:      3NF0A9CQ
	Firmware Revision:  3.01

...

# hdparm -I /dev/sdb

/dev/sdb:

ATA device, with non-removable media
	Model Number:       ST3300831AS
	Serial Number:      3NF0A9CQ
	Firmware Revision:  3.01
