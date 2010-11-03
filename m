From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Where should i add Compact flash driver?
Date: Wed, 3 Nov 2010 14:56:37 +0100
Message-ID: <20101103135637.GA8594@isilmar-3.linta.de>
References: <4CCFA0B6.7050602@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isilmar-3.linta.de ([188.40.101.200]:59965 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755169Ab0KCN4m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Nov 2010 09:56:42 -0400
Content-Disposition: inline
In-Reply-To: <4CCFA0B6.7050602@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: viresh kumar <viresh.kumar@st.com>
Cc: linux-pcmcia@lists.infradead.org, linux-ide@vger.kernel.org, Armando VISCONTI <armando.visconti@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>

Hey,

as this doesn't seem to be a PCMCIA-capable driver, I'd say drivers/ata/
(same as pata_octeon_cf.c, for example)... But this decision seems quite
easy to revert once the code is available :)

Best,
	Dominik

On Tue, Nov 02, 2010 at 10:55:10AM +0530, viresh kumar wrote:
> Hello,
> 
> I am developing driver for CF+ module for SPEAr Platform.
> I am not sure where should i add it? PCMCIA or somewhere else?
> Can somebody please help me on this. Brief description of device
> can be found at:
> 
> www.arasan.com/products/memory/CompactFlash-Device-Flyer-1.0.pdf
> 
> We have controller on AHB/APB interface.
> 
> -- 
> viresh
> 
> _______________________________________________
> Linux PCMCIA reimplementation list
> http://lists.infradead.org/mailman/listinfo/linux-pcmcia
