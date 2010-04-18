From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3] ahci: add "em_buffer" attribute for AHCI hosts
Date: Mon, 19 Apr 2010 08:18:33 +0900
Message-ID: <4BCB9349.2090803@kernel.org>
References: <1271393208.5078.2.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53650 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858Ab0DRXPE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Apr 2010 19:15:04 -0400
In-Reply-To: <1271393208.5078.2.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harry Zhang <harry.zhang@amd.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Shane.Huang@amd.com

On 04/16/2010 01:46 PM, Harry Zhang wrote:
> @@ -2088,16 +2175,16 @@ void ahci_set_em_messages(struct ahci_host_priv *hpriv,
>  	void __iomem *mmio = hpriv->mmio;
>  	u32 em_loc = readl(mmio + HOST_EM_LOC);
>  	u32 em_ctl = readl(mmio + HOST_EM_CTL);
> -[PATCH v3] ahci: add "em_buffer" attribute for AHCI hosts
>  	if (!ahci_em_messages || !(hpriv->cap & HOST_CAP_EMS))
>  		return;

??????  Can you please regenerate the patch against a clean #upstream
tree?

-- 
tejun
