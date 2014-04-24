From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH 1/6] ata: ahci: add AHCI support for Berlin SoCs
Date: Thu, 24 Apr 2014 17:50:41 +0800
Message-ID: <20140424175041.0bade2d6@xhacker>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
	<1398181105-19714-2-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398181105-19714-2-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Antoine =?UTF-8?B?VMOpbmFydA==?= <antoine.tenart@free-electrons.com>
Cc: "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>, "tj@kernel.org" <tj@kernel.org>, "alexandre.belloni@free-electrons.com" <alexandre.belloni@free-electrons.com>, Jimmy Xu <zmxu@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hi Antoine,

On Tue, 22 Apr 2014 08:38:20 -0700
Antoine T=C3=A9nart <antoine.tenart@free-electrons.com> wrote:

> +		/* CT timing fix */
> +		ahci_berlin_reg_set(ctrl_reg + PORT_VSR_ADDR, BIT(6) |
> BIT(1));
> +		ahci_berlin_reg_set(ctrl_reg + PORT_VSR_ADDR,
> +				    BIT(15) | BIT(13) | BIT(12) | BIT(11) |
> +				    BIT(10) | BIT(2) | BIT(1));

Could you please remove these code? They are not used for BG2Q, I'm sor=
ry there's
such mistake in the code I provided to you ;)

Thanks
