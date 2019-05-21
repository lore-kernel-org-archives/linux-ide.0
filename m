From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v4 09/10] irqchip/irq-mvebu-icu: Remove the double SATA
 ports interrupt hack
Date: Tue, 21 May 2019 16:51:47 +0100
Message-ID: <31d75a17-858f-e289-5542-be7e6a0a4e5e@arm.com>
References: <20190521143023.31810-1-miquel.raynal@bootlin.com>
 <20190521143023.31810-10-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190521143023.31810-10-miquel.raynal@bootlin.com>
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

On 21/05/2019 15:30, Miquel Raynal wrote:
> When writing the driver, a hack was introduced to configure both SATA
> interrupts regardless of the port in use to overcome a limitation in
> the SATA core. Now that this limitation has been addressed and the
> hack moved in the (historically) responsible SATA driver,
> ahci_{platform,mvebu}.c, let's clean this driver section.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
