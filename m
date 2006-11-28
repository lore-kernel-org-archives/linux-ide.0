From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2.6.15.4 rel.2 1/1] libata: add hotswap to sata_svw
Date: Tue, 28 Nov 2006 23:22:19 +0000
Message-ID: <1164756139.14595.37.camel@pmac.infradead.org>
References: <E1F9klH-0004Fg-00@devix>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:26796 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1757849AbWK1XWZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Nov 2006 18:22:25 -0500
In-Reply-To: <E1F9klH-0004Fg-00@devix>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Devera <devik@cdi.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, lkosewsk@gmail.com.jgarzik

On Thu, 2006-02-16 at 16:09 +0100, Martin Devera wrote:
> From: Martin Devera <devik@cdi.cz>
> 
> Add hotswap capability to Serverworks/BroadCom SATA controlers. The
> controler has SIM register and it selects which bits in SATA_ERROR
> register fires interrupt.
> The solution hooks on COMWAKE (plug), PHYRDY change and 10B8B decode 
> error (unplug) and calls into Lukasz's hotswap framework.
> The code got one day testing on dual core Athlon64 H8SSL Supermicro 
> MoBo with HT-1000 SATA, SMP kernel and two CaviarRE SATA HDDs in
> hotswap bays.
> 
> Signed-off-by: Martin Devera <devik@cdi.cz>

What became of this?

-- 
dwmw2

