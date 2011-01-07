From: Luo Dislo <dislo_b_j@yahoo.com.tw>
Subject: AHCI support Port Multiplier problem.
Date: Fri, 7 Jan 2011 10:55:14 +0800 (CST)
Message-ID: <134052.7990.qm@web74212.mail.tp2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web74212.mail.tp2.yahoo.com ([116.214.12.104]:38043 "HELO
	web74212.mail.tp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755840Ab1AGDB4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Jan 2011 22:01:56 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Dear Jeff Garzik,


I am using AHCI driver, when CONFIG_SATA_PMP is set and the ahci driver DOES NOT have AHCI_HFLAG_NO_PMP. Libata sends Software Reset with PMP=0xF, trying to detect if Port Multiplier connected to the port. Unfortunately, if I plugged in general Hard drive, my controller failed to identify the hard drive.

What I observed was that libata always sent Software Reset with PMP=0xF and I guessed expecting signature is 0x96690101. I think libata should give up if the device does not return the Port Multiplier signature at the first time and take the signature value from device as the real device connnecting to the port now.

What we said "support" PMP does not mean the port can only connnect to Port Multiplier. It might connect with hard drive or ATAPI device.

Thank you.


Regards,
Dislo


      
