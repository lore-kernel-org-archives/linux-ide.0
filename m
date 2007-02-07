From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Impact of no_lba48{_dma} = 1 ?
Date: Wed, 07 Feb 2007 10:56:14 +0100
Message-ID: <45C9A23E.3030201@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:47900 "EHLO
	mx1.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030616AbXBGJ4R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Feb 2007 04:56:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx1.imc-berlin.de (Postfix) with ESMTP id 01CD71457B
	for <linux-ide@vger.kernel.org>; Wed,  7 Feb 2007 10:56:16 +0100 (CET)
Received: from mx1.imc-berlin.de ([127.0.0.1])
	by localhost (mx1.imc-berlin.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Xznx5h7fkbv for <linux-ide@vger.kernel.org>;
	Wed,  7 Feb 2007 10:56:15 +0100 (CET)
Received: from mailserver.berlin.imc-berlin.de (mailserver.berlin.imc-berlin.de [10.0.0.19])
	by mx1.imc-berlin.de (Postfix) with ESMTP id E11DD1457A
	for <linux-ide@vger.kernel.org>; Wed,  7 Feb 2007 10:56:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id D476410B07
	for <linux-ide@vger.kernel.org>; Wed,  7 Feb 2007 10:56:15 +0100 (CET)
Received: from [10.0.2.10] (scholz.berlin.imc-berlin.de [10.0.2.10])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id E7A87A071
	for <linux-ide@vger.kernel.org>; Wed,  7 Feb 2007 10:56:14 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

on our embedded system we connected a HDD via FPGA driectly to the CPU.
And wrote a evry simple IDE driver for it. BAsicly the HDD internbal
registers are just memory mapped. No DMA is supported by the hardware.
But I think it would be capable of 48bit LBA mode (which just means setting
the HOB bit in the device control register of the HDD correctly?)

Now I wonder what the impact of setting

	hwif->no_lba48 = 1;		/* 1 = cannot do LBA48 */
	hwif->no_lba48_dma = 1;		/* 1 = cannot do LBA48 DMA */

would be.

IIUC then no_lba48 would limit the useable size to 130GB?
Will every HDD work with no_lba48 set to 1? Even those which actually
support 48bit LBA?

How about performance impact of

		if (hwif->no_lba48 || hwif->no_lba48_dma)
			hwif->rqsize = 256;
		else
			hwif->rqsize = 65536;

in ide-probe.c ?

Thanks a million for any pointers!

Steven
