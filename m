From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 3/6] ARM: berlin: add the AHCI node for the BG2Q
Date: Tue, 22 Apr 2014 18:28:44 +0200
Message-ID: <20140422182844.3f2eb558@skate>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
	<1398181105-19714-4-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398181105-19714-4-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Antoine =?UTF-8?B?VMOpbmFydA==?= <antoine.tenart@free-electrons.com>
Cc: sebastian.hesselbarth@gmail.com, tj@kernel.org, zmxu@marvell.com, jszhang@marvell.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Dear Antoine T=C3=A9nart,

On Tue, 22 Apr 2014 17:38:22 +0200, Antoine T=C3=A9nart wrote:

> +		ahci: sata@e90000 {
> +			compatible =3D "marvell,berlin-ahci";
> +			reg =3D <0xe90000 0x10000>;
> +			interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +			status =3D "disable";

Should be:

			status =3D "disabled";

And ditto for patches 5 and 6.

Thanks,

Thomas
--=20
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
