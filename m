From: Brett Russ <russb@emc.com>
Subject: Re: [PATCH 2.6.13] libata: use common pci remove in ahci
Date: Tue, 06 Sep 2005 11:09:27 -0400
Message-ID: <431DB127.3010809@emc.com>
References: <20050903071852.95A10271C2@lns1058.lss.emc.com> <431CBDCB.40903@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750713AbVIFPJy@vger.kernel.org>
In-Reply-To: <431CBDCB.40903@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Brett Russ wrote:
>> 2) Isn't it wrong for the IRQ disable at the chip to occur *after*
>> free_irq() is called to disconnect the handler (independent of
>> question 1...since this is the case currently)?  Granted, all of the
>> ports have gone through scsi_remove_host() but theoretically there
>> still is a possibility the chip could interrupt.
>>
>> If I'm wrong on both counts I'll blame it on need for sleep... :-)
> 
> 
> 
> Moving AHCI away from ata_pci_remove_one() was actually intentional. 
> This gives the driver a bit more freedom:  legacy region handling and 
> ->host_stop() became unnecessary.  Also, I was concerned that 
> ata_pci_remove_one() might grow into a one-size-fits-all unmaintainable 
> behemoth.
> 
> Short term, if one were being obsessive, a potential cleanup could be to 
> make common the two loops in ahci_remove_one()/ata_pci_remove_one().
> 
> Long term, libata driver API should become more like the 
> register_foo()/unregister_foo() interfaces you see elsewhere in the 
> kernel.  That direction has the potential to shake up the current code 
> path through ata_pci_remove_one().
> 
> So... your patch, while technically correct, is going in the opposite 
> direction to where I want to go :)


Good to know, thanks for explaining the goals.  How about question #2 above?

Thanks,
BR
