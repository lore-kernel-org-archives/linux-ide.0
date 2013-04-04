From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/1] libata: sata_rcar: Convert to devm_ioremap_resource()
Date: Thu, 04 Apr 2013 18:43:45 +0400
Message-ID: <515D91A1.6040808@cogentembedded.com>
References: <1365067596-8868-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:49113 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761888Ab3DDOoq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Apr 2013 10:44:46 -0400
Received: by mail-lb0-f169.google.com with SMTP id p11so2800926lbi.14
        for <linux-ide@vger.kernel.org>; Thu, 04 Apr 2013 07:44:44 -0700 (PDT)
In-Reply-To: <1365067596-8868-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, vladimir.barinov@cogentembedded.com

Hello.

On 04-04-2013 13:26, Sachin Kamat wrote:

> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.

> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

MBR, Sergei

