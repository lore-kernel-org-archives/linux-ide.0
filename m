From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] IDE: claim extra DMA ports regardless of channel
Date: Wed, 29 Mar 2006 00:42:21 +0400
Message-ID: <44299FAD.7080006@ru.mvista.com>
References: <44298947.5090600@ru.mvista.com> <20060328124146.52dbe446.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:36773 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932163AbWC1UoM
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Mar 2006 15:44:12 -0500
In-Reply-To: <20060328124146.52dbe446.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Hello.

Andrew Morton wrote:

>> static int ide_iomio_dma(ide_hwif_t *hwif, unsigned long base, unsigned int ports)
>>  {
>>  	printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx",
>> -		hwif->name, base, base + ports - 1);
>> +	       hwif->name, base, base + ports - 1);
>> +
>>  	if (!request_region(base, ports, hwif->name)) {
>>  		printk(" -- Error, ports in use.\n");
>>  		return 1;
>>  	}
>> +
>>  	hwif->dma_base = base;
>> -	if ((hwif->cds->extra) && (hwif->channel == 0)) {
>> -		request_region(base+16, hwif->cds->extra, hwif->cds->name);
>> -		hwif->dma_extra = hwif->cds->extra;
>> -	}
>> -	
>> +
>> +	if (hwif->cds->extra) {
>> +		hwif->extra_base = base + (hwif->channel ? 8 : 16);
>> +
>> +		if (!hwif->mate || !hwif->mate->extra_ports) {
>> +			if (!request_region(hwif->extra_base,
>> +					    hwif->cds->extra, hwif->cds->name)) {
>> +				printk(" -- Error, extra ports in use.\n");
>> +				release_region(base, ports);
>> +				return 1;
>> +			}
>> +			hwif->extra_ports = hwif->cds->extra;
>> +		}
>> +	}
> 
> 
> The printks in this function are odd.  Note how it will print a
> non-newline-terminated string and then will print a newline-terminated
> string only if there was an error.
> 
> Does it all come out right both when errors occur and when they do not?

     Sure it does. :-)

WBR, Sergei

