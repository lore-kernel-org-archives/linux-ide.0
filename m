From: Tejun Heo <htejun@gmail.com>
Subject: Re: regression problem with Maxtor disk
Date: Tue, 14 Aug 2007 18:50:24 +0900
Message-ID: <46C17AE0.5090601@gmail.com>
References: <87tzr4zvpt.fsf@wyrd.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:44696 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbXHNJul (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Aug 2007 05:50:41 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1394807rvb
        for <linux-ide@vger.kernel.org>; Tue, 14 Aug 2007 02:50:40 -0700 (PDT)
In-Reply-To: <87tzr4zvpt.fsf@wyrd.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lieven Marchand <mal@wyrd.be>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Robert Hancock <hancockr@shaw.ca>

[cc'ing Robert Hancock and quoting the whole message for him]

Lieven Marchand wrote:
> Hi,
> 
> the following drive 
> 
> Aug 12 12:26:15 black kernel:   Vendor: ATA       Model: Maxtor 7H500F0    Rev:
> HA43
> Aug 12 12:26:15 black kernel:   Type:   Direct-Access                      ANSI
> SCSI revision: 05
> 
> works fine under 2.6.18 and crashes the boot procedure under
> 2.6.22. Occasionally the boot continues but most of the times the
> kernel crashes with an error message of a corrupt cpu context.
> 
> I've added the logs of a succesful boot here. When such a boot
> succeeds, the system is noticeably slower than under 2.6.18.
> 
> Aug 11 10:27:51 black kernel: scsi 4:0:0:0: Direct-Access     ATA      Maxtor 7H
> 500F0   HA43 PQ: 0 ANSI: 5
> Aug 11 10:27:51 black kernel: ata2: bounce limit 0xFFFFFFFFFFFFFFFF, segment bou
> ndary 0xFFFFFFFF, hw segs 61
> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA IDLE, stat=0x440
> Aug 11 10:27:51 black kernel:          res 51/04:00:00:00:00/04:00:00:00:00/40 E
> mask 0x1 (device error)
> Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
> Aug 11 10:27:51 black kernel: ata2: EH complete
> 
> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA IDLE, stat=0x440
> Aug 11 10:27:51 black kernel:          res 51/04:00:00:00:00/04:00:00:00:00/40 E
> mask 0x1 (device error)
> Aug 11 10:27:51 black last message repeated 2 times
> Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
> Aug 11 10:27:51 black kernel: ata2: EH complete
> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY clear and ID
> LE, stat=0x440
> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA IDLE, stat=0x400
> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY, stat=0x400
> Aug 11 10:27:51 black kernel:          res 40/00:00:00:00:00/04:00:00:00:00/40 E
> mask 0x4 (timeout)
> Aug 11 10:27:51 black last message repeated 2 times
> Aug 11 10:27:51 black kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 E
> mask 0x4 (timeout)
> Aug 11 10:27:51 black kernel: ata2: soft resetting port
> Aug 11 10:27:51 black kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl
> 300)
> Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
> Aug 11 10:27:51 black kernel: ata2: EH complete
> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY clear and ID
> LE, stat=0x400
> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA IDLE, stat=0x400
> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY, stat=0x400
> Aug 11 10:27:51 black kernel: ata2.00: NCQ disabled due to excessive errors
> Aug 11 10:27:51 black kernel:          res 40/00:00:00:00:00/04:00:00:00:00/40 E
> mask 0x4 (timeout)
> Aug 11 10:27:51 black last message repeated 2 times
> Aug 11 10:27:51 black kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 E
> mask 0x4 (timeout)
> Aug 11 10:27:51 black kernel: ata2: soft resetting port
> Aug 11 10:27:51 black kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl
> 300)
> Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
> Aug 11 10:27:51 black kernel: ata2: EH complete
> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY clear and ID
> LE, stat=0x400
> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA IDLE, stat=0x400
> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY, stat=0x400
> Aug 11 10:27:51 black kernel:          res 40/00:00:00:00:00/04:00:00:00:00/40 E
> mask 0x4 (timeout)
> Aug 11 10:27:51 black kernel: ata2: soft resetting port
> Aug 11 10:27:51 black kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl
> 300)
> Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
> Aug 11 10:27:51 black kernel: ata2: EH complete
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
tejun
