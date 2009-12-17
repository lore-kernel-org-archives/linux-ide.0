From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/6] sata_mv: increase PIO IORDY timeout
Date: Thu, 17 Dec 2009 01:03:34 -0500
Message-ID: <4B29C9B6.7020105@garzik.org>
References: <1260116782-31714-1-git-send-email-saeed@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:44510 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347AbZLQGDg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 01:03:36 -0500
Received: by mail-yw0-f182.google.com with SMTP id 12so1984917ywh.21
        for <linux-ide@vger.kernel.org>; Wed, 16 Dec 2009 22:03:36 -0800 (PST)
In-Reply-To: <1260116782-31714-1-git-send-email-saeed@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca, nico@fluxnic.net, buytenh@wantstofly.org

On 12/06/2009 11:26 AM, Saeed Bishara wrote:
> The old value (0xbc) in cycles of the IORDY timeout is suitable for
> devices with core clock of 166 MHz, but some SoC controllers have
> faster core clocks. The new value will make the IORDY timeout large
> enough also for all SoC devices.
>
> Signed-off-by: Saeed Bishara<saeed@marvell.com>
> ---
>   drivers/ata/sata_mv.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

applied 1-4


