From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/3] pata_hpt366: coding style cleanup
Date: Fri, 07 Jan 2011 22:34:41 -0500
Message-ID: <4D27DB51.2050804@pobox.com>
References: <201012282306.39040.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53892 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab1AHDeo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jan 2011 22:34:44 -0500
Received: by mail-vw0-f46.google.com with SMTP id 16so7391603vws.19
        for <linux-ide@vger.kernel.org>; Fri, 07 Jan 2011 19:34:44 -0800 (PST)
In-Reply-To: <201012282306.39040.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On 12/28/2010 03:06 PM, Sergei Shtylyov wrote:
> Fix 2 errors and 11 warnings given by checkpatch.pl:
>
> - *switch* and *case* not on the same indentation level;
>
> - no space between *switch* and open parenthesis;
>
> - drive blacklist arrays not being *const*;
>
> - spaces before tabs;
>
> - lines over 80 characters.
>
> In addition to these changes, also add new line after variable definition in
> hpt36x_init_chipset()...
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>
> ---
> The patch is against the recent Linus' tree.
>
>   drivers/ata/pata_hpt366.c |   51 ++++++++++++++++++++++++++--------------------
>   1 file changed, 29 insertions(+), 22 deletions(-)

applied 1-3


