From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Better support for Serial ATA Hard Discs.
Date: Mon, 16 Aug 2004 17:00:15 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4120DA0F.4060506@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:10502 "EHLO
	anchor-post-37.mail.demon.net") by vger.kernel.org with ESMTP
	id S267791AbUHPQAU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Aug 2004 12:00:20 -0400
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-37.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1BwjuC-0004eg-0b
	for linux-ide@vger.kernel.org; Mon, 16 Aug 2004 16:00:16 +0000
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a SATA HD, and my motherboard can talk to it using PATA or SATA.
Using PATA, the SATA HD appears to linux as an IDE HD. So I can use 
hdparm on it, and therefore set sleep/power down times. e.g. hdparm -S60 
/dev/hda

Using SATA, the SATA HD appears to linux as a SCSI HD. I can use hdparm 
on it, but it is limited. e.g. hdparm -S60 /dev/sda  <- Will not work.

I am using linux kernel 2.6.8.
Should I be using some different tool for setting sleep/power down times 
when using the SATA HD in SATA mode?

I would also like to get hddtemp to work with SATA HDs as well.

Can anyone advise me on what to do next?

James

