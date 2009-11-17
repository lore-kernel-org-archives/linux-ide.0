From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Tue, 17 Nov 2009 17:36:28 -0500
Message-ID: <4B03256C.5000201@garzik.org>
References: <20091117144450.15430.83450.stgit@localhost.localdomain> <20091117145137.15430.11229.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54570 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756346AbZKQWgj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Nov 2009 17:36:39 -0500
In-Reply-To: <20091117145137.15430.11229.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 11/17/2009 09:51 AM, Alan Cox wrote:
> Signed-off-by: Alan Cox<alan@linux.intel.com>
> ---
>
>   drivers/ata/Kconfig |    8 ++++----
>   1 files changed, 4 insertions(+), 4 deletions(-)
>
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index f2df6e2..36931e0 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -374,7 +374,7 @@ config PATA_HPT366
>   	  If unsure, say N.
>
>   config PATA_HPT37X
> -	tristate "HPT 370/370A/371/372/374/302 PATA support (Experimental)"
> +	tristate "HPT 370/370A/371/372/374/302 PATA support"
>   	depends on PCI&&  EXPERIMENTAL


When you change the help string, you must also change the 'depends' line.

	Jeff




