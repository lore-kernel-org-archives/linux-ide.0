From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_at32: use module_platform_driver_probe()
Date: Wed, 03 Apr 2013 19:57:01 -0400
Message-ID: <515CC1CD.1080806@pobox.com>
References: <004901ce1942$5238e780$f6aab680$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:47252 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932360Ab3DCX5D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Apr 2013 19:57:03 -0400
Received: by mail-qc0-f182.google.com with SMTP id k19so955636qcs.27
        for <linux-ide@vger.kernel.org>; Wed, 03 Apr 2013 16:57:02 -0700 (PDT)
In-Reply-To: <004901ce1942$5238e780$f6aab680$%han@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-ide@vger.kernel.org

On 03/04/2013 08:39 PM, Jingoo Han wrote:
> This patch uses module_platform_driver_probe() macro which makes
> the code smaller and simpler.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>   drivers/ata/pata_at32.c |   13 +------------
>   1 files changed, 1 insertions(+), 12 deletions(-)

applied



