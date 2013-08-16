From: Tejun Heo <tj@kernel.org>
Subject: Re: [patch] sata, highbank: clear whole array in
 highbank_initialize_phys()
Date: Fri, 16 Aug 2013 12:53:50 -0400
Message-ID: <20130816165350.GL2505@htj.dyndns.org>
References: <20130816073336.GA9881@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f49.google.com ([209.85.128.49]:34569 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643Ab3HPQxy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Aug 2013 12:53:54 -0400
Content-Disposition: inline
In-Reply-To: <20130816073336.GA9881@elgon.mountain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello, Dan.

On Fri, Aug 16, 2013 at 10:33:36AM +0300, Dan Carpenter wrote:
> @@ -347,9 +347,9 @@ static int highbank_initialize_phys(struct device *dev, void __iomem *addr)
>  	struct device_node *phy_nodes[CPHY_PHY_COUNT];
>  	u32 tx_atten[CPHY_PORT_COUNT];
>  
> -	memset(port_data, 0, sizeof(struct phy_lane_info) * CPHY_PORT_COUNT);
> -	memset(phy_nodes, 0, sizeof(struct device_node*) * CPHY_PHY_COUNT);
> -	memset(tx_atten, 0xff, CPHY_PORT_COUNT);
> +	memset(port_data, 0, sizeof(port_data));
> +	memset(phy_nodes, 0, sizeof(phy_nodes));
> +	memset(tx_atten, 0xff, sizeof(tx_atten));

Ugh... why would anybody name a global variable port_data[]?  So,
port_data is global and the other two are local.  Wouldn't it be
better to just do "= { }" on declaration for the local ones?

Thanks.

-- 
tejun
