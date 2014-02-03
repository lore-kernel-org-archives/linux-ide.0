From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 08/14] ahci-platform: "Library-ise" suspend / resume functionality
Date: Mon, 3 Feb 2014 15:53:45 +0100
Message-ID: <201402031553.46083.arnd@arndb.de>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com> <1390417489-5354-9-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50151 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbaBCOx7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Feb 2014 09:53:59 -0500
In-Reply-To: <1390417489-5354-9-git-send-email-hdegoede@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-ide@vger.kernel.org, Oliver Schinagl <oliver@schinagl.nl>, Richard Zhu <Hong-Xing.Zhu@freescale.com>, linux-sunxi@googlegroups.com, Maxime Ripard <maxime.ripard@free-electrons.com>, Roger Quadros <rogerq@ti.com>

On Wednesday 22 January 2014, Hans de Goede wrote:
> --- a/include/linux/ahci_platform.h
> +++ b/include/linux/ahci_platform.h
> @@ -50,4 +50,11 @@ int ahci_platform_init_host(struct platform_device *pdev,
>                             unsigned int force_port_map,
>                             unsigned int mask_port_map);
>  
> +#ifdef CONFIG_PM_SLEEP
> +int ahci_platform_suspend_host(struct device *dev);
> +int ahci_platform_resume_host(struct device *dev);
> +int ahci_platform_suspend(struct device *dev);
> +int ahci_platform_resume(struct device *dev);
> +#endif
> +

Not sure if the #ifdef does any good here. Normally, we don't hide declarations
so we can do stuff like

	if (IS_ENABLED(CONFIG_PM_SLEEP))
		ret = ahci_platform_suspend_host(dev);

and expect the code to compile and link just fine.

	Arnd
