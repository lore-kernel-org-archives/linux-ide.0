From: Ognyan Kulev <ogi@fmi.uni-sofia.bg>
Subject: [BUG] OPTi 621, chipset revision 18, hangs with enabled DMA
Date: Sat, 31 Jul 2004 14:41:09 +0300
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <410B8555.6090209@fmi.uni-sofia.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lio.fmi.uni-sofia.bg ([62.44.101.7]:38158 "EHLO
	smtp.fmi.uni-sofia.bg") by vger.kernel.org with ESMTP
	id S267939AbUGaLjP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 31 Jul 2004 07:39:15 -0400
Received: from [62.44.101.57] ([62.44.101.57])
	by smtp.fmi.uni-sofia.bg
	for linux-ide@vger.kernel.org;
	Wed, 4 Feb 2004 14:36:42 +0200
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I'm resending here my non-replied post to lkml.  I hope this time to get 
some kind of response.

On my laptop (Compaq Armada 4120), I've used for a long time a Linux 
2.4.20 kernel just because newer kernels hang on partition checks. The 
error was something like the following and it always appeared at 
partition check (this is taken from Internet, but it was similar in my 
case):

Jan 8 22:14:15 darkstar kernel: hda: dma_timer_expiry: dma status == 0x21
Jan 8 22:14:25 darkstar kernel: hda: error waiting for DMA
Jan 8 22:14:25 darkstar kernel: hda: dma timeout retry: status=0x58 { 
DriveReady SeekComplete DataRequest }

After adding "ide=nodma", everything works fine. I see that code in 2.6 
hasn't changed since 2.4 (except because of the API changes in 2.6, of 
course).

So I would like by default DMA to be disabled for OPTi 621 or there to 
be some other resolution. Probably removing the following lines will do 
the work, but I haven't tested it:

if (!noautodma)
	hwif->autodma = 1;

(Some lines above, there is "hwif->autodma=0;".)

BTW In Linux 2.4.19 source, "grep dma drivers/ide/opti621.c" gives nothing.

Regards,
ogi

