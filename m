From: Peter Klotz <peter.klotz@aon.at>
Subject: Re: Problems with Silicon Image Port Multiplier Card
Date: Wed, 04 Nov 2009 06:54:28 +0100
Message-ID: <4AF11714.2080809@aon.at>
References: <4AF0A1FC.4030106@aon.at> <4AF0C6CA.8020205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from WARSL404PIP1.highway.telekom.at ([195.3.96.112]:4596 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750767AbZKDFy0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Nov 2009 00:54:26 -0500
Received: from 212-183-97-89.adsl.highway.telekom.at (HELO [192.168.0.102]) ([212.183.97.89])
          (envelope-sender <peter.klotz@aon.at>)
          by smarthub96.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 4 Nov 2009 05:54:29 -0000
In-Reply-To: <4AF0C6CA.8020205@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org

Robert Hancock wrote:
> On 11/03/2009 03:34 PM, Peter Klotz wrote:
>> Hello
>>
>> My port multiplier capable eSATA Express Card refuses to talk to my
>> external HDD box (2 HDDs, JBOD mode).
>>
>> Inserting the card into the Express Card slot looks normal:
>>
>> [ 622.549794] pciehp 0000:00:1c.2:pcie04: Card present on Slot(0)
>> [ 622.698856] sata_sil24 0000:03:00.0: enabling device (0100 -> 0103)
>> [ 622.698873] sata_sil24 0000:03:00.0: PCI INT A -> GSI 18 (level, low)
>> -> IRQ 18
>> [ 622.702334] scsi8 : sata_sil24
>> [ 622.709268] scsi9 : sata_sil24
>> [ 622.709409] ata7: SATA max UDMA/100 host m128@0xfd804000 port
>> 0xfd800000 irq 18
>> [ 622.709418] ata8: SATA max UDMA/100 host m128@0xfd804000 port
>> 0xfd802000 irq 18
>> [ 624.800150] ata7: SATA link down (SStatus 0 SControl 0)
>> [ 626.890131] ata8: SATA link down (SStatus 0 SControl 0)
>>
>>
>> Turning on the external box results in lots of errors:
>>
>> [ 666.030153] ata8: hard resetting link
>> [ 668.250125] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
>> [ 668.250949] ata8.15: Port Multiplier 1.1, 0x1095:0x5744 r33, 3 ports,
>> feat 0x1/0x9
>> [ 668.251251] ata8.15: applying bridge limits
>> [ 668.251340] ata8.00: hard resetting link
>> [ 668.720140] ata8.00: failed to read SCR 0 (Emask=0x40)
>> [ 668.720156] ata8.15: hard resetting link
>> [ 668.720161] ata8: controller in dubious state, performing PORT_RST
> 
> Which kernel version is this? Can you test latest git?
> 

Sorry, I forgot the kernel version.

It is 2.6.31-14 (Ubuntu 9.10 amd64). I will try the latest vanilla kernel.

The card is able to talk to a single disk enclosure without problems, so 
  I would assume that either Port Multiplying or my external 2-disk box 
is at fault here.

Regards, Peter.
