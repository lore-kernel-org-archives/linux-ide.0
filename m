From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata/pata_arasan_cf: fill dma chan->private from
 pdata->dma_priv
Date: Fri, 4 Mar 2011 12:16:18 +0100
Message-ID: <20110304111618.GK20499@htj.dyndns.org>
References: <aef168cd6b2fd8f73bc559c0413dda003fcd09d7.1299236795.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37000 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758609Ab1CDLQW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Mar 2011 06:16:22 -0500
Received: by fxm17 with SMTP id 17so2016808fxm.19
        for <linux-ide@vger.kernel.org>; Fri, 04 Mar 2011 03:16:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <aef168cd6b2fd8f73bc559c0413dda003fcd09d7.1299236795.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, shiraz.hashim@st.com, amit.goel@st.com, armando.visconti@st.com, viresh.linux@gmail.com

On Fri, Mar 04, 2011 at 04:39:29PM +0530, Viresh Kumar wrote:
> Some DMA controllers (eg: drivers/dma/dw_dmac*) allow platform specific
> configuration for dma transfers. User drivers need to set chan->private field
> of channel with pointer to configuration data. This patch takes dma_priv data
> from platform data and passes it to chan->private_data, in order to pass
> platform specific configuration to DMAC controller.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
