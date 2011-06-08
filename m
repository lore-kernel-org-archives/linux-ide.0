From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] ATA: Debugging options for the ATA subsystem
Date: Wed, 08 Jun 2011 18:39:46 +0400
Message-ID: <4DEF89B2.6010601@ru.mvista.com>
References: <1edabe459c04313f2e9bb4282a7bea208272e618.1307513666.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:61178 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628Ab1FHOl2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2011 10:41:28 -0400
Received: by wwk4 with SMTP id 4so3535836wwk.1
        for <linux-ide@vger.kernel.org>; Wed, 08 Jun 2011 07:41:27 -0700 (PDT)
In-Reply-To: <1edabe459c04313f2e9bb4282a7bea208272e618.1307513666.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello.

Viresh Kumar wrote:

> This adds Kconfig options for DEBUG and VERBOSE_DEBUG to the ATA subsystem

> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/ata/Kconfig  |   14 ++++++++++++++
>  drivers/ata/Makefile |    2 ++
>  2 files changed, 16 insertions(+), 0 deletions(-)

> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 75afa75..d527fbe 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -30,6 +30,20 @@ menuconfig ATA
>  
>  if ATA
>  
> +config ATA_DEBUG
> +        bool "ATA debugging"
> +        help
> +          This is an option for use by developers; most people should
> +          say N here.  This enables ATA core and driver debugging.
> +
> +config ATA_VDEBUG
> +        bool "ATA verbose debugging"
> +        depends on ATA_DEBUG != n

    Why not just on ATA_DEBUG? It can only be 'y' or 'n'.

WBR, Sergei

