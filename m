From: "sam song" <sam_song@usish.com>
Subject: Issuing a vendor specific ATA cmd on SATA Disk via ATA Pass Thru
Date: Thu, 29 Nov 2007 18:34:20 +0800
Message-ID: <004d01c83273$68ded140$6539a8c0@usish.com.cn>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from usish.com ([210.5.144.203]:35563 "EHLO sr3.usish.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbXK2K4z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Nov 2007 05:56:55 -0500
Received: from ms.usish.com (ms.usish.com [192.168.40.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sr3.usish.com (Postfix) with ESMTP id 01878D83E1
	for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 18:34:00 +0800 (CST)
Received: from outbound.usish.com (inbound.usish.com [192.168.40.103])
	by ms.usish.com (8.12.11/8.12.11) with ESMTP id lATAXVbF027202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 18:33:31 +0800
Received: from outbound.usish.com (localhost.localdomain [127.0.0.1])
	by outbound.usish.com (8.12.11/8.12.11) with ESMTP id lATAXW2g015460
	for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 18:33:32 +0800
Received: from IT0010705 (usish-hw-test02 [192.168.57.101] (may be forged))
	(authenticated bits=0)
	by outbound.usish.com (8.12.11/8.12.11) with ESMTP id lATAXS5N015451
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 18:33:31 +0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I am convinced that the SATA Disk does support one vendor specific ATA
command and got the whole bus trace via Trainer.
However, I cannot implement that in the real cases with either HBA or SATA
Controller like ICH5/7 via ATA Pass Thru.
So I wonder whether there is one possible setup including HW and SW
supporting the ATA command via ATA Pass directly and no need to understand
the command meaning itself.

Here is one result I got.

[<unknown opcode>: 85 0b 06 00 01 00 00 00 00 00 00 00 00 e0 fd 00 ]
  scsi_status=0x2, host_status=0x0, driver_status=0x8
  info=0x1  duration=270111 milliseconds
  status=0x2: sense_key=0x7 asc=0x1 ascq=0x0

The command can execute successfully partly but not finally.

HW and Kernel info: 

00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev
02)
The kernel is Linux- 2.6.9-34.EL.

Highly appreciate your input,

Sam Song

