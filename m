From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v3] pata_hpt3x2n: clarify about HPT371N support
Date: Fri, 07 Jan 2011 22:34:20 -0500
Message-ID: <4D27DB3C.9080409@pobox.com>
References: <201012282146.40654.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53892 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab1AHDeX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jan 2011 22:34:23 -0500
Received: by mail-vw0-f46.google.com with SMTP id 16so7391603vws.19
        for <linux-ide@vger.kernel.org>; Fri, 07 Jan 2011 19:34:23 -0800 (PST)
In-Reply-To: <201012282146.40654.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On 12/28/2010 01:46 PM, Sergei Shtylyov wrote:
> Commit 28e21c8c0d44cd63bad4c62f94ef0c5a1cb8402c (pata_hpt3x2n: Add HPT371N
> support and other bits) forgot to update the driver's Kconfig entry, heading
> comment, and module description (that also wrongly claims support of HPT302)
> which may confuse users...
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>
> ---
> The patch is against the recent Linus' tree.
>
> Changes since previous version:
> - removed no longer applying comment...
>
>   drivers/ata/Kconfig        |    4 ++--
>   drivers/ata/pata_hpt3x2n.c |    6 ++----
>   2 files changed, 4 insertions(+), 6 deletions(-)

applied


