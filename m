From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2 2/2] ata: AT91 ata driver requires AT91_HAS_PATA
Date: Sun, 11 Mar 2012 14:10:37 +0400
Message-ID: <4F5C7A1D.60208@mvista.com>
References: <1331415380-10928-1-git-send-email-alan@signal11.us> <1331415562-10994-1-git-send-email-alan@signal11.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49813 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226Ab2CKKMC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Mar 2012 06:12:02 -0400
Received: by bkcik5 with SMTP id ik5so1982370bkc.19
        for <linux-ide@vger.kernel.org>; Sun, 11 Mar 2012 03:12:01 -0700 (PDT)
In-Reply-To: <1331415562-10994-1-git-send-email-alan@signal11.us>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ben Dooks <ben-linux@fluff.org>

Hello.

On 11-03-2012 1:39, Alan Ott wrote:

> This driver uses registers defined in a per-soc header file.
> Since not every soc in the at91 platform defines those, make
> the Kconfig option dependent on those which define
> AT91_HAS_PATA.

> This is based on a patch by Arnd Bergmann.

> Signed-off-by: Arnd Bergmann<arnd@arndb.de>
> Signed-off-by: Alan Ott<alan@signal11.us>
> CC: Ben Dooks<ben-linux@fluff.org>
> ---
>   drivers/ata/Kconfig |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)

> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 6bdedd7..fdb8c90 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -731,6 +731,7 @@ config PATA_AT32
>   config PATA_AT91
>   	tristate "PATA support for AT91SAM9260"
>   	depends on ARM && ARCH_AT91

    Is this line still needed?

> +	depends on AT91_HAS_PATA
>   	help
>   	  This option enables support for IDE devices on the Atmel AT91SAM9260 SoC.

WBR, Sergei
