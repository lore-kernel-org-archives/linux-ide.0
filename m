From: Robin Humble <rjh@cita.utoronto.ca>
Subject: Re: sata_sil via and seagate
Date: Mon, 10 Jul 2006 04:30:47 -0400
Message-ID: <20060710083046.GA23220@lemming.cita.utoronto.ca>
References: <20060705212835.GA28904@lemming.cita.utoronto.ca> <44AFE14E.9000600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from quail.cita.utoronto.ca ([128.100.76.6]:45520 "EHLO
	quail.cita.utoronto.ca") by vger.kernel.org with ESMTP
	id S1751358AbWGJIar (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Jul 2006 04:30:47 -0400
Received: from cita.utoronto.ca (lemming.cita.utoronto.ca [128.100.76.53])
	by quail.cita.utoronto.ca (8.13.1/8.13.1) with ESMTP id k6A8Ulm0030965
	for <linux-ide@vger.kernel.org>; Mon, 10 Jul 2006 04:30:47 -0400
Received: from lemming.cita.utoronto.ca (localhost [127.0.0.1])
	by cita.utoronto.ca (8.13.6/8.12.8) with ESMTP id k6A8Ul1c023280
	for <linux-ide@vger.kernel.org>; Mon, 10 Jul 2006 04:30:47 -0400
Received: (from rjh@localhost)
	by lemming.cita.utoronto.ca (8.13.6/8.13.6/Submit) id k6A8UlFc023279
	for linux-ide@vger.kernel.org; Mon, 10 Jul 2006 04:30:47 -0400
Content-Disposition: inline
In-Reply-To: <44AFE14E.9000600@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Sun, Jul 09, 2006 at 01:46:06AM +0900, Tejun Heo wrote:
>Robin Humble wrote:
>>irq 4: nobody cared (try booting with the "irqpoll" option)
>> <c013579a> __report_bad_irq+0x36/0x7d  <c0135962> 
...
>>ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
>>ata1: dev 0 ATA-7, max UDMA/133, 625142448 sectors: LBA48
>>ata1: qc timeout (cmd 0xef)
>>ata1: failed to set xfermode (err_mask=0x4)
>>scsi0 : sata_sil
>>ata2: SATA link down (SStatus 0)
>>scsi1 : sata_sil
>Can you try libata-tj-stable patch?
>http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17.4-20060708.tar.bz2

yup - that works fine. thanks! another happy test marmot :-)

I tried it with the new 320G seagate 7200.10 drive (55MB/s writes,
68MB/s reads with bonnie++), and also with an old seagate 7200.7, and
a 500G maxtor diamondmax 11 (which didn't work before).
none require the irqpoll boot option and all seem to work fine.

many thanks to all involved.

cheers,
robin
