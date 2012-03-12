From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] libata: disable runtime pm for hotpluggable port
Date: Mon, 12 Mar 2012 14:29:49 +0400
Message-ID: <4F5DD01D.3010609@mvista.com>
References: <1331515012.3412.37.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58610 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab2CLKbP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2012 06:31:15 -0400
Received: by bkcik5 with SMTP id ik5so2443734bkc.19
        for <linux-ide@vger.kernel.org>; Mon, 12 Mar 2012 03:31:14 -0700 (PDT)
In-Reply-To: <1331515012.3412.37.camel@minggr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, jslaby@suse.cz, cwillu@cwillu.com, jackdachef@gmail.com

Hello.

On 12-03-2012 5:16, Lin Ming wrote:

> Currently, hotplug doesn't work if port is already runtime suspended.
> For now, we simply disable runtime pm for hotpluggable port.
> Later, we should add runtime pm support for hotpluggable port too.

> https://lkml.org/lkml/2012/2/19/70

> TODO: add similar hotpluggable port check for controllers other than AHCI.

> Reported-and-tested-by: Jiri Slaby<jslaby@suse.cz>
> Reported-and-tested-by: cwillu@cwillu.com
> Reported-and-tested-by: jackdachef@gmail.com
> Signed-off-by: Lin Ming<ming.m.lin@intel.com>
[...]

> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 3085bdc..ccf0282 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -209,8 +209,10 @@ enum {
>   	ATA_FLAG_SW_ACTIVITY	= (1<<  22), /* driver supports sw activity
>   					      * led */
>   	ATA_FLAG_NO_DIPM	= (1<<  23), /* host not happy with DIPM */
> +	ATA_FLAG_EXTERNAL	= (1<<  24), /* controller supports external SATA */
> +	ATA_FLAG_PLUGGABLE	= (1<<  25), /* port is hotpluggable */
>
> -	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
> +	/* bits 26:31 of ap->flags are reserved for LLD specific flags */

    There's no need to use bits 24..25, I've freed up some lower order bits 
last year, removing unused values.

WBR, Sergei
