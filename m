From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH 4/5] arm64: dts: marvell: armada-8040-clearfog: Drop
 non-existent SATA port
Date: Wed, 27 Feb 2019 07:16:54 +0200
Message-ID: <87woll6cah.fsf@tarshish>
References: <20190222145356.23072-1-miquel.raynal@bootlin.com>
 <20190222145356.23072-5-miquel.raynal@bootlin.com> <87tvgt7o0q.fsf@tarshish>
 <20190225115826.5bc17f6d@xps13>
 <20190225121519.2quhgqcf24rutqn4@sapphire.tkos.co.il>
 <20190225130502.om6y5q7cbe35fbyw@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20190225130502.om6y5q7cbe35fbyw@shell.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, Jon Nettleton <jon@solid-run.com>, Rabeeh Khoury <rabeeh@solid-run.com>, Nadav Haklai <nadavh@marvell.com>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Antoine Tenart <antoine.tenart@bootlin.com>, Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-ide@vger.kernel.org

Hi Russell,

On Mon, Feb 25 2019, Russell King wrote:
> On Mon, Feb 25, 2019 at 02:15:19PM +0200, Baruch Siach wrote:
>> On Mon, Feb 25, 2019 at 11:58:26AM +0100, Miquel Raynal wrote:
>> > Baruch Siach <baruch@tkos.co.il> wrote on Sun, 24 Feb 2019 07:29:09
>> > +0200:
>> >
>> > > On Fri, Feb 22 2019, Miquel Raynal wrote:
>> > > > There is no CP110 SATA port available on the 8040 Clearfog A8k, SATA
>> > > > may be used thanks to a mPCIe -> SATA extension board only. Hence, the
>> > > > cp1_sata0 node must be removed from the device tree.
>> > >
>> > > Not true. You can use the mini PCIe serdes as SATA directly if you
>> > > configure it as such. You only need to invert the serdes Rx pair
>> > > polarity. This is the default configuration for the Clearfog GT-8K CON3
>> > > mini-PCIe slot (CP1, lane #0) in current mainline U-Boot. I verified
>> > > that this setup works on Clearfog GT-8K.
>> > >
>> > > This patch would break mini PCIe direct SATA.
>> >
>> > Thanks for explaining, I am a little bit surprised that it actually
>> > uses the SATA host IP on CP110 but fine. So can you tell me which SATA
>> > port is used in this case? Because I will have to update the DT
>> > representation along with the CP110 changes.
>>
>> According to the cp110_comphy_phy_mux_data[] array in U-Boot
>> drivers/phy/marvell/comphy_cp110.c, serdes 0 of CP110 can only be SATA1 (i.e.
>> the second port; first is SATA0).
>
> Adding folk from SolidRun...
>
> Why are the mPCIe connectors configured by default for mSATA cards?

This is sort of capability demonstration.

> This sounds like it's going to cause confusion.  The published
> specification for the board at:
>
> https://developer.solid-run.com/products/clearfog-gt-8k/
>
> states that the board has "3 x mPCIe (USB 2.0 + PCIe)" and makes no
> mention of mSATA.
>
> mSATA is not compatible with mPCIe - mSATA cards expect the serdes
> lanes to be connected to a SATA interface, mPCIe cards expect a PCIe
> controller at the other end of the serdes lanes.
>
> Given that there is a lot of confusion about mSATA vs mPCIe out there,
> (caused by both being the same physical form factor and fitting into
> the same socket, yet being electrically different) I think it's
> important to have a coherent story on these connectors everywhere.
>
> Maybe we need a way to have these connectors configurable by the end
> user?

The user can set the PCIe/SATA serdes configuration in U-Boot CP110
comphy nodes.

baruch

--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
