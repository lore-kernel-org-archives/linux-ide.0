From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 08/10] ata: ahci: mvebu: Add support for A8k legacy
 bindings
Date: Thu, 7 Mar 2019 16:31:48 +0000
Message-ID: <634bb5cc-aab9-eecb-cba9-8c7762e888c9@arm.com>
References: <20190306102146.13005-1-miquel.raynal@bootlin.com>
 <20190306102146.13005-9-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190306102146.13005-9-miquel.raynal@bootlin.com>
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
To: Miquel Raynal <miquel.raynal@bootlin.com>, Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: devicetree@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, Antoine Tenart <antoine.tenart@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On 06/03/2019 10:21, Miquel Raynal wrote:
> The CP110 SATA unit has 2 ports, and a dedicated ICU entry per
> port. In the past, the AHCI SATA driver only supported one interrupt
> per SATA unit. To solve this conflict, the 2 SATA wired interrupts in
> the South-Bridge got configured as 1 GIC interrupt in the
> North-Bridge, regardless of the number of SATA ports actually
> enabled/in use, and the bindings only referenced the interrupt of one
> port.
> 
> Since then, this limitation has been addressed and this patch ensures
> backward compatibility with old DTs not describing SATA ports
> correctly directly from the AHCI MVEBU driver. This way, we will be
> able to drop the hack from the ICU driver. IOW, when the A8k
> compatible string is used and there is no sub-nodes in the DT, we
> fake the creation and mapping of the second (missing) interrupt.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

It'd be good to add that all these hacks only exist for the purpose of
DT. The same HW booting with ACPI doesn't require any of this because
the firmware abstracts stuff that the kernel shouldn't be concerned with
the first place.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
