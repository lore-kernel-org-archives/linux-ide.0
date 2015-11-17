From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [v4 00/10] add support SATA for BMIPS_GENERIC
Date: Mon, 16 Nov 2015 18:22:40 -0800
Message-ID: <20151117022240.GX8456@google.com>
References: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1446213684-2625-1-git-send-email-jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dragan Stancevic <dragan.stancevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-MIPS <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Fri, Oct 30, 2015 at 11:01:14PM +0900, Jaedon Shin wrote:
> Hi all,
> 
> This patch series add support SATA for BMIPS_GENERIC.
> 
> Changes in v4:
> - remove unused properties from bcm{7425,7342,7362}.dtsi
> 
> Changes in v3:
> - fix typo quirk instead of quick
> - disable NCQ before initialzing SATA controller endianness
> - fix misnomer controlling phy interface
> - remove brcm,broken-ncq and brcm,broken-phy properties from devicetree
> - use compatible string for quirks
> - use list for compatible strings
> - add "Acked-by:" tags
> 
> Changes in v2:
> - adds quirk for ncq
> - adds quirk for phy interface control
> - remove unused definitions in ahci_brcmstb
> - combines compatible string

For the drivers portions (including patch 2, if you fix the error I
pointed out):

Acked-by: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
