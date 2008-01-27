From: Mikel Olasagasti <hey_neken@mundurat.net>
Subject: No DMA on a Dell Latitude D820 with >2.6.20
Date: Sun, 27 Jan 2008 17:12:00 +0100
Message-ID: <1201450320.8386.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xs2info.com ([82.144.4.27]:52034 "EHLO smtp.mundurat.net"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbYA0QRZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Jan 2008 11:17:25 -0500
Received: from localhost (argala.mundurat.net [127.0.0.1])
	by smtp.mundurat.net (Postfix) with ESMTP id 464C5B840CA
	for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 17:11:40 +0100 (CET)
Received: from smtp.mundurat.net ([127.0.0.1])
	by localhost (argala.mundurat.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1SnFYmRr1P1g for <linux-ide@vger.kernel.org>;
	Sun, 27 Jan 2008 17:11:33 +0100 (CET)
Received: from [192.168.0.100] (215.Red-213-96-129.staticIP.rima-tde.net [213.96.129.215])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mundurat.net (Postfix) with ESMTP id E291EB840C9
	for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 17:11:24 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I'm having problems with my disk on a Latitude D820 after upgrading
kernel to any >2.6.20 No DMA support can be activated, giving me a very
poor I/O performance.

I'm using ata_piix driver on a ICH7 system with no AHCI support AFAIK

I opened a thread[1] on gentoo-forums (the distro I use) with all the
output i think can be interesting.

Hope you can help me guys. Thanks for all :)

[1] http://forums.gentoo.org/viewtopic-p-4731161.html 
-- 
Mikel Olasagasti <hey_neken@mundurat.net>

