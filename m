From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_via: explain the magic fix
Date: Mon, 07 Jun 2010 16:08:14 -0400
Message-ID: <4C0D51AE.5020901@garzik.org>
References: <4C077747.4050006@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37999 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab0FGUQX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jun 2010 16:16:23 -0400
Received: by gwb15 with SMTP id 15so1459346gwb.19
        for <linux-ide@vger.kernel.org>; Mon, 07 Jun 2010 13:16:22 -0700 (PDT)
In-Reply-To: <4C077747.4050006@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Joseph Chan <JosephChan@via.com.tw>

On 06/03/2010 05:35 AM, Tejun Heo wrote:
> Add Joseph Chan's explanation of the problem and workaround to the
> VT6421 magic fix.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: Joseph Chan<JosephChan@via.com.tw>
> ---
>   drivers/ata/sata_via.c |   18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)

applied


