From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata/pata_arasan_cf: fill dma chan->private from pdata->dma_priv
Date: Mon, 14 Mar 2011 02:58:22 -0400
Message-ID: <4D7DBC8E.6000207@pobox.com>
References: <aef168cd6b2fd8f73bc559c0413dda003fcd09d7.1299236795.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47203 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140Ab1CNG6Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Mar 2011 02:58:25 -0400
Received: by vws1 with SMTP id 1so2119947vws.19
        for <linux-ide@vger.kernel.org>; Sun, 13 Mar 2011 23:58:24 -0700 (PDT)
In-Reply-To: <aef168cd6b2fd8f73bc559c0413dda003fcd09d7.1299236795.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, shiraz.hashim@st.com, amit.goel@st.com, armando.visconti@st.com, viresh.linux@gmail.com

On 03/04/2011 06:09 AM, Viresh Kumar wrote:
> Some DMA controllers (eg: drivers/dma/dw_dmac*) allow platform specific
> configuration for dma transfers. User drivers need to set chan->private field
> of channel with pointer to configuration data. This patch takes dma_priv data
> from platform data and passes it to chan->private_data, in order to pass
> platform specific configuration to DMAC controller.
>
> Signed-off-by: Viresh Kumar<viresh.kumar@st.com>
> ---
>   drivers/ata/pata_arasan_cf.c        |    7 ++++++-
>   include/linux/pata_arasan_cf_data.h |    2 ++

applied


