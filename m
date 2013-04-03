From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] drivers: ata: Use resource_size function
Date: Wed, 03 Apr 2013 19:56:14 -0400
Message-ID: <515CC19E.40906@pobox.com>
References: <1363444332-379-1-git-send-email-gheorghiuandru@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:45328 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762128Ab3DCX4Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Apr 2013 19:56:16 -0400
In-Reply-To: <1363444332-379-1-git-send-email-gheorghiuandru@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/16/2013 10:32 AM, Alexandru Gheorghiu wrote:
> Use resource_size function instead of explicit computation.
> Patch found using coccinelle.
>
> Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
> ---
>   drivers/ata/pata_octeon_cf.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

applied



