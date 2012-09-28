From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: Re: [PATCH -next] ata: fix sata_highbank.c build errors
Date: Fri, 28 Sep 2012 12:56:53 -0500
Message-ID: <5065E4E5.30004@calxeda.com>
References: <20120919162643.907ddda75e198f060e4e83fe@canb.auug.org.au> <505A0BCF.5040905@xenotime.net> <5065DABA.7060404@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <5065DABA.7060404@xenotime.net>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, LKML <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-ide@vger.kernel.org

On 09/28/2012 12:13 PM, Randy Dunlap wrote:
> On 09/19/2012 11:15 AM, Randy Dunlap wrote:
> 
>> From: Randy Dunlap <rdunlap@xenotime.net>
>>
> 
> 
> ping.
> This build error is still present in linux-next of 20120928.
> 
>> Fix build errors in sata_highbank.c by also building libahci.o.
>> Fixes these build errors:
>>
>> drivers/built-in.o: In function `ahci_highbank_hardreset':
>> sata_highbank.c:(.text+0x1edc9a): undefined reference to `ahci_stop_engine'
>> sata_highbank.c:(.text+0x1edfab): undefined reference to `ahci_start_engine'
>> sata_highbank.c:(.text+0x1edfd5): undefined reference to `ahci_dev_classify'
>> drivers/built-in.o: In function `ahci_highbank_resume':
>> sata_highbank.c:(.text+0x1ee0af): undefined reference to `ahci_reset_controller'
>> sata_highbank.c:(.text+0x1ee0e1): undefined reference to `ahci_init_controller'
>> drivers/built-in.o: In function `ahci_highbank_probe':
>> sata_highbank.c:(.init.text+0xc577): undefined reference to `ahci_save_initial_config'
>> sata_highbank.c:(.init.text+0xc5ca): undefined reference to `ahci_set_em_messages'
>> sata_highbank.c:(.init.text+0xc630): undefined reference to `ahci_ignore_sss'
>> sata_highbank.c:(.init.text+0xc660): undefined reference to `ahci_reset_em'
>> sata_highbank.c:(.init.text+0xc72f): undefined reference to `ahci_reset_controller'
>> sata_highbank.c:(.init.text+0xc75a): undefined reference to `ahci_init_controller'
>> sata_highbank.c:(.init.text+0xc774): undefined reference to `ahci_print_info'
>> sata_highbank.c:(.init.text+0xc77c): undefined reference to `ahci_interrupt'
>> drivers/built-in.o:(.data+0x1d5ec): undefined reference to `ahci_ops'
>> drivers/built-in.o:(.data+0x1d690): undefined reference to `ahci_shost_attrs'
>> drivers/built-in.o:(.data+0x1d694): undefined reference to `ahci_sdev_attrs'
>>
>> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
>> Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
>> ---
>>  drivers/ata/Makefile |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- linux-next-20120919.orig/drivers/ata/Makefile
>> +++ linux-next-20120919/drivers/ata/Makefile
>> @@ -9,7 +9,7 @@ obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
>>  obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
>>  obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
>>  obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
>> -obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o
>> +obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o libahci.o
>>  
>>  # SFF w/ custom DMA
>>  obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o

Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
