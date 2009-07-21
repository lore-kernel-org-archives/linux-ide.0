From: =?ISO-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>
Subject: Seagate 1.5TB x Suspend
Date: Tue, 21 Jul 2009 07:50:38 -0300
Message-ID: <u4jgj6-qu5.ln1@tux.abusar.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:36095 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754440AbZGUKzI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Jul 2009 06:55:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MTCzu-0003Us-Ki
	for linux-ide@vger.kernel.org; Tue, 21 Jul 2009 10:55:02 +0000
Received: from c9345450.virtua.com.br ([201.52.84.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 21 Jul 2009 10:55:02 +0000
Received: from fragabr by c9345450.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 21 Jul 2009 10:55:02 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Linux 2.6.30
Asus M2N-E motherboard (nVidia MCP55 SATA Controller (rev a2))

	I bought a Seagate 1.5TB HD (ST31500341AS, CC1H) and I noticed
that when I resume from suspend, it shows the following:

Jul 20 20:07:46 tux kernel: ata1: link is slow to respond, please be patient (ready=-19)
Jul 20 20:07:46 tux kernel: ata1: SRST failed (errno=-16)
Jul 20 20:07:46 tux kernel: ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jul 20 20:07:46 tux kernel: ata1.00: ACPI cmd ef/03:46:00:00:00:a0 filtered out
Jul 20 20:07:46 tux kernel: ata1.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
Jul 20 20:07:47 tux kernel: ata1.00: configured for UDMA/133
Jul 20 20:07:47 tux kernel: Restarting tasks ... done.

	I think it's not harmful, since everything is working correclty, but I 
want to ask you if I should be concerned about this.

	Thank you very much.

-- 
Linux 2.6.30: Man-Eating Seals of Antiquity


