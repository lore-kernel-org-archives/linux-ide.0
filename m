From: "David Engraf" <engraf.david@netcom-sicherheitstechnik.de>
Subject: Question: Hot unplug with AHCI driver
Date: Thu, 8 Dec 2005 08:51:55 +0100
Message-ID: <001201c5fbcc$43c91940$0a016696@EW10>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:29901 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750719AbVLHHwC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Dec 2005 02:52:02 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: 'Jeff Garzik' <jgarzik@pobox.com>

Hi,

I want to add hot unplug support to the AHCI driver. The problem is that the
Intel AHCI R1.1 documentation says that the controller on native hot plug
support should generate an interrupt (PxIS.PCS, PxIS.PRCS). On my Intel
ICH6M board I can see an interrupt but with the port status 0x0. 
The interrupt PxIE.PRCE and PxIE.PCE are set automatically on startup for
each device. So I think the controller must generate a correct interrupt.
Do you have any ideas why the controller makes no/wrong interrupt when I
detach the device (hard disk).

Thanks
David


____________
Virus checked by G DATA AntiVirusKit
Version: AVK 16.2071 from 08.12.2005
Virus news: www.antiviruslab.com

