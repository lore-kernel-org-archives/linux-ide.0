From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] pata_cmd640: don't read CFR pointlessly
Date: Sun, 09 May 2010 01:38:47 +0400
Message-ID: <4BE5D9E7.7080003@mvista.com>
References: <201005082227.19096.sshtylyov@ru.mvista.com> <4BE5D73C.30707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:36321 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131Ab0EHVje (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 May 2010 17:39:34 -0400
Received: by ewy20 with SMTP id 20so578039ewy.1
        for <linux-ide@vger.kernel.org>; Sat, 08 May 2010 14:39:32 -0700 (PDT)
In-Reply-To: <4BE5D73C.30707@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Hello.

Jeff Garzik wrote:

>> cmd640_hardware_init() reads CFR but doesn't use the value read...
>>
>> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>>
>> ---
>> The patch is against the recent Linus' tree.
>>
>>   drivers/ata/pata_cmd640.c |    3 ---
>>   1 file changed, 3 deletions(-)
>>
>> Index: linux-2.6/drivers/ata/pata_cmd640.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/ata/pata_cmd640.c
>> +++ linux-2.6/drivers/ata/pata_cmd640.c
>> @@ -181,13 +181,10 @@ static struct ata_port_operations cmd640
>>
>>   static void cmd640_hardware_init(struct pci_dev *pdev)
>>   {
>> -    u8 r;
>>       u8 ctrl;
>>
>>       /* CMD640 detected, commiserations */
>>       pci_write_config_byte(pdev, 0x5B, 0x00);
>> -    /* Get version info */
>> -    pci_read_config_byte(pdev, CFR,&r);
>>       /* PIO0 command cycles */
>
> Agreed with this patch, but we lose some information:  all that 
> remains is an uncommented 'CFR' definition.  Without the code comment, 
> which is deleted in this patch, we have no idea what that register does.

   It does several different things.

> Given that the chipset docs are not public AFAIK,

   They were public once. And I think I've given you that spec along 
with other PCI-64x specs for publishing on 
gkernel.sourceforge.net/specs/ already (can't open 
sii/cmd64x-specs.tar.bz2 now to check).

> this is a net loss of information about this chipset, IMO.
>
> Maybe revise this patch, or add a second patch, which adds a comment 
> where 'CFR' is defined?  Something as simple as "/* version info */" 
> would be sufficient.

   That wouldn't be a good description. The "official" name of the 
register is configuration register.

>     Jeff

WBR, Sergei

