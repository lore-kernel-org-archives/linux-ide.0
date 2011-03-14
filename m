From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] driver/FSL SATA: Update RX_WATER_MARK for TRANSCFG
Date: Mon, 14 Mar 2011 03:06:08 -0400
Message-ID: <4D7DBE60.1040609@pobox.com>
References: <1299470290-3451-1-git-send-email-prabhakar@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46929 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202Ab1CNHGK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Mar 2011 03:06:10 -0400
Received: by vws1 with SMTP id 1so2122937vws.19
        for <linux-ide@vger.kernel.org>; Mon, 14 Mar 2011 00:06:10 -0700 (PDT)
In-Reply-To: <1299470290-3451-1-git-send-email-prabhakar@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: linux-ide@vger.kernel.org, meet2prabhu@gmail.com

On 03/06/2011 10:58 PM, Prabhakar Kushwaha wrote:
> RX_WATER_MARK sets the number of locations in Rx FIFO that can be used before
> the transport layer instructs the link layer to transmit HOLDS. Note that it
> can take some time for the HOLDs to get to the other end, and that in the
> interim there must be enough room in the FIFO to absorb all data that could
> arrive.
>
> Update the new recommended value to 16.
>
> Signed-off-by: Prabhakar Kushwaha<prabhakar@freescale.com>
> ---
>   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git (branch master)
>
>   This patch is already gone through review of linuxppc-dev mail list.
>
>   drivers/ata/sata_fsl.c |   12 ++++++++++++
>   1 files changed, 12 insertions(+), 0 deletions(-)

applied


