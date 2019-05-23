From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v4 01/10] ata: libahci: Ensure the host interrupt status
 bits are cleared
Date: Thu, 23 May 2019 10:26:01 +0100
Message-ID: <53ce8c5b-46fc-c969-5168-18e4bcc62cde@arm.com>
References: <20190521143023.31810-1-miquel.raynal@bootlin.com>
 <20190521143023.31810-2-miquel.raynal@bootlin.com>
 <CAHG4imNxsdzjzRpFWnL+PuznjdOU4hsp2E-g1bt4WVJeokfT3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHG4imNxsdzjzRpFWnL+PuznjdOU4hsp2E-g1bt4WVJeokfT3w@mail.gmail.com>
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
To: raymond pang <raymondpangxd@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Baruch Siach <baruch@tkos.co.il>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Gregory Clement <gregory.clement@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-ide@vger.kernel.org

On 23/05/2019 04:11, raymond pang wrote:
> Hi Miquel,
> 
> This patch adds clearing GHC.IS into hot path, could you explain how
> irq storm is generated? thanks
> According to AHCI Spec, HBA should not refer to GHC.IS to generate
> MSI when applying multiple MSIs.

Well spotted.

I have the ugly feeling that this is because the Marvell AHCI
implementation is not using MSIs at all, but instead a pair of wired
interrupts (which are level triggered instead of edge, hence the
screaming interrupts).

The changes in the following patches abuse the rest of the driver by
pretending this is a a multi-MSI setup, while it clearly doesn't match
the expectation of the AHCI spec for MSIs.

It looks like this shouldn't be imposed on other unsuspecting
implementations which correctly use edge-triggered MSIs and do not
require such an MMIO access.

Thanks,

	M.

> 
> Best Regards,
> Raymond
> 
> On Tue, May 21, 2019 at 2:31 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>>
>> ahci_multi_irqs_intr_hard() is going to be used as interrupt handler
>> to support SATA per-port interrupts. The current logic is to check and
>> clear the SATA port interrupt status register only. To avoid spurious
>> IRQs and interrupt storms, it will be needed to clear the port
>> interrupt bit in the host interrupt status register as well.
>>
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> ---
>>  drivers/ata/libahci.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
>> index 692782dddc0f..9db6f488db59 100644
>> --- a/drivers/ata/libahci.c
>> +++ b/drivers/ata/libahci.c
>> @@ -1912,7 +1912,10 @@ static void ahci_port_intr(struct ata_port *ap)
>>  static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
>>  {
>>         struct ata_port *ap = dev_instance;
>> +       struct ata_host *host = ap->host;
>> +       struct ahci_host_priv *hpriv = host->private_data;
>>         void __iomem *port_mmio = ahci_port_base(ap);
>> +       void __iomem *mmio = hpriv->mmio;
>>         u32 status;
>>
>>         VPRINTK("ENTER\n");
>> @@ -1924,6 +1927,8 @@ static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
>>         ahci_handle_port_interrupt(ap, port_mmio, status);
>>         spin_unlock(ap->lock);
>>
>> +       writel(BIT(ap->port_no), mmio + HOST_IRQ_STAT);
>> +
>>         VPRINTK("EXIT\n");
>>
>>         return IRQ_HANDLED;
>> --
>> 2.19.1
>>


-- 
Jazz is not dead. It just smells funny...
