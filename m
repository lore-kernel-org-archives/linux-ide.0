From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V2 2/2] pata_arasan_cf: Adding support for arasan
 compact flash host controller
Date: Tue, 22 Feb 2011 09:58:57 +0100
Message-ID: <20110222085857.GQ31267@htj.dyndns.org>
References: <cover.1298029161.git.viresh.kumar@st.com>
 <e2f140271f9db752fdc05e348065b23fc4e4aa29.1298029161.git.viresh.kumar@st.com>
 <20110218143438.GK21209@htj.dyndns.org>
 <4D634DD0.60106@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62014 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab1BVI7C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Feb 2011 03:59:02 -0500
Received: by fxm17 with SMTP id 17so2509065fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 22 Feb 2011 00:59:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D634DD0.60106@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: viresh kumar <viresh.kumar@st.com>
Cc: "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>, amitgoel <amit.goel@st.com>

Hello,

On Tue, Feb 22, 2011 at 11:16:56AM +0530, viresh kumar wrote:
> Actually, we really don't have scatter-gather in our controller.
> We have to read/write to the same FIFO address for every 512 bytes, after
> which we get buf_avail interrupt. And Controller can do a maximum transfer
> of 256 KB after which it gives transfer complete interrupt.
> 
> So all sg has to be handled in software, framework or driver.

Yeap, so you don't need to follow the silly BMDMA restrictions.

> Also, we will always read/write from/to FIFO. And the external DMA controller
> doesn't have any limitation of this dma_boudary.
> 
> So i feel i should keep
> .sg_tablesize = SG_ALL,
> .dma_boundary = 0xFFFFFFFF,
> 
> Please correct me if i am wrong.

Looks good to me.

Thanks.

-- 
tejun
