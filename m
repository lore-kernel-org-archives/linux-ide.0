From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [v4 03/10] ata: ahci_brcmstb: add quirk for different phy
Date: Tue, 17 Nov 2015 15:06:58 -0500
Message-ID: <20151117200658.GE22864@mtj.duckdns.org>
References: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
 <1446213684-2625-4-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1446213684-2625-4-git-send-email-jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dragan Stancevic <dragan.stancevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-MIPS <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Fri, Oct 30, 2015 at 11:01:17PM +0900, Jaedon Shin wrote:
> Add quirk for phy interface of MIPS-based chipsets. The ARM-based
> chipsets have four phy interface control registers and each port has two
> registers but the MIPS-based chipsets have three. There are no
> information and documentation.
> 
> The Broadcom strict-ahci based BSP of legacy version did not control
> these registers.
...
>  enum brcm_ahci_quirks {
>  	BRCM_AHCI_QUIRK_NONCQ		= BIT(0),
> +	BRCM_AHCI_QUIRK_SKIP_PHY_ENABLE	= BIT(1),
>  };

I see.  There's another quirk flag which actually needs to be
persistent.  Hmm... I don't know.  Ah well, please disregard my
previous comment.

Thanks.

-- 
tejun
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
