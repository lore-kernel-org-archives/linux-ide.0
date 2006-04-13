From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.17-rc1-mm2 1/1] ahci: add support for VIA VT8251
Date: Thu, 13 Apr 2006 12:23:33 +0900
Message-ID: <443DC435.3020209@gmail.com>
References: <200604111915.45564.b.jacques@planet.nl> <200604130019.28671.b.jacques@planet.nl> <443D7EEE.3020102@garzik.org> <200604130208.56840.b.jacques@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.206]:59440 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932436AbWDMDXo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Apr 2006 23:23:44 -0400
Received: by xproxy.gmail.com with SMTP id t10so1106627wxc
        for <linux-ide@vger.kernel.org>; Wed, 12 Apr 2006 20:23:43 -0700 (PDT)
In-Reply-To: <200604130208.56840.b.jacques@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bastiaan Jacques <b.jacques@planet.nl>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello, Bastiaan.

Looks good to me.  Please see below.

Bastiaan Jacques wrote:
> Adds AHCI support for the VIA VT8251.
> 
> Includes a workaround for a hardware bug which requires a Command List
> Override before reset.
> 
> Signed-off-by: Bastiaan Jacques <b.jacques@planet.nl>
> Acked-by: Jeff Garzik <jeff@garzik.org>
> ---
[--snip--]
>  static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes)
>  {
> +	if ((ap->flags & AHCI_FLAG_RESET_NEEDS_CLO) &&
> +	    (ata_busy_wait(ap, ATA_BUSY, 1000) & ATA_BUSY)) {

I'm kind of uncomfortable with busy sleeping with @cnt at 1000.  That's 
 >> 10ms of busy waiting.  However, this is a minor issue and even if it 
gets changed it probably belongs to another patch.

Hmmm, ata_busy_sleep() would be a bit weird with the 'be patient' 
message and I always thought the function contained way too much busy 
waiting.  Processors are blazing fast and context switch is cheap these 
days.

Maybe we need to update ata_busy_sleep() so that it ignores tmout_pat if 
it's zero.  What do you think, Jeff?

> +		/* ATA_BUSY hasn't cleared, so send a CLO */
> +		ahci_clo(ap);
> +	}
> +

-- 
tejun
