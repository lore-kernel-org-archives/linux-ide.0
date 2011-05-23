From: viresh kumar <viresh.kumar@st.com>
Subject: Re: [PATCH -next] ata: PATA_ARASAN_CF depends on DMADEVICES
Date: Mon, 23 May 2011 09:05:07 +0530
Message-ID: <4DD9D5EB.3060807@st.com>
References: <20110520165507.cba539d5.sfr@canb.auug.org.au> <20110522173227.5ba18817.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110522173227.5ba18817.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 05/23/2011 06:02 AM, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix kconfig unmet dependency warning:
> 
> warning: (PATA_ARASAN_CF && VIDEO_TIMBERDALE && SND_SOC_SH4_SIU) selects DMA_ENGINE which has unmet direct dependencies (DMADEVICES)
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/ata/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20110520.orig/drivers/ata/Kconfig
> +++ linux-next-20110520/drivers/ata/Kconfig
> @@ -313,6 +313,7 @@ config PATA_AMD
>  
>  config PATA_ARASAN_CF
>  	tristate "ARASAN CompactFlash PATA Controller Support"
> +	depends on DMADEVICES
>  	select DMA_ENGINE

Randy,

I think we can also remove this "select DMA_ENGINE" line.

Otherwise, it looks fine.

Acked-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
