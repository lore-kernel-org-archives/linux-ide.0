From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: note that IDE generic may prevent other drivers from attaching
Date: Sat, 27 Sep 2008 19:13:52 +0200
Message-ID: <200809271913.53160.bzolnier@gmail.com>
References: <WorldClient-F200808221729.AA29360172@butn.net> <WorldClient-F200809120953.AA53480062@butn.net> <48CA2AA0.8000302@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:17388 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859AbYI0R3E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Sep 2008 13:29:04 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1365593fkq.5
        for <linux-ide@vger.kernel.org>; Sat, 27 Sep 2008 10:29:02 -0700 (PDT)
In-Reply-To: <48CA2AA0.8000302@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: xerces8 <xerces8@butn.net>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, stein@hermes.si

On Friday 12 September 2008, Tejun Heo wrote:
> Enabling IDE generic may prevent ATA controllers located on legacy
> ports from being attached to more proper driver or can prevent other
> controllers which share the IRQ from working.  Note it in the help
> message.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

applied

> ---
>  drivers/ide/Kconfig |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
> index fc735ab..5e5b2d3 100644
> --- a/drivers/ide/Kconfig
> +++ b/drivers/ide/Kconfig
> @@ -292,6 +292,20 @@ config IDE_GENERIC
>  	tristate "generic/default IDE chipset support"
>  	depends on ALPHA || X86 || IA64 || M32R || MIPS
>  	help
> +	  This is the generic IDE driver.  This driver attaches to the
> +	  fixed legacy ports (e.g. on PCs 0x1f0/0x170, 0x1e8/0x168 and
> +	  so on).  Please note that if this driver is built into the
> +	  kernel or loaded before other ATA (IDE or libata) drivers
> +	  and the controller is located at legacy ports, this driver
> +	  will grab those ports and thus can prevent the controller
> +	  specific driver from attaching.

s/will grab/may grab/ since Borislav has fixed PCI-case for .28
