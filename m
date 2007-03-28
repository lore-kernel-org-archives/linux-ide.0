From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: HPA patches
Date: Wed, 28 Mar 2007 22:54:31 +0100
Message-ID: <20070328225431.69d0a3cc@the-village.bc.nu>
References: <20070323191321.5d00887a@lxorguk.ukuu.org.uk>
	<20070328000851.GA25551@srcf.ucam.org>
	<20070328105754.72b578bd@the-village.bc.nu>
	<20070328200829.GA12776@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933264AbXC1UvV@vger.kernel.org>
In-Reply-To: <20070328200829.GA12776@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kyle@canonical.com
List-Id: linux-ide@vger.kernel.org

> Hm. I tried adding it in the eh code after ata_set_mode() in 
> ata_eh_recover(), which alters the problem slightly - hpa_sectors is 
> still 0, so the taskfile call is still failing, but now the system just 
> stops at around the time that anything attempts to access sda with no 
> errors other than

I wonder if the firmware is dying when we ask the disk to go zero sized
rather than erroring politely. I'm not sure hth HPA sectors can come back
as zero but we can be fairly sure 0 means "no HPA" in this case I guess ?
