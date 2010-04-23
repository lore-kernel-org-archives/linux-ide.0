From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: use __ratelimit
Date: Thu, 22 Apr 2010 22:07:41 -0400
Message-ID: <4BD100ED.2090208@pobox.com>
References: <1271074301-3812-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47807 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755044Ab0DWCHo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Apr 2010 22:07:44 -0400
Received: by gwj19 with SMTP id 19so2463922gwj.19
        for <linux-ide@vger.kernel.org>; Thu, 22 Apr 2010 19:07:43 -0700 (PDT)
In-Reply-To: <1271074301-3812-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-ide@vger.kernel.org

On 04/12/2010 08:11 AM, Akinobu Mita wrote:
> Use __ratelimit() instead of its own private rate limit implementation.
>
> Signed-off-by: Akinobu Mita<akinobu.mita@gmail.com>
> Cc: Jeff Garzik<jgarzik@pobox.com>
> Cc: linux-ide@vger.kernel.org
> ---
>   drivers/ata/libata-core.c |   19 +++----------------
>   1 files changed, 3 insertions(+), 16 deletions(-)

applied


