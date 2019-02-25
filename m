From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/5] ata: libahci_platform: Support per-port interrupts
Date: Mon, 25 Feb 2019 11:08:32 -0700
Message-ID: <cd592577-c807-7e8f-1b08-7b28947c62c3@kernel.dk>
References: <20190222145356.23072-1-miquel.raynal@bootlin.com>
 <20190222145356.23072-3-miquel.raynal@bootlin.com>
 <5040d4cf-7da1-eefa-a8a3-bc4054d528da@redhat.com>
 <20190222163114.0f4488fe@xps13>
 <c847985c-7117-6b31-ae78-4467871714c8@redhat.com>
 <20190222170348.12e45f42@xps13>
 <09a58952-ca34-cbfb-d0a9-d6c9f8afcb8b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <09a58952-ca34-cbfb-d0a9-d6c9f8afcb8b@redhat.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hans de Goede <hdegoede@redhat.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Antoine Tenart <antoine.tenart@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-ide@vger.kernel.org

On 2/22/19 9:10 AM, Hans de Goede wrote:
> Hi,
> 
> On 2/22/19 5:03 PM, Miquel Raynal wrote:
>> Hi Hans,
>>
>> Hans de Goede <hdegoede@redhat.com> wrote on Fri, 22 Feb 2019 16:52:55
>> +0100:
>>
>>> Hi,
>>>
>>> On 2/22/19 4:31 PM, Miquel Raynal wrote:
>>>> Hi Hans,
>>>>
>>>> Hans de Goede <hdegoede@redhat.com> wrote on Fri, 22 Feb 2019 16:26:01
>>>> +0100:
>>>>    
>>>>> Hi,
>>>>>
>>>>> On 2/22/19 3:53 PM, Miquel Raynal wrote:
>>>>>> Right now the ATA core only allows IPs to use a single interrupt. Some
>>>>>> of them (for instance the Armada-CP110 one) actually has one interrupt
>>>>>> per port. Add some logic to support such situation.
>>>>>>
>>>>>> We consider that either there is one single interrupt declared in the
>>>>>> main IP node, or there are per-port interrupts, each of them being
>>>>>> declared in the port sub-nodes.
>>>>>>
>>>>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>>>>> ---
>>>>>>     drivers/ata/acard-ahci.c       |  2 +-
>>>>>>     drivers/ata/ahci.c             |  2 +-
>>>>>>     drivers/ata/ahci.h             |  3 +-
>>>>>>     drivers/ata/libahci.c          |  2 +-
>>>>>>     drivers/ata/libahci_platform.c | 66 ++++++++++++++++++++++++++++------
>>>>>>     drivers/ata/sata_highbank.c    |  2 +-
>>>>>>     6 files changed, 61 insertions(+), 16 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
>>>>>> index 583e366be7e2..9414b81e994c 100644
>>>>>> --- a/drivers/ata/acard-ahci.c
>>>>>> +++ b/drivers/ata/acard-ahci.c
>>>>>> @@ -434,7 +434,7 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
>>>>>>     	if (!hpriv)
>>>>>>     		return -ENOMEM;
>>>>>>     > -	hpriv->irq = pdev->irq;
>>>>>> +	hpriv->irqs[0] = pdev->irq;
>>>>>>     	hpriv->flags |= (unsigned long)pi.private_data;
>>>>>>       >> What code-path is going to alloc hpriv->irqs for drivers using this code-path
>>>>> which are not using libahci_platform .c ?
>>>>
>>>> I don't understand the question (or the remark behind the question),
>>>> can you explain a little bit more what you have in mind?
>>>
>>> Sorry I got the code context wrong I meant to put that comment below this chunk:
>>>
>>>   > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>>   > index 021ce46e2e57..18bce556d85f 100644
>>>   > --- a/drivers/ata/ahci.c
>>>   > +++ b/drivers/ata/ahci.c
>>>   > @@ -1817,7 +1817,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>>   >   		/* legacy intx interrupts */
>>>   >   		pci_intx(pdev, 1);
>>>   >   	}
>>>   > -	hpriv->irq = pci_irq_vector(pdev, 0);
>>>   > +	hpriv->irqs[0] = pci_irq_vector(pdev, 0);
>>>   >
>>>   >   	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
>>>   >   		host->flags |= ATA_HOST_PARALLEL_SCAN;
>>>
>>>
>>> Which AFAIK is a common code-path also used by ahci drivers not using
>>> libahci_platform, and in that case hpriv->irqs will be NULL as nothing
>>> initializes it.
>>
>> Oh I see. What do you prefer:
>> 1/
>> * I add "irqs" besides "irq" in the structure
>> * copy the value of irq in irqs[0]
>> * use irqs instead of irq in the libahci_platform ?
>> or
>> 2/
>> * Allocated one irq there if there is none ?
> 
> I don't really have a preference, Jens what is your take on this?

Single array would be the cleanest, don't add an irqs[] beside the
irq.

-- 
Jens Axboe
