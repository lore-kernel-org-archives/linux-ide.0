From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v4 01/10] ata: libahci: Ensure the host interrupt status
 bits are cleared
Date: Wed, 29 May 2019 14:33:39 +0100
Message-ID: <f619298a-cb51-b86e-9542-55b9e45bf803@arm.com>
References: <20190521143023.31810-1-miquel.raynal@bootlin.com>
 <20190521143023.31810-2-miquel.raynal@bootlin.com>
 <CAHG4imNxsdzjzRpFWnL+PuznjdOU4hsp2E-g1bt4WVJeokfT3w@mail.gmail.com>
 <53ce8c5b-46fc-c969-5168-18e4bcc62cde@arm.com>
 <20190529120833.29334c70@xps13>
 <409ea2c5-c31a-fb6a-22c6-98b45e767809@arm.com>
 <20190529141356.1d9f03f3@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190529141356.1d9f03f3@xps13>
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
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, raymond pang <raymondpangxd@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Gregory Clement <gregory.clement@bootlin.com>, Baruch Siach <baruch@tkos.co.il>, Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-ide@vger.kernel.org

On 29/05/2019 13:13, Miquel Raynal wrote:
> Hi Marc,
> 
> Marc Zyngier <marc.zyngier@arm.com> wrote on Wed, 29 May 2019 11:37:58
> +0100:
> 
>> On 29/05/2019 11:08, Miquel Raynal wrote:
>>> Hi Marc & Raymond,
>>>
>>> Marc Zyngier <marc.zyngier@arm.com> wrote on Thu, 23 May 2019 10:26:01
>>> +0100:
>>>   
>>>> On 23/05/2019 04:11, raymond pang wrote:  
>>>>> Hi Miquel,
>>>>>
>>>>> This patch adds clearing GHC.IS into hot path, could you explain how
>>>>> irq storm is generated? thanks
>>>>> According to AHCI Spec, HBA should not refer to GHC.IS to generate
>>>>> MSI when applying multiple MSIs.    
>>>>
>>>> Well spotted.
>>>>
>>>> I have the ugly feeling that this is because the Marvell AHCI
>>>> implementation is not using MSIs at all, but instead a pair of wired
>>>> interrupts (which are level triggered instead of edge, hence the
>>>> screaming interrupts).
>>>>
>>>> The changes in the following patches abuse the rest of the driver by
>>>> pretending this is a a multi-MSI setup, while it clearly doesn't match
>>>> the expectation of the AHCI spec for MSIs.
>>>>
>>>> It looks like this shouldn't be imposed on other unsuspecting
>>>> implementations which correctly use edge-triggered MSIs and do not
>>>> require such an MMIO access.  
>>>
>>> I understand your concern, let me add a AHCI_HFLAG_LEVEL_MSI in
>>> hpriv->flags which will be used by the mvebu_ahci.c driver to request
>>> for this MMIO access. This way, the hot path remains the same.  
>>
>> I'm not convinced that's a good idea, if only because from the PoV of
>> the AHCI device itself, these are not MSIs at all, but wired interrupts.
>> The fact that there is some glue logic in the middle that turns it into
>> a message (and then back into a wire) is a regrettable implementation
>> detail.
>>
>> I'd rather you stick to the normal interrupt handler, or provide your
>> own, which would solve most problems.
> 
> Unless I don't understand your proposal, "stick to the normal interrupt
> handler" is not possible as I need this register write to happen at
> this time, not at any other moment.
> 
> However, on the possibility of having a separate interrupt handler, I
> may use the new AHCI_HFALG_LEVEL_MSI flag to change the
> devm_request_irq call here [1] and use my own at this moment. The
> handler will be in libahci.c though.
> 
> Would this be a better approach?

Again, level-triggered MSIs are not a property of the AHCI block. If
anything, that's a property of the ICU block. Please do not conflate the
two.

What you have here is a set of wired interrupts, one per port. I'd
suggest you implement it a separate interrupt handler keyed on a
particular flag if you cannot detect this case by other means.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
