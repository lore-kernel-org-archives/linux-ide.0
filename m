From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH option B 2/2] PCI: do not create quirk I/O regions below
 PCIBIOS_MIN_IO for ICH
Date: Fri, 11 Feb 2011 15:16:35 +0100
Message-ID: <4D5544C3.8040306@suse.cz>
References: <4D3025F4.6020001@gmail.com> <1295001146-14910-2-git-send-email-jslaby@suse.cz> <4D552704.1000509@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4D552704.1000509@ru.mvista.com>
Sender: linux-pci-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Bjorn Helgaas <bjorn.helgaas@hp.com>, "David S. Miller" <davem@davemloft.net>, Thomas Renninger <trenn@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

On 02/11/2011 01:09 PM, Sergei Shtylyov wrote:
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 8db2426..b3ab2f7 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -554,18 +554,30 @@ static void __devinit quirk_ich4_lpc_acpi(struct
>> pci_dev *dev)
>>       u32 region;
>>       u8 enable;
>>
>> +    /*
>> +     * The check for PCIBIOS_MIN_IO is to ensure we won't create a
>> conflict
>> +     * with low legacy (and fixed) ports. We don't know the decoding
>> +     * priority and can't tell whether the legacy device or the one
>> created
>> +     * here is really at that address.  This happens on boards with
>> broken
>> +     * BIOSes.
>> +    */
>> +
>>       pci_read_config_byte(dev, ICH_ACPI_CNTL,&enable);
>>       if (enable&  ICH4_ACPI_EN) {
>>           pci_read_config_dword(dev, ICH_PMBASE,&region);
>> -        quirk_io_region(dev, region, 128, PCI_BRIDGE_RESOURCES,
>> -                "ICH4 ACPI/GPIO/TCO");
>> +        region &= PCI_BASE_ADDRESS_IO_MASK;
> 
>    Why don't you do the masking right in the patch #1? And is it really
> necessary if the region size is known to be 128 bytes?

The region here contains also the low flag bits. Yes, it can be a part
of 1/1. But I don't think it matters.

regards,
-- 
js
suse labs
