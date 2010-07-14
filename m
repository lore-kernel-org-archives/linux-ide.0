From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] ata_generic: drop hard coded DMA force logic
 for CENATEK
Date: Wed, 14 Jul 2010 03:52:05 -0400
Message-ID: <4C3D6CA5.3050308@garzik.org>
References: <4C2DDE74.3070405@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46281 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab0GNHwI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jul 2010 03:52:08 -0400
Received: by mail-gx0-f174.google.com with SMTP id 23so3663839gxk.19
        for <linux-ide@vger.kernel.org>; Wed, 14 Jul 2010 00:52:08 -0700 (PDT)
In-Reply-To: <4C2DDE74.3070405@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Andy Whitcroft <apw@canonical.com>

On 07/02/2010 08:41 AM, Tejun Heo wrote:
> Commit 1529c69adc (ata_generic: implement ATA_GEN_* flags and force
> enable DMA on MBP 7,1) implemented ATA_GEN_FORCE_DMA for forcing DMA
> mode and applied it to CENATEK but forgot to remove the original hard
> coded logic.  This is removal of redundant logic and doesn't affect
> correctness.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Andy Whitcroft<apw@canonical.com>
> ---
>   drivers/ata/ata_generic.c |    4 ----
>   1 file changed, 4 deletions(-)

applied


