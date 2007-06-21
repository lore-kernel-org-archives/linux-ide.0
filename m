From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] ide dma_timer_expiry, then hard lockup
Date: Thu, 21 Jun 2007 23:04:49 +0100
Message-ID: <20070621230449.702b5b2e@the-village.bc.nu>
References: <20070618175713.GD5836@austin.ibm.com>
	<4677FFF1.2010308@ru.mvista.com>
	<20070619164854.GR5836@austin.ibm.com>
	<200706192043.40298.bzolnier@gmail.com>
	<46783777.10607@ru.mvista.com>
	<20070620162845.GY5836@austin.ibm.com>
	<20070620180123.642316ae@the-village.bc.nu>
	<20070621194731.GB8840@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35803 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755337AbXFUV7h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jun 2007 17:59:37 -0400
In-Reply-To: <20070621194731.GB8840@austin.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Stuart_Hayes@dell.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> sd 0:0:0:0 [sda] Done: 0xeff3aba0 TIMEOUT
> sd 0:0:0:0 [sda] Result: host_byte=DID_OK driver_byte=DRV_OK, SUG_OK
> sd 0:0:0:0 [sda] CDB: Read(10): 28 00 00 ... 00 08 00
> sd 0:0:0:0 [sda] scsi host busy 1 failed 0
> ata_scsi_timed_out: ENTER
> ata_scsi_timed_out: EXIT, ret=0
> ata_port_flush_task: ENTER
> ata_port_flush_task: flush #1
> ata1: ata_port_flush_task: flush #2
> ata_port_flush_task: EXIT
> 
> Then a hard hang here.

Thanks 

Added to my bug collection to peer at.
