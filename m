From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH Resend] ATA: Debugging options for the ATA subsystem
Date: Sat, 23 Jul 2011 18:17:29 -0400
Message-ID: <4E2B4879.7000903@pobox.com>
References: <e6eda088c6d3761ac4f5d1719489be61356e3a8a.1307591731.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:39476 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab1GWWRb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jul 2011 18:17:31 -0400
Received: by qyk9 with SMTP id 9so1863514qyk.19
        for <linux-ide@vger.kernel.org>; Sat, 23 Jul 2011 15:17:30 -0700 (PDT)
In-Reply-To: <e6eda088c6d3761ac4f5d1719489be61356e3a8a.1307591731.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com

On 06/08/2011 11:56 PM, Viresh Kumar wrote:
> This adds Kconfig options for DEBUG and VERBOSE_DEBUG to the ATA subsystem
>
> Signed-off-by: Viresh Kumar<viresh.kumar@st.com>
> ---
>   drivers/ata/Kconfig  |   14 ++++++++++++++
>   drivers/ata/Makefile |    2 ++
>   2 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 5dd1e4c..e1ac908 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -22,6 +22,20 @@ menuconfig ATA
>
>   if ATA
>
> +config ATA_DEBUG
> +        bool "ATA debugging"
> +        help
> +          This is an option for use by developers; most people should
> +          say N here.  This enables ATA core and driver debugging.
> +
> +config ATA_VDEBUG
> +        bool "ATA verbose debugging"
> +        depends on ATA_DEBUG
> +        help
> +          This is an option for use by developers; most people should
> +          say N here.  This enables deeper (more verbose) debugging of
> +          the ATA core and drivers.
> +

There does not seem to be a large, driving need for this.  It is 
straightforward to update the header file for the esoteric, voluminous 
debugging.

If you are missing critical hardware or software errors, that is an 
argument that those error messages should be outside of DEBUG/VDEBUG, 
shipped with every kernel.

	Jeff



