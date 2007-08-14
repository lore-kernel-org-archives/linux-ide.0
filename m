From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: regression problem with Maxtor disk
Date: Tue, 14 Aug 2007 17:14:14 -0600
Message-ID: <46C23746.6030203@shaw.ca>
References: <87tzr4zvpt.fsf@wyrd.be> <46C17AE0.5090601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:39627 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762739AbXHNXOt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Aug 2007 19:14:49 -0400
Received: from pd2mr1so.prod.shaw.ca
 (pd2mr1so-qfe3.prod.shaw.ca [10.0.141.110]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JMS00C17DW1VW90@l-daemon> for linux-ide@vger.kernel.org; Tue,
 14 Aug 2007 17:14:25 -0600 (MDT)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
 by pd2mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JMS00IPRDW0AF80@pd2mr1so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Tue, 14 Aug 2007 17:14:25 -0600 (MDT)
Received: from [192.168.1.113] ([70.64.1.86])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JMS00FKXDVZISE0@l-daemon> for linux-ide@vger.kernel.org; Tue,
 14 Aug 2007 17:14:23 -0600 (MDT)
In-reply-to: <46C17AE0.5090601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Lieven Marchand <mal@wyrd.be>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> [cc'ing Robert Hancock and quoting the whole message for him]
> 
> Lieven Marchand wrote:
>> Hi,
>>
>> the following drive 
>>
>> Aug 12 12:26:15 black kernel:   Vendor: ATA       Model: Maxtor 7H500F0    Rev:
>> HA43
>> Aug 12 12:26:15 black kernel:   Type:   Direct-Access                      ANSI
>> SCSI revision: 05
>>
>> works fine under 2.6.18 and crashes the boot procedure under
>> 2.6.22. Occasionally the boot continues but most of the times the
>> kernel crashes with an error message of a corrupt cpu context.
>>
>> I've added the logs of a succesful boot here. When such a boot
>> succeeds, the system is noticeably slower than under 2.6.18.
>>
>> Aug 11 10:27:51 black kernel: scsi 4:0:0:0: Direct-Access     ATA      Maxtor 7H
>> 500F0   HA43 PQ: 0 ANSI: 5
>> Aug 11 10:27:51 black kernel: ata2: bounce limit 0xFFFFFFFFFFFFFFFF, segment bou
>> ndary 0xFFFFFFFF, hw segs 61
>> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA IDLE, stat=0x440
>> Aug 11 10:27:51 black kernel:          res 51/04:00:00:00:00/04:00:00:00:00/40 E
>> mask 0x1 (device error)
>> Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
>> Aug 11 10:27:51 black kernel: ata2: EH complete
>>
>> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA IDLE, stat=0x440
>> Aug 11 10:27:51 black kernel:          res 51/04:00:00:00:00/04:00:00:00:00/40 E
>> mask 0x1 (device error)
>> Aug 11 10:27:51 black last message repeated 2 times
>> Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
>> Aug 11 10:27:51 black kernel: ata2: EH complete
>> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY clear and ID
>> LE, stat=0x440
>> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA IDLE, stat=0x400
>> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY, stat=0x400
>> Aug 11 10:27:51 black kernel:          res 40/00:00:00:00:00/04:00:00:00:00/40 E
>> mask 0x4 (timeout)
>> Aug 11 10:27:51 black last message repeated 2 times
>> Aug 11 10:27:51 black kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 E
>> mask 0x4 (timeout)
>> Aug 11 10:27:51 black kernel: ata2: soft resetting port
>> Aug 11 10:27:51 black kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl
>> 300)
>> Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
>> Aug 11 10:27:51 black kernel: ata2: EH complete
>> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY clear and ID
>> LE, stat=0x400
>> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA IDLE, stat=0x400
>> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY, stat=0x400
>> Aug 11 10:27:51 black kernel: ata2.00: NCQ disabled due to excessive errors
>> Aug 11 10:27:51 black kernel:          res 40/00:00:00:00:00/04:00:00:00:00/40 E
>> mask 0x4 (timeout)
>> Aug 11 10:27:51 black last message repeated 2 times
>> Aug 11 10:27:51 black kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 E
>> mask 0x4 (timeout)
>> Aug 11 10:27:51 black kernel: ata2: soft resetting port
>> Aug 11 10:27:51 black kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl
>> 300)
>> Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
>> Aug 11 10:27:51 black kernel: ata2: EH complete
>> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY clear and ID
>> LE, stat=0x400
>> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA IDLE, stat=0x400
>> Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY, stat=0x400
>> Aug 11 10:27:51 black kernel:          res 40/00:00:00:00:00/04:00:00:00:00/40 E
>> mask 0x4 (timeout)
>> Aug 11 10:27:51 black kernel: ata2: soft resetting port
>> Aug 11 10:27:51 black kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl
>> 300)
>> Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
>> Aug 11 10:27:51 black kernel: ata2: EH complete

It looks like there are some lines missing from this log, there should 
be a line before the "res" lines indicating what the failed command was..

My guess, though, is that NCQ is somehow busted on this drive, as is 
known to be the case with a number of other Maxtor disks..


