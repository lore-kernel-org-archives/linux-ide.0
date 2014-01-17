From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libahci: correct a misleading comment
Date: Fri, 17 Jan 2014 07:00:16 -0500
Message-ID: <20140117120016.GB8598@htj.dyndns.org>
References: <20140117114319.2784.3961.stgit@gklab-154-244.igk.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:45135 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbaAQMAU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Jan 2014 07:00:20 -0500
Content-Disposition: inline
In-Reply-To: <20140117114319.2784.3961.stgit@gklab-154-244.igk.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lukasz Dorau <lukasz.dorau@intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 17, 2014 at 12:43:20PM +0100, Lukasz Dorau wrote:
> There is an error in a comment introduced by:
> 	commit fa070ee6dc70bcc19737a2406d741b089b3149d5
> 	libahci: fix turning on LEDs in ahci_start_port()
> 
> Correct it.
> 
> Signed-off-by: Lukasz Dorau <lukasz.dorau@intel.com>
> ---
>  drivers/ata/libahci.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index c482f8c..1f526e6 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -780,8 +780,8 @@ static void ahci_start_port(struct ata_port *ap)
>  							       4);
>  				/*
>  				 * If busy, give a breather but do not
> -				 * release EH ownership by using msleep()
> -				 * instead of ata_msleep().  EM Transmit
> +				 * release EH ownership by using ata_msleep()
> +				 * instead of msleep().  EM Transmit

Can't the sentence be parsed to mean the same thing either way?  "(do
not release EH ownership) by using msleep..." or "do not (release EH
ownership by using ata_msleep)..."

With the context, I don't think which way to group things is
ambiguous.  In fact, saying "instead of msleep()" is kinda confusing
because using ata_msleep() should be the default.

Thanks.

-- 
tejun
