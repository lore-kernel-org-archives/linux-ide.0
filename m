From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pci: use pci_ioremap_bar() in drivers/ide
Date: Thu, 23 Oct 2008 00:42:09 +0400
Message-ID: <48FF9021.6010205@ru.mvista.com>
References: <20081020214830.1586704c@infradead.org>	<48FDA8BF.20206@ru.mvista.com>	<48FF6595.5040203@ru.mvista.com> <20081022132346.38fbc84a@infradead.org> <48FF8F3B.1090302@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:50281 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752109AbYJVUmb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Oct 2008 16:42:31 -0400
In-Reply-To: <48FF8F3B.1090302@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

I just wrote:

>> diff --git a/drivers/ide/pci/scc_pata.c b/drivers/ide/pci/scc_pata.c
>> index 9ce1d80..b4be295 100644
>> --- a/drivers/ide/pci/scc_pata.c
>> +++ b/drivers/ide/pci/scc_pata.c

> [...]

>> @@ -557,10 +553,12 @@ static int setup_mmio_scc (struct pci_dev *dev, 
>> const char *name)
>>          return ret;
>>      }
>>  
>> -    if ((ctl_addr = ioremap(ctl_base, ctl_size)) == NULL)
>> +    ctl_addr = pci_ioremap_bar(dev, 0);
>> +    if (!ctl_addr)
>>          goto fail_0;
>>  
>> -    if ((dma_addr = ioremap(dma_base, dma_size)) == NULL)
>> +    dma_addr = pci_ioremap_bar(dev, 1);
>> +    if (!dma_addr)
>>          goto fail_1;
>>  
>>      pci_set_master(dev);

>    An added bonus here is fixing couple checkpatch.pl's warnings.

    Wait, those even were errors, so even better. :-)

MBR, Sergei
