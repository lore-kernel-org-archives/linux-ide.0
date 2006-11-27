From: Sami Farin <atafarin@suomi24.fi>
Subject: Intel DQ965GF experiences
Date: Tue, 28 Nov 2006 00:42:43 +0100 (CET)
Message-ID: <28592001.1164670963316.JavaMail.apache@eni-cpps11.sth.basefarm.net>
Reply-To: Sami Farin <atafarin@suomi24.fi>
Mime-Version: 1.0
Content-Type: text/plain;charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eni-mailout01.sth.basefarm.net ([80.76.148.7]:30181 "EHLO
	eni-mailout01.sth.basefarm.net") by vger.kernel.org with ESMTP
	id S1758622AbWK0Xmp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Nov 2006 18:42:45 -0500
Received: from [10.7.4.193] (port=38892 helo=eni-cpps11.sth.basefarm.net)
	by eni-mailout01.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.60)
	(envelope-from <atafarin@suomi24.fi>)
	id 1Goq7Y-00076N-3o
	for linux-ide@vger.kernel.org; Tue, 28 Nov 2006 00:42:44 +0100
Received: from localhost ([127.0.0.1]:38888 helo=eni-cpps11.sth.basefarm.net)
	by eni-cpps11.sth.basefarm.net with esmtp (Exim 4.60)
	(envelope-from <atafarin@suomi24.fi>)
	id 1Goq7X-0004r0-N9
	for linux-ide@vger.kernel.org; Tue, 28 Nov 2006 00:42:43 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I had to buy new motherboard because old one blew up,and I heard Intel 
is Linux-friendly (thinking of drivers forNIC, graphics, audio, 
SATA),...So I got DQ965GF. Earlier I had also used Intel's ATA chipset 
(since year 1999),and the piix driver without problems. But now when I 
boot with this "production-quality"driver, I get with 2.6.18.3: 
ata_piix 0000:00:1F:2: MAP [ P0 -- P1 -- ]...ATA: abnormal status 0x7F 
on port 0x214F...and it can't find block devices.2.6.16 also ways "port 
disabled".What is 0x7F supposed to mean and is it against the specs or 
something?I have tried various options for ten hours, and I ran out of 
imagination.Maybe someone can suggest something. First I would like to 
bootthe system with or without DMA, then optimize later.I have two PATA 
hard disks connected on the motherboard and no SATA stuffs.I tried to 
get lspci output in Knoppix, but it freezes after I press enter in the 
boot menu.And no serial console etc.
