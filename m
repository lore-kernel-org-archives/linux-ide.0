From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.19 3/3] sata_promise: cleanups
Date: Sun, 03 Dec 2006 08:07:46 -0500
Message-ID: <4572CC22.4050303@garzik.org>
References: <200612010959.kB19xmAw002464@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:30669 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1759656AbWLCNHs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Dec 2006 08:07:48 -0500
In-Reply-To: <200612010959.kB19xmAw002464@alkaid.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> This patch performs two simple cleanups of sata_promise.
> 
> * Remove board_20771 and map device id 0x3577 to board_2057x.
>   After the recent corrections for SATAII chips, board_20771 and
>   board_2057x were equivalent in the driver.
> 
> * Remove hp->hotplug_offset and use hp->flags & PDC_FLAG_GEN_II
>   to compute hotplug_offset in pdc_host_init().
> 
> This patch depends on the sata_promise SATAII updates
> patch I sent recently.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

ACK, but not applied:

patch #2 (presumably this patches depends on it) probably needs revision 
(see Tejun's comments).

feel free to resend this patch against #upstream, while revising patch #2

	Jeff



