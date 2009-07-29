From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH v2] libata: Updates and fixes for pata_at91 driver
Date: Tue, 28 Jul 2009 21:09:20 -0400
Message-ID: <4A6FA140.8020806@garzik.org>
References: <1247769535-11695-1-git-send-email-geomatsi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59169 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528AbZG2BJV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jul 2009 21:09:21 -0400
In-Reply-To: <1247769535-11695-1-git-send-email-geomatsi@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-ide@vger.kernel.org

Sergey Matyukevich wrote:
> Please consider the following updates and fixes for pata_at91 driver.
> 
> * Removed extra headers
> 	Here we need only static memory controller properties, which are
> 	contained in generic header at91sam9_smc.h.
> 	No need to include any specific headers for at91sam9260 SoC.
> 
> * No harsh BUG_ON for get_clk in set_smc_timing function
>         get_clk is now performed in driver probing function,
> 	        probing fails if master clock is not available
> 
> * Fixed uint/ulong mess in calc_mck_cycles function
> 
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> ---
>  drivers/ata/pata_at91.c |   67 +++++++++++++++++++++++++---------------------
>  1 files changed, 36 insertions(+), 31 deletions(-)

applied


