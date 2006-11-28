From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH] libata: waits up to 10 microseconds for early irq problem
Date: Tue, 28 Nov 2006 19:32:58 +0800
Message-ID: <456C1E6A.2050300@tw.ibm.com>
References: <200611180759.34622.t.powa@gmx.de>	<20061118002357.564dbb9d.akpm@osdl.org>	<455F790C.2030509@garzik.org>	<456BDCAC.4060609@tw.ibm.com> <20061128102534.5a42c9b2@localhost.localdomain> <456C0F11.30301@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:56972 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S935865AbWK1Ld1
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Nov 2006 06:33:27 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kASBXPW5016857
	for <linux-ide@vger.kernel.org>; Tue, 28 Nov 2006 06:33:25 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kASBXPx3378584
	for <linux-ide@vger.kernel.org>; Tue, 28 Nov 2006 04:33:25 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kASBXOHu014322
	for <linux-ide@vger.kernel.org>; Tue, 28 Nov 2006 04:33:25 -0700
In-Reply-To: <456C0F11.30301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Mark Lord <mlord@pobox.com>, matthieu castet <castet.matthieu@free.fr>, Tobias Powalowski <t.powa@gmx.de>, Unicorn Chang <uchang@tw.ibm.com>

Tejun Heo wrote:
> 
> 
> Does this early IRQ happen for any command other than SET XFERMODE?
> Generic fix for SET XFERMODE is in the tree now.
> 

Unicorn found his ICH4 + AOpen CD-936E + PIO4 has the early irq problem
with PACKET command READ_10. (The CD-ROM drive is connected to the secondary
channel on legacy irq 15.) Detailed log attched below.

We replaced the AOpen drive with another LITEON drive, and the problem is
no longer reproducible. It looks like related to the specific CD-ROM drive.

--
albert

======
(1. early irq case)
Nov 24 15:05:39 albertnv kernel: CDB (2:0,0,0) 28 00 00 00 00 ed 00 00 01
Nov 24 15:05:39 albertnv kernel: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
Nov 24 15:05:39 albertnv kernel: device 0xA0
Nov 24 15:05:39 albertnv kernel: ata2: cmd 0xA0
Nov 24 15:05:39 albertnv kernel: ata2: protocol 5 task_state 5
Nov 24 15:05:39 albertnv kernel: ata2: protocol 5 task_state 5 (dev_stat 0x58)
Nov 24 15:05:39 albertnv kernel: atapi_send_cdb: send cdb
Nov 24 15:05:39 albertnv kernel: ata2: protocol 5 task_state 2
Nov 24 15:05:39 albertnv last message repeated 6 times    <=== early irq here
Nov 24 15:05:39 albertnv kernel: ata2: protocol 5 task_state 2 (dev_stat 0x58)
Nov 24 15:05:39 albertnv kernel: atapi_pio_bytes: ata2: xfering 2048 bytes
Nov 24 15:05:39 albertnv kernel: __atapi_pio_bytes: data read
Nov 24 15:05:39 albertnv kernel: ata2: protocol 5 task_state 3
Nov 24 15:05:39 albertnv kernel: ata2: protocol 5 task_state 3 (dev_stat 0x50)
Nov 24 15:05:39 albertnv kernel: ata2: dev 0 command complete, drv_stat 0x50
Nov 24 15:05:39 albertnv kernel: atapi_qc_complete: ENTER, err_mask 0x0

(2. normal case)
Nov 24 15:05:40 albertnv kernel: CDB (2:0,0,0) 28 00 00 00 00 ee 00 00 01
Nov 24 15:05:40 albertnv kernel: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
Nov 24 15:05:40 albertnv kernel: device 0xA0
Nov 24 15:05:40 albertnv kernel: ata2: cmd 0xA0
Nov 24 15:05:40 albertnv kernel: ata2: protocol 5 task_state 5
Nov 24 15:05:40 albertnv kernel: ata2: protocol 5 task_state 5 (dev_stat 0x58)
Nov 24 15:05:40 albertnv kernel: atapi_send_cdb: send cdb
Nov 24 15:05:40 albertnv kernel: ata2: protocol 5 task_state 2
Nov 24 15:05:40 albertnv kernel: ata2: protocol 5 task_state 2 (dev_stat 0x58)
Nov 24 15:05:40 albertnv kernel: atapi_pio_bytes: ata2: xfering 2048 bytes
Nov 24 15:05:40 albertnv kernel: __atapi_pio_bytes: data read
Nov 24 15:05:40 albertnv kernel: ata2: protocol 5 task_state 3
Nov 24 15:05:40 albertnv kernel: ata2: protocol 5 task_state 3 (dev_stat 0x50)
Nov 24 15:05:40 albertnv kernel: ata2: dev 0 command complete, drv_stat 0x50
Nov 24 15:05:40 albertnv kernel: atapi_qc_complete: ENTER, err_mask 0x0


