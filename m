From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 1/3] libahci: save port map for forced port map
Date: Wed, 30 Mar 2016 14:57:06 -0400
Message-ID: <20160330185706.GQ7822@mtj.duckdns.org>
References: <1459257075-21393-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1459257075-21393-2-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35956 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbcC3S5I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Mar 2016 14:57:08 -0400
Content-Disposition: inline
In-Reply-To: <1459257075-21393-2-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jmaggard10@gmail.com

Hello,

On Tue, Mar 29, 2016 at 02:11:13PM +0100, Srinivas Kandagatla wrote:
> In usecases where force_port_map is used saved_port_map is never set,
> resulting in not programming the PORTS_IMPL register as part of intial
> config. This patch fixes this by setting it to port_map even in case
> where force_port_map is used, making it more inline with other parts of
> the code.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/ata/libahci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 3982054..a5d7c1c 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -507,6 +507,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>  		dev_info(dev, "forcing port_map 0x%x -> 0x%x\n",
>  			 port_map, hpriv->force_port_map);
>  		port_map = hpriv->force_port_map;
> +		hpriv->saved_port_map = port_map;

So, the only change it'd cause is making the driver write the forced
value to the PI register.  Does that make sense?

Thanks.

-- 
tejun
