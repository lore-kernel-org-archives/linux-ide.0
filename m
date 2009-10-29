From: Peter Klotz <peter.klotz@aon.at>
Subject: Does ICH9M support eSATA Port Multiplier?
Date: Thu, 29 Oct 2009 20:36:03 +0100
Message-ID: <4AE9EEA3.1040404@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-warsl417-02.aon.at ([195.3.96.120]:50837 "EHLO email.aon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753159AbZJ2Tmm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Oct 2009 15:42:42 -0400
Received: from smarthub91.highway.telekom.at (HELO email.aon.at) ([172.18.5.238])
          (envelope-sender <peter.klotz@aon.at>)
          by fallback43.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 29 Oct 2009 19:36:06 -0000
Received: from 91-115-38-32.adsl.highway.telekom.at (HELO [192.168.0.102]) ([91.115.38.32])
          (envelope-sender <peter.klotz@aon.at>)
          by smarthub91.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 29 Oct 2009 19:36:03 -0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have the following setup:

Notebook (Ubuntu 9.10, 2.6.31-14 amd64) with ICH9M controller in AHCI 
mode and an external storage box (Sil5744, 2 HDDs) connected via eSATA.

The box supports JBOD and the manufacturer says that a Port Multiplier 
capable eSATA port is needed to see both HDDs.

I see only one HDD.

Here is part of the dmesg output from startup:

[    0.725096] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 4 ports 3 Gbps 
0x23 impl SATA mode
[    0.725099] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo 
pio slum part ems


The pmp flag is not present but several sources claim that ICH9 supports 
Port Multiplier.

Should Port Multiplier be available for ICH9M?
Can I enable it somehow maybe by using a module option?

Regards, Peter.
