From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_sil24: fix kernel panic on ARM caused
 by unaligned access in sata_sil24
Date: Mon, 07 Jun 2010 16:08:34 -0400
Message-ID: <4C0D51C2.8070309@garzik.org>
References: <4C090B87.1070109@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57638 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326Ab0FGUIh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jun 2010 16:08:37 -0400
Received: by gwb15 with SMTP id 15so1452875gwb.19
        for <linux-ide@vger.kernel.org>; Mon, 07 Jun 2010 13:08:37 -0700 (PDT)
In-Reply-To: <4C090B87.1070109@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Robin Randhawa <Robin.Randhawa@arm.com>, Colin Tuckley <colin.tuckley@arm.com>

On 06/04/2010 10:19 AM, Tejun Heo wrote:
> From: Colin Tuckley<colin.tuckley@arm.com>
>
> The sata_sil24 driver has six 16-bit registers that are initialised with
> 32-bit writes. This cause a kernel panic on ARM due to the unaligned
> accesses which result.
>
> This patch changes the accesses to the correct 16-bit ones.
>
> Signed-off-by: Colin Tuckley<colin.tuckley@arm.com>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> ---
>   drivers/ata/sata_sil24.c |   12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

applied


