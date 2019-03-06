From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v2 10/10] arm64: dts: marvell: armada-cp110: Switch to
 per-port SATA interrupts
Date: Wed, 6 Mar 2019 12:30:39 +0200
Message-ID: <20190306103039.35cfzanu3mprlcja@sapphire.tkos.co.il>
References: <20190306102146.13005-1-miquel.raynal@bootlin.com>
 <20190306102146.13005-11-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190306102146.13005-11-miquel.raynal@bootlin.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Antoine Tenart <antoine.tenart@bootlin.com>, Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-ide@vger.kernel.org

Hi Miquel,

On Wed, Mar 06, 2019 at 11:21:46AM +0100, Miquel Raynal wrote:
> From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> 
> There are two SATA ports per CP110. Each of them has a dedicated
> interrupt. Describe the real hardware by adding two SATA ports to the
> CP110 SATA node and enabling them in all the DTs including it
> (7040-db/8040-db/8040-clearfog).
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts   |  7 ++++++-
>  .../dts/marvell/armada-8040-clearfog-gt-8k.dts   |  5 ++++-
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts   | 14 ++++++++++++--
>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi    | 16 ++++++++++++++--

What about armada-8040-mcbin.dtsi?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
