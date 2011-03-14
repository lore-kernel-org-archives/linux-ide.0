From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH][v3] driver/FSL SATA:Fix wrong Device Error Register usage
Date: Mon, 14 Mar 2011 03:05:07 -0400
Message-ID: <4D7DBE23.10109@pobox.com>
References: <1299655038-727-1-git-send-email-prabhakar@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52405 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202Ab1CNHFM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Mar 2011 03:05:12 -0400
Received: by vws1 with SMTP id 1so2122610vws.19
        for <linux-ide@vger.kernel.org>; Mon, 14 Mar 2011 00:05:11 -0700 (PDT)
In-Reply-To: <1299655038-727-1-git-send-email-prabhakar@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, meet2prabhu@gmail.com, Ashish Kalra <B00888@freescale.com>

On 03/09/2011 02:17 AM, Prabhakar Kushwaha wrote:
> When a single device error is detected, the device under the error is indicated
> by the error bit set in the DER. There is a one to one mapping between register
> bit and devices on Port multiplier(PMP) i.e. bit 0 represents PMP device 0 and
> bit 1 represents PMP device 1 etc.
>
> Current implementation treats Device error register value as device number not
> set of bits representing multiple device on PMP. It is changed to consider bit
> level.
> No need to check for each set bit as all command is going to be aborted.
>
> Signed-off-by: Ashish Kalra<B00888@freescale.com>
> Signed-off-by: Prabhakar Kushwaha<prabhakar@freescale.com>
> ---
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git (branch master)
>
>   This patch is already gone through review of linuxppc-dev mail list.
>   Making CC linuxppc-dev@lists.ozlabs.org
>
>   Changes for v2: Incorporated Sergei Shtylyov's comment
> 	- Put space after -
> 	- added a line
>   Changes for v3: Incorporated David Laight's comment
>   	- Condition check for dereg 0 for hardware error
>
>   drivers/ata/sata_fsl.c |    7 +++++--
>   1 files changed, 5 insertions(+), 2 deletions(-)

applied


