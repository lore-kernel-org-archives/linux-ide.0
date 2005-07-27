From: Siddharth Taneja <staneja@packetdesign.com>
Subject: ICH6R support 2.4.20
Date: Tue, 26 Jul 2005 19:04:17 -0700
Message-ID: <42E6EBA1.8080902@packetdesign.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dns.packetdesign.com ([65.192.41.10]:27909 "EHLO
	mailman.packetdesign.com") by vger.kernel.org with ESMTP
	id S261979AbVG0CEC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Jul 2005 22:04:02 -0400
Received: from [192.168.0.35] (dhcp-168-0-35.packetdesign.com [192.168.0.35])
	by mailman.packetdesign.com (8.12.8/8.12.8) with ESMTP id j6R241a1029367
	for <linux-ide@vger.kernel.org>; Tue, 26 Jul 2005 19:04:01 -0700 (PDT)
	(envelope-from staneja@packetdesign.com)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I am trying to port our software system (uses a 2.4.20 kernel) to a new 
platform which has a ICH6R controller. Due to some reasons we cannot 
update our kernel to a more recent one (probably 2.4.27) which has 
libata support in it. I can successfully patch the kernel (after some 
modifications) with the 2.4.26-libata patch and get the system up and 
running using the drivers/ide code. But I cannot seem to get the 
ata_piix (scsi layer) working (does not patch cleanly). Is there a patch 
available for 2.4.20 that can get the ICH6R support. Or is there a way 
to get the dma mode enabled with the drivers/ide code?

Thanks

Sid
