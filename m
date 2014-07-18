From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v10 3/8] ata: libahci_platform: move port_map parameters
 into the AHCI structure
Date: Fri, 18 Jul 2014 09:47:30 -0400
Message-ID: <20140718134730.GA13012@htj.dyndns.org>
References: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com>
 <1405686607-8126-4-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1405686607-8126-4-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>
Cc: sebastian.hesselbarth@gmail.com, kishon@ti.com, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, Jul 18, 2014 at 02:30:02PM +0200, Antoine T=E9nart wrote:
> @@ -321,6 +321,8 @@ struct ahci_host_priv {
>  	u32			cap;		/* cap to use */
>  	u32			cap2;		/* cap2 to use */
>  	u32			port_map;	/* port map to use */
> +	u32			force_port_map;	/* force port map */
> +	u32			mask_port_map;	/* mask out particular bits */

So, ->flags and ->force/mask_port_map are the only input ones, right?
Can we collect them to one spot and label them as such?

Thanks.

--=20
tejun
