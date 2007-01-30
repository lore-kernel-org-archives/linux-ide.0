From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: HPA and failed opcode was: 0x37 ?
Date: Tue, 30 Jan 2007 15:02:43 +0100
Message-ID: <45BF5003.3000503@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:4517 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965511AbXA3ObI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 09:31:08 -0500
Received: from mailserver.berlin.imc-berlin.de (mailserver.berlin.imc-berlin.de [10.0.0.19])
	by mail.imc-berlin.de (Postfix) with ESMTP id 91B4C2F02C
	for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 15:57:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 57B5410946
	for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 15:02:44 +0100 (CET)
Received: from [10.0.2.10] (scholz.berlin.imc-berlin.de [10.0.2.10])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 6D102A071
	for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 15:02:43 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

I get the following lines when starting my ide driver:

Probing IDE interface ide0...
hda: probing with STATUS(0x50) instead of ALTSTATUS(0xff)
hda: ST940813AM, ATA DISK drive
ide0 at 0xc3866000-0xc3866007,0xc3866010 on irq 30
hda: max request size: 1024KiB
hda: Host Protected Area detected.
        current capacity is 78140160 sectors (40007 MB)
        native  capacity is 185074430006016 sectors (94758108163 MB)
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
ide: failed opcode was: 0x37
hda: 78140160 sectors (40007 MB) w/8192KiB Cache, CHS=16383/255/63
hda: cache flushes supported
 hda: hda1


My quetsions are:

1. what's that 185074430006016 sectors native capacity about?
2. Opcode 0x37 seems to be WIN_SET_MAX_EXT.
   What does it mean if it fails?

Thanks a million.

(I am uisng linux 2.6.14 on an embedded ARM9 system.)

Steven

