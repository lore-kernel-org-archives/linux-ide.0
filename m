From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH 4/5] arm64: dts: marvell: armada-8040-clearfog: Drop
 non-existent SATA port
Date: Mon, 25 Feb 2019 14:15:19 +0200
Message-ID: <20190225121519.2quhgqcf24rutqn4@sapphire.tkos.co.il>
References: <20190222145356.23072-1-miquel.raynal@bootlin.com>
 <20190222145356.23072-5-miquel.raynal@bootlin.com>
 <87tvgt7o0q.fsf@tarshish> <20190225115826.5bc17f6d@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190225115826.5bc17f6d@xps13>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Antoine Tenart <antoine.tenart@bootlin.com>, Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-ide@vger.kernel.org

Hi Miquel,

On Mon, Feb 25, 2019 at 11:58:26AM +0100, Miquel Raynal wrote:
> Baruch Siach <baruch@tkos.co.il> wrote on Sun, 24 Feb 2019 07:29:09
> +0200:
> 
> > On Fri, Feb 22 2019, Miquel Raynal wrote:
> > > There is no CP110 SATA port available on the 8040 Clearfog A8k, SATA
> > > may be used thanks to a mPCIe -> SATA extension board only. Hence, the
> > > cp1_sata0 node must be removed from the device tree.  
> > 
> > Not true. You can use the mini PCIe serdes as SATA directly if you
> > configure it as such. You only need to invert the serdes Rx pair
> > polarity. This is the default configuration for the Clearfog GT-8K CON3
> > mini-PCIe slot (CP1, lane #0) in current mainline U-Boot. I verified
> > that this setup works on Clearfog GT-8K.
> > 
> > This patch would break mini PCIe direct SATA.
> 
> Thanks for explaining, I am a little bit surprised that it actually
> uses the SATA host IP on CP110 but fine. So can you tell me which SATA
> port is used in this case? Because I will have to update the DT
> representation along with the CP110 changes.

According to the cp110_comphy_phy_mux_data[] array in U-Boot 
drivers/phy/marvell/comphy_cp110.c, serdes 0 of CP110 can only be SATA1 (i.e. 
the second port; first is SATA0).

Please Cc me on your next submission.

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
