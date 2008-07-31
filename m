From: Mark Lord <mlord@pobox.com>
Subject: Re: multiple sata_mv boards with same DevID ?
Date: Thu, 31 Jul 2008 11:12:19 -0400
Message-ID: <4891D653.3020803@pobox.com>
References: <20080728231012.BEBEE437FB@mail.pozicom.net>
 <488E7716.90703@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49125 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbYGaPM0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Jul 2008 11:12:26 -0400
In-Reply-To: <488E7716.90703@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: eric@pozicom.net
Cc: linux-ide@vger.kernel.org

Hello?

Still waiting to hear back from you on this (see below).

Thanks
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

Mark Lord wrote:
> eric wrote:
>> To whom it may concern:
>>
>> We have the HighPoint 1740 SATAII RAID card.  I had to modify the 
>> sata_mv.c
>> (attached) to get it to work with my card.  The interesting bits are as
>> follows:
>>
>> /* RocketRAID 1740/174x have different identifiers */
>>
>> /* { PCI_VDEVICE(TTI, 0x1740), chip_508x }, */
>>
>> /* Pozicom: GenII 1740 cards use 88sx6042 chip */
>>
>> { PCI_VDEVICE(TTI, 0x1740), chip_6042 },
>>
>> { PCI_VDEVICE(TTI, 0x1742), chip_508x },
>>
>>  
>> It appears the same card has different chip set depending upon when you
>> purchased your card.  Looking through the code, the GenI vs. GenII vs.
>> GenIIe is done after the call to mv_pci_init_one thus passing a table of
>> values that are incorrect.  It would appear to make sense to solve 
>> this by
>> creating two or more tables and make mv_pci_tbl a pci_device_id global 
>> * and
>> reference it accordingly after the Rev. level was determined.
> ..
> 
> Hi,
> 
> We (I) really need to see the output of "lspci -xxx" from that system.
> 
> Thanks.
