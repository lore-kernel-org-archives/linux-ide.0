From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH #upstream-fixes 1/3] pata_hpt366: fix cable detection,
Date: Tue, 09 Dec 2008 21:56:23 +0300
Message-ID: <493EBF57.7090200@ru.mvista.com>
References: <493E289F.1010000@kernel.org> <493E8B4C.4090604@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5171 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754904AbYLIS41 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Dec 2008 13:56:27 -0500
In-Reply-To: <493E8B4C.4090604@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, rob.opensuse.linux@googlemail.com

Hello, I wrote:

>> pata_hpt366 is strange in that its two channels occupy two PCI
>> functions and both are primary channels and bit1 of PCI configuration
>> register 0x5A indicates cable for both channels.

>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
>> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>    Alas, NAK.

    If you say that it does work, then the datasheet appears to be wrong, so 
have my:

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>> Index: work/drivers/ata/pata_hpt366.c
>> ===================================================================
>> --- work.orig/drivers/ata/pata_hpt366.c
>> +++ work/drivers/ata/pata_hpt366.c
>> @@ -211,11 +211,15 @@ static u32 hpt36x_find_mode(struct ata_p
>>  
>>  static int hpt36x_cable_detect(struct ata_port *ap)
>>  {
>> -    u8 ata66;
>>      struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>> +    u8 ata66;
>>  
>> +    /*
>> +     * Each channel of pata_hpt366 occupies separate PCI function
>> +     * as the primary channel and bit1 indicates the cable type.
>> +     */

>    No, it doesn't for the secondary channel (which is fucntion 1).

>>      pci_read_config_byte(pdev, 0x5A, &ata66);
>> -    if (ata66 & (1 << ap->port_no))
>> +    if (ata66 & 2)

>    You need to use (pdev->devfn & 1) as a right shift count instead. Not 
> very sophisticated indeed. :-)

    Well, then I won't have to fix hpt366.c if that's not needed. :-)

MBR, Sergei
