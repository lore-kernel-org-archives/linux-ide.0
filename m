From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_samsung_cf: use module_platform_driver_probe()
Date: Mon, 04 Mar 2013 17:14:45 -0500
Message-ID: <51351CD5.6060300@pobox.com>
References: <015401ce18b3$1eb9aaa0$5c2cffe0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54]:39020 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932378Ab3CDWOs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Mar 2013 17:14:48 -0500
Received: by mail-qe0-f54.google.com with SMTP id i11so3397412qej.13
        for <linux-ide@vger.kernel.org>; Mon, 04 Mar 2013 14:14:47 -0800 (PST)
In-Reply-To: <015401ce18b3$1eb9aaa0$5c2cffe0$%han@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-ide@vger.kernel.org

On 03/04/2013 03:34 AM, Jingoo Han wrote:
> This patch uses module_platform_driver_probe() macro which makes
> the code smaller and simpler.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>   drivers/ata/pata_samsung_cf.c |   13 +------------
>   1 files changed, 1 insertions(+), 12 deletions(-)

applied



