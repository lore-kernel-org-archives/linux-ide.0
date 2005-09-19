From: =?ISO-8859-2?Q?Jakub_Krzy=BFewski?= <jkrzyz@wprost.pl>
Subject: libata, two PDC40719 and problems
Date: Mon, 19 Sep 2005 13:15:43 +0200
Message-ID: <432E9DDF.5090304@wprost.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.wprost.pl ([62.233.203.3]:38661 "EHLO hera.wprost.pl")
	by vger.kernel.org with ESMTP id S1750746AbVISLPv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Sep 2005 07:15:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by hera.wprost.pl (Postfix) with ESMTP id 9C1B61A7DBE
	for <linux-ide@vger.kernel.org>; Mon, 19 Sep 2005 13:15:44 +0200 (CEST)
Received: from hera.wprost.pl ([127.0.0.1])
 by localhost (hera.wprost.pl [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 92004-01-8 for <linux-ide@vger.kernel.org>;
 Mon, 19 Sep 2005 13:15:43 +0200 (CEST)
Received: from [192.168.0.27] (masquerade.wprost.pl [217.17.41.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hera.wprost.pl (Postfix) with ESMTP id EB65E1A7DB6
	for <linux-ide@vger.kernel.org>; Mon, 19 Sep 2005 13:15:43 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi.

Sorry about my bad english.

I have fresh new linux box, based on P4 and intell motherboard.
I put in two FastTrack TX4300 controllers and eight Sygate 200GB hard 
drives.
Driver sata_promise in latest kernel (2.6.13) don't support PDC40719 chip.
Some googling and modification sata_promise.c make it working. PDC20319 
driver works almost perfect.

I set up software RAID5 with all 8 disks and make some tests, without 
problems.
Then i start moving data to my raid and got two scsi errors, first one 
three days ago and second one next day.
Here is log:

Sep 16 14:02:27 kernel: ata1: status=0x25 { DeviceFault CorrectedError 
Error }
Sep 16 14:02:27 kernel: SCSI error : <0 0 0 0> return code = 0x8000002
Sep 16 14:02:27 kernel: sda: Current: sense key: Hardware Error
Sep 16 14:02:27 kernel:     Additional sense: No additional sense 
information
Sep 16 14:02:27 kernel: end_request: I/O error, dev sda, sector 17488831

Sep 17 14:35:05 kernel: ata7: status=0x25 { DeviceFault CorrectedError 
Error }
Sep 17 14:35:05 kernel: SCSI error : <6 0 0 0> return code = 0x8000002
Sep 17 14:35:05 kernel: sdg: Current: sense key: Hardware Error
Sep 17 14:35:05 kernel:     Additional sense: No additional sense 
information
Sep 17 14:35:05 kernel: end_request: I/O error, dev sdg, sector 311289367

I check disks with smartctl and both have no errors in logs.
I add both disks back to raid with success.

ACPI is turned on in kernel.
HT and SMP is turned on.

I'm looking for any help in spotting problem.

THANK YOU IN ADVANCE.





