From: Yuantian Tang <Yuantian.Tang@freescale.com>
Subject: RE: [PATCH v3] ahci: qoriq: fixed using uninitialized variable
 warnings
Date: Mon, 14 Sep 2015 07:21:04 +0000
Message-ID: <DM2PR03MB574C0A381BDAC53ED35F932FA5D0@DM2PR03MB574.namprd03.prod.outlook.com>
References: <1442214769-46567-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-by2on0103.outbound.protection.outlook.com ([207.46.100.103]:26326
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751329AbbINHVH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Sep 2015 03:21:07 -0400
In-Reply-To: <1442214769-46567-1-git-send-email-Yuantian.Tang@freescale.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuantian Tang <Yuantian.Tang@freescale.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>
Cc: "tj@kernel.org" <tj@kernel.org>, "fengguang.wu@intel.com" <fengguang.wu@intel.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Tejun, Fengguang,

Please help to verify if this patch can remove the warnings.

Thanks,
Yuantian

> -----Original Message-----
> From: Yuantian.Tang@freescale.com [mailto:Yuantian.Tang@freescale.com]
> Sent: Monday, September 14, 2015 3:13 PM
> To: hdegoede@redhat.com
> Cc: tj@kernel.org; fengguang.wu@intel.com; linux-ide@vger.kernel.org;
> linux-kernel@vger.kernel.org; Tang Yuantian-B29983
> <Yuantian.Tang@freescale.com>
> Subject: [PATCH v3] ahci: qoriq: fixed using uninitialized variable warnings
> 
> From: Tang Yuantian <Yuantian.Tang@freescale.com>
> 
> kbuild test robot reports the warnings:
> drivers/ata/ahci_qoriq.c: In function 'ahci_qoriq_hardreset':
> >> include/asm-generic/io.h:163:2: warning: 'px_is' may be used
> >> uninitialized in this function [-Wuninitialized]
> drivers/ata/ahci_qoriq.c:70:14: note: 'px_is' was declared here
> >> include/asm-generic/io.h:163:2: warning: 'px_cmd' may be used
> >> uninitialized in this function [-Wuninitialized]
> drivers/ata/ahci_qoriq.c:70:6: note: 'px_cmd' was declared here
> 
> This is caused by openrisc arch's compiler. This driver is for QorIQ ARM
> platforms. So add the dependency on ARM to remove these warnings.
> 
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
> v3:
> 	- fix it by in a new way
> v2:
> 	- try another way to fix the warnings
> 	- remove clean up code
> 
>  drivers/ata/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig index 6aaa3f8..a830344
> 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -177,7 +177,7 @@ config AHCI_XGENE
> 
>  config AHCI_QORIQ
>  	tristate "Freescale QorIQ AHCI SATA support"
> -	depends on OF
> +	depends on OF && ARM
>  	help
>  	  This option enables support for the Freescale QorIQ AHCI SoC's
>  	  onboard AHCI SATA.
> --
> 2.1.0.27.g96db324

