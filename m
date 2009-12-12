From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] au1xxx-ide.c: ioremap() returns a void __iomem *
Date: Sun, 13 Dec 2009 01:54:08 +0300
Message-ID: <4B241F10.7050706@ru.mvista.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901FB10C2@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:27692 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S933752AbZLMBkq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Dec 2009 20:40:46 -0500
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901FB10C2@mi8nycmail19.Mi8.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, David Miller <davem@davemloft.net>

Hello.

H Hartley Sweeten wrote:

> The ioremap return value is an __iomem *, not an integer.  Update the
> private structure to reflect this.  While here, remove the typedef
> for _auide_hwif and just use struct auide_hwif instead as recommended
> by Documentation/CodingStyle.
>
> auide_setup_ports() still needs to cast the regbase back to an integer
> to correctly setup the io_ports_array.
>
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: David Miller <davem@davemloft.net>
>
> ---
>
> diff --git a/Documentation/mips/AU1xxx_IDE.README b/Documentation/mips/AU1xxx_IDE.README
> index 8ace35e..37c6c34 100644
> --- a/Documentation/mips/AU1xxx_IDE.README
> +++ b/Documentation/mips/AU1xxx_IDE.README
> @@ -45,7 +45,7 @@ FILES, CONFIGS AND COMPATABILITY
>  Two files are introduced:
>  
>    a) 'arch/mips/include/asm/mach-au1x00/au1xxx_ide.h'
> -     containes : struct _auide_hwif
> +     containes : struct auide_hwif
>   

   Contains?

   Other than that,

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


