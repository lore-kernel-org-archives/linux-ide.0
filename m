From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: Add pata_atp867x driver for Artop/Acard ATP867X
 	controllers
Date: Sat, 12 Sep 2009 23:12:46 -0400
Message-ID: <4AAC632E.3090902@pobox.com>
References: <8b5805ff0909111906j68c20c3yf7226f2798a67d80@mail.gmail.com> 	<1252721641.28368.34.camel@desktop> <8b5805ff0909120359g2faf661br463b19518d935110@mail.gmail.com> 	<4AABD122.2000400@gmail.com> <8b5805ff0909121717w1516c273k2a568779b9c31662@mail.gmail.com> 	<8b5805ff0909121726g2f1a78c1o1ff7289e059eabe5@mail.gmail.com> 	<4AAC4315.6010102@pobox.com> <8b5805ff0909121941y38b7764fv3cc4d0b5c1ba6c89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54822 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754846AbZIMDMv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Sep 2009 23:12:51 -0400
In-Reply-To: <8b5805ff0909121941y38b7764fv3cc4d0b5c1ba6c89@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Jung-Ik (John) Lee" <jilee@google.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Daniel Walker <dwalker@fifo99.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Grundler <grundler@google.com>, Gwendal Grignou <gwendal@google.com>, Eric Uhrhane <ericu@google.com>

On 09/12/2009 10:41 PM, Jung-Ik (John) Lee wrote:
> On Sat, Sep 12, 2009 at 5:55 PM, Jeff Garzik<jgarzik@pobox.com>  wrote:
>>
>>
>> General comment:
>>
>> * since you use iomap to map the region, you should use ioread{8,16,32} /
>> iowrite{8,16,32} accessors.  Do not use inb/outb/inl/outl/etc.
> .
> I used them for runtime hot registers by separately mapping them
> simply to avoid an extra overhead of ioread/iowrite, over the
> portability.
> I know it's not a good idea but in this case for these hot ports can
> in/out be used?

It is _highly_ unlikely that the overhead is even measureable above the 
noise, I would think.  Do you have data showing that ioread/iowrite 
impose a noticeable penalty?


>
>
>>
>> * run through scripts/checkpatch.pl
>>
>
> Weird. I don't see any WS issues you pointed below in my source code
> or git diff file, except UT = T/4 below.

My apologies; most of those appear to be problems with Thunderbird.  I 
think it renders <tab> incorrectly.


>>> +static void atp867x_set_dmamode(struct ata_port *ap, struct ata_device
>>> *adev)
>>> +{
>>> +       struct pci_dev *pdev    = to_pci_dev(ap->host->dev);
>>> +       struct atp867x_priv *dp = ap->private_data;
>>> +       u8 speed = adev->dma_mode;
>>> +       u8 b;
>>> +       u8 mode;
>>> +
>>> +
>>> +       switch (speed) {
>>> +       case XFER_UDMA_6:
>>> +               mode = ATP867X_IO_DMAMODE_UDMA_6;
>>> +               break;
>>> +       case XFER_UDMA_5:
>>> +               mode = ATP867X_IO_DMAMODE_UDMA_5;
>>> +               break;
>>> +       case XFER_UDMA_4:
>>> +               mode = ATP867X_IO_DMAMODE_UDMA_4;
>>> +               break;
>>> +       case XFER_UDMA_3:
>>> +               mode = ATP867X_IO_DMAMODE_UDMA_3;
>>> +               break;
>>> +       case XFER_UDMA_2:
>>> +               mode = ATP867X_IO_DMAMODE_UDMA_2;
>>> +               break;
>>> +       case XFER_UDMA_1:
>>> +               mode = ATP867X_IO_DMAMODE_UDMA_1;
>>> +               break;
>>> +       case XFER_UDMA_0:
>>> +               mode = ATP867X_IO_DMAMODE_UDMA_0;
>>> +               break;
>>> +       default:
>>> +               printk(KERN_WARNING "ATP867X: Unsupported speed %#x."
>>> +                       " Default to XFER_UDMA_0.\n", (unsigned)speed);
>>> +               mode = ATP867X_IO_DMAMODE_UDMA_0;
>>
>> a table would be nice, preferred over a switch statement.  You may use
>> ARRAY_SIZE() macro to generate a constant at compile time for number of
>> elements in array.
>
> OK. I had it in a pure math like mode = speed - XFER_UDMA_0 +1;

That's fine too.




>>> +       /*
>>> +        * Broken BIOS might not set latency high enough
>>> +        */
>>> +       pci_read_config_byte(pdev, PCI_LATENCY_TIMER,&v);
>>> +       if (v<    0x80) {
>>> +               v = 0x80;
>>> +               pci_write_config_byte(pdev, PCI_LATENCY_TIMER, v);
>>> +               printk(KERN_DEBUG "ATP867X: set latency timer of device
>>> %s"
>>> +                       " to %d\n", pci_name(pdev), v);
>>> +       }
>>
>> this seems pointless - pci_set_master() already does this
>>
> pci_set_master won't re-set it if BIOS set it to somewhere between 16
> and 256. This controller wants 0x80.
> so, if BIOS set to less than 0x80, like 0x20, pci_set_master will keep
> the value.
> I could do this via pci fixup or quirks but that seems too much for
> this simple setting.

Given your explanation, that's fine.

	Jeff



