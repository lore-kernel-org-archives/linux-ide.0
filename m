From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-sff: kill ata_bus_reset()
Date: Thu, 22 Apr 2010 22:06:00 -0400
Message-ID: <4BD10088.2080608@pobox.com>
References: <201004222003.36076.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34927 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105Ab0DWCGE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Apr 2010 22:06:04 -0400
Received: by gyg13 with SMTP id 13so4856930gyg.19
        for <linux-ide@vger.kernel.org>; Thu, 22 Apr 2010 19:06:04 -0700 (PDT)
In-Reply-To: <201004222003.36076.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On 04/22/2010 12:03 PM, Sergei Shtylyov wrote:
> ... since I see no callers of it.
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>
> ---
> The patch is against the recent Linus' tree.
>
>   Documentation/DocBook/libata.tmpl |    6 --
>   drivers/ata/libata-sff.c          |   94 --------------------------------------
>   include/linux/libata.h            |    1
>   3 files changed, 2 insertions(+), 99 deletions(-)

applied


