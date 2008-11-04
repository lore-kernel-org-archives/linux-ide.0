From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/6] rz1000: apply chipset quirks early
Date: Tue, 04 Nov 2008 21:56:09 +0300
Message-ID: <49109AC9.5090406@ru.mvista.com>
References: <20081103200244.5098.29817.sendpatchset@localhost.localdomain> <20081103200306.5098.41565.sendpatchset@localhost.localdomain> <491083E9.60305@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:48239 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754730AbYKDS4Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Nov 2008 13:56:16 -0500
In-Reply-To: <491083E9.60305@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, I wrote:

>> Index: b/drivers/ide/rz1000.c
>> ===================================================================
>> --- a/drivers/ide/rz1000.c
>> +++ b/drivers/ide/rz1000.c
>> @@ -22,34 +22,48 @@
>>  
>>  #define DRV_NAME "rz1000"
>>  
>> -static void __devinit init_hwif_rz1000 (ide_hwif_t *hwif)
>> +static unsigned int __devinit rz1000_init_chipset(struct pci_dev *dev)

>    Hm, this is not a real init_chipset() method and it does just one 
> thing -- disables readahead, so rz1000_disable_readahead() or something 
> of that sort seems like a better name...

    Hm, 'unsigned' result type wasn't terribly helpful here as well. :-)

MBR, Sergei
