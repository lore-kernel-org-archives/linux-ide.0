From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/1] libata: sata_rcar: Convert to devm_ioremap_resource()
Date: Thu, 11 Apr 2013 19:35:10 -0400
Message-ID: <516748AE.5090503@pobox.com>
References: <1365067596-8868-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:60308 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab3DKXfP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Apr 2013 19:35:15 -0400
Received: by mail-qa0-f47.google.com with SMTP id g10so66168qah.13
        for <linux-ide@vger.kernel.org>; Thu, 11 Apr 2013 16:35:15 -0700 (PDT)
In-Reply-To: <1365067596-8868-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-ide@vger.kernel.org, vladimir.barinov@cogentembedded.com

On 04/04/2013 05:26 AM, Sachin Kamat wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>   drivers/ata/sata_rcar.c |    7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

applied



