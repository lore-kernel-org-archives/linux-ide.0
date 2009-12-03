From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_hpt366: fix timing register documentation
Date: Thu, 03 Dec 2009 02:36:41 -0500
Message-ID: <4B176A89.9080602@pobox.com>
References: <200911242317.31495.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f119.google.com ([209.85.210.119]:43791 "EHLO
	mail-yx0-f119.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992AbZLCHv6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 02:51:58 -0500
Received: by yxe17 with SMTP id 17so88235yxe.33
        for <linux-ide@vger.kernel.org>; Wed, 02 Dec 2009 23:52:04 -0800 (PST)
In-Reply-To: <200911242317.31495.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On 11/24/2009 03:17 PM, Sergei Shtylyov wrote:
> The comment in the driver actually describes HPT37x's timing register layout,
> which is different from HPT36x.  Fix it and reformat the comment, while at it.
>
> Bump the driver version, accounting for several patches that forgot to do it.
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>
> ---
> The patch is against the recent Linus' tree.
>
>   drivers/ata/pata_hpt366.c |   30 ++++++++++++++----------------
>   1 files changed, 14 insertions(+), 16 deletions(-)

applied


