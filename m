From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: port and device of libata.force ID separated
 by point
Date: Thu, 22 Apr 2010 21:52:49 -0400
Message-ID: <4BD0FD71.3060602@pobox.com>
References: <201004211217.12697.roman.fietze@telemotive.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46110 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846Ab0DWBwy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Apr 2010 21:52:54 -0400
Received: by gyg13 with SMTP id 13so4849381gyg.19
        for <linux-ide@vger.kernel.org>; Thu, 22 Apr 2010 18:52:53 -0700 (PDT)
In-Reply-To: <201004211217.12697.roman.fietze@telemotive.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roman Fietze <roman.fietze@telemotive.de>
Cc: linux-ide@vger.kernel.org

On 04/21/2010 06:17 AM, Roman Fietze wrote:
> Hello,
>
> If I understand libata-core correctly, esp. arround line 6572:
>
> 	/* parse id */
> 	p = strchr(id, '.');
> 	...
>
> the optional device is separated from the port in the libata.force ID
> by a point or dot instead of by a colon.
>
> If my assumption is correct, this patch will fix the documentation:
>
> Signed-off-by: Roman Fietze<roman.fietze@telemotive.de>
> ---
>   Documentation/kernel-parameters.txt |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index e7848a0..ea5a826 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1193,7 +1193,7 @@ and is between 256 and 4096 characters. It is defined in the file
>
>   	libata.force=	[LIBATA] Force configurations.  The format is comma
>   			separated list of "[ID:]VAL" where ID is
> -			PORT[:DEVICE].  PORT and DEVICE are decimal numbers
> +			PORT[.DEVICE].  PORT and DEVICE are decimal numbers
>   			matching port, link or device.  Basically, it matches
>   			the ATA ID string printed on console by libata.  If

applied


