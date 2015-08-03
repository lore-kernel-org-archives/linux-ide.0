From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] Check return code from pdc20621_i2c_read()
Date: Mon, 3 Aug 2015 18:40:00 +0300
Message-ID: <55BF8B50.2030808@cogentembedded.com>
References: <CAO-S75CRyh=FPbeTJMZWiYTvpd_wn57f4eGQgOHW2p16+9ANhQ@mail.gmail.com>
 <1438581994-23521-1-git-send-email-barletz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35268 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbbHCPkD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Aug 2015 11:40:03 -0400
Received: by lbbpo9 with SMTP id po9so6198497lbb.2
        for <linux-ide@vger.kernel.org>; Mon, 03 Aug 2015 08:40:02 -0700 (PDT)
In-Reply-To: <1438581994-23521-1-git-send-email-barletz@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomer Barletz <barletz@gmail.com>, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 08/03/2015 09:06 AM, Tomer Barletz wrote:

> The variable spd0 might be used uninitialized when pdc20621_i2c_read()
> fails.
> This also generates a compilation warning with gcc 5.1.

> Signed-off-by: Tomer Barletz <barletz@gmail.com>
> ---
>   drivers/ata/sata_sx4.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)

> diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
> index 3a18a8a..070b272 100644
> --- a/drivers/ata/sata_sx4.c
> +++ b/drivers/ata/sata_sx4.c
> @@ -1238,8 +1238,11 @@ static unsigned int pdc20621_prog_dimm_global(struct ata_host *host)
>   	readl(mmio + PDC_SDRAM_CONTROL);
>
>   	/* Turn on for ECC */
> -	pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
> -			  PDC_DIMM_SPD_TYPE, &spd0);
> +	if (!pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
> +	                       PDC_DIMM_SPD_TYPE, &spd0)) {
> +		printk(KERN_ERR "Failed in i2c read: device=%#x, subaddr=%#x\n", PDC_DIMM0_SPD_DEV_ADDRESS, PDC_DIMM_SPD_TYPE);
> +		return 1;
> +	}
>   	if (spd0 == 0x02) {
>   		data |= (0x01 << 16);
>   		writel(data, mmio + PDC_SDRAM_CONTROL);
> @@ -1380,8 +1383,11 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
>
>   	/* ECC initiliazation. */
>
> -	pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
> -			  PDC_DIMM_SPD_TYPE, &spd0);
> +	if (!pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
> +	                       PDC_DIMM_SPD_TYPE, &spd0)) {
> +		printk(KERN_ERR "Failed in i2c read: device=%#x, subaddr=%#x\n", PDC_DIMM0_SPD_DEV_ADDRESS, PDC_DIMM_SPD_TYPE);
> +		return 1;
> +	}
>   	if (spd0 == 0x02) {
>   		void *buf;
>   		VPRINTK("Start ECC initialization\n");

$ scripts/checkpatch.pl ~/patches/Check-return-code-from-pdc20621_i2c_read.patch
ERROR: code indent should use tabs where possible
#23: FILE: drivers/ata/sata_sx4.c:1242:
+^I                       PDC_DIMM_SPD_TYPE, &spd0)) {$

WARNING: line over 80 characters
#24: FILE: drivers/ata/sata_sx4.c:1243:
+		printk(KERN_ERR "Failed in i2c read: device=%#x, subaddr=%#x\n", 
PDC_DIMM0_SPD_DEV_ADDRESS, PDC_DIMM_SPD_TYPE);

WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then 
dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
#24: FILE: drivers/ata/sata_sx4.c:1243:
+		printk(KERN_ERR "Failed in i2c read: device=%#x, subaddr=%#x\n", 
PDC_DIMM0_SPD_DEV_ADDRESS, PDC_DIMM_SPD_TYPE);

ERROR: code indent should use tabs where possible
#37: FILE: drivers/ata/sata_sx4.c:1387:
+^I                       PDC_DIMM_SPD_TYPE, &spd0)) {$

WARNING: line over 80 characters
#38: FILE: drivers/ata/sata_sx4.c:1388:
+		printk(KERN_ERR "Failed in i2c read: device=%#x, subaddr=%#x\n", 
PDC_DIMM0_SPD_DEV_ADDRESS, PDC_DIMM_SPD_TYPE);

WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then 
dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
#38: FILE: drivers/ata/sata_sx4.c:1388:
+		printk(KERN_ERR "Failed in i2c read: device=%#x, subaddr=%#x\n", 
PDC_DIMM0_SPD_DEV_ADDRESS, PDC_DIMM_SPD_TYPE);

total: 2 errors, 4 warnings, 26 lines checked

NOTE: Whitespace errors detected.
       You may wish to use scripts/cleanpatch or scripts/cleanfile

/home/headless/patches/Check-return-code-from-pdc20621_i2c_read.patch has 
style problems, please review.

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.

MBR, Sergei

