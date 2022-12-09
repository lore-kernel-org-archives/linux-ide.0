Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A9EC4332F
	for <linux-ide@archiver.kernel.org>; Fri,  9 Dec 2022 02:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiLICPE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 8 Dec 2022 21:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLICPD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 8 Dec 2022 21:15:03 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D585C755
        for <linux-ide@vger.kernel.org>; Thu,  8 Dec 2022 18:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670552101; x=1702088101;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=i4L/kET/ToCez7Tl55woa4bnQI01PtqrU2m/f3PoqKo=;
  b=eBEUFq2kVgFj2N0Ndk/tFCuFVluE8IJ2UGajWdajb4ZYwMTbJ3ncynqE
   LON1THZcU40Mz6jzmjpaxhTSua86vg/LBw+QH2kscmgpbAQjqfQGOfNyx
   ZHQ2M6yswBvC9MPdNjMqn28x1vRrnJ9o/0xaFhT0uGEbae/QqscW0HzTt
   k39+GFAxP0hdxp0OxGAaP8WiWIyQqz+bokU1nu5XDBX6l8Lc+YOEGZYw7
   jX3j+M/x8VMhb5rXYpeIWTAqtUNfFSF7lP/j8ParRIx77XMLVHJm9+dXp
   qhbMGExof8ScMyvbs4EDEnYsm28Yj4okWJ0jTJNdiUSoontg9YthNclVs
   g==;
X-IronPort-AV: E=Sophos;i="5.96,228,1665417600"; 
   d="scan'208";a="322603455"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2022 10:15:00 +0800
IronPort-SDR: CrJ9BTivwfvLuuWC1khbrl6yvF8IzYZyTkRHxvJAGsAadOv6xM/tx3E/jQ4AWy4E6DTY8VvIb6
 vyLquGgG+KdqsbYfV68ocwkTFIbt1d7zxs2CZd59n7hjoHb7sV2GhHwAPYNZ3PwTqXMvro+UJJ
 VHKDOzP2Tin1W6aCx8aQP+ngOa8aVYdEW5O5meU/Lpm/GQQ+op+7PMhWczOHIPcDgjAMA94Eac
 c5uW7lLLg5/yx/x0twRikivSvw7yy2A2YTKzrSI3DWYgmG1R4tTCR2yo5dEw6D4EghRpWdjTJT
 qWM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 17:27:45 -0800
IronPort-SDR: rgCmdsXLI+b87EmRDPMEqD78wDm2wcSTvISkgYP+vPE2/9O7ibsCW3TGrk7KwKnPmtI6Z/qRWn
 0qy0Twz0x/RYU3A/BFMDJRjYa86RaoIFYJzQdnrFbsnHW5yhMUyFzZniiVs59EKkzbCFztvKkz
 5lg4LwA0XxtfL8Q/tyDGDgeFBzRsv/LpCbjVCwk8BmBWGaCeyhbz1QNWlHZgXPmb+UC9UZaW76
 0GVxh7a+XoBOw7YlkMDN9wuUW9ByyDpexYO4JF0fBhWk+GcSPGwTm8adOGKa0AqRsIi3dgO9s1
 kjc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 18:09:00 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NSvb03l6cz1RvTp
        for <linux-ide@vger.kernel.org>; Thu,  8 Dec 2022 18:09:00 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670551740; x=1673143741; bh=i4L/kET/ToCez7Tl55woa4bnQI01PtqrU2m
        /f3PoqKo=; b=ojq554Phw1oxQ+dDlT5r/XQO/BvsHlT8pSu0V9dOpRO061+8SEn
        zUtw/DL7jWT7tWEUHbpKYr9s1QjL2tx/j40pdm6JCVGW/Tj69dkTpMQKCOe99wPX
        VNCm4vljm2JQMJdGSTk408j1ggFAErz018K8fBpJUbvnk9rQnkkOPJx00JV/fnsu
        Z1BUouptsSlpX8tySh7Xh14DpJkCdhNZZPJmoVYb98DEPFo5c7p+mxmiw+aJGena
        JKxeqZRLOncpWjFgTcYaxfxy0JFSxzGm4MKt6pDOnlETBNN2aAdr+QVYWK0MCAT1
        gMEYs9/APP+IB8h0O7RG/a5iCFLkumZBY5g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id i8BbFZ6B12rs for <linux-ide@vger.kernel.org>;
        Thu,  8 Dec 2022 18:09:00 -0800 (PST)
Received: from [10.225.163.85] (unknown [10.225.163.85])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NSvZz4Zxfz1RvLy;
        Thu,  8 Dec 2022 18:08:59 -0800 (PST)
Message-ID: <805d0cb5-a110-3fce-9c47-f94896f5f8a9@opensource.wdc.com>
Date:   Fri, 9 Dec 2022 11:08:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] libata/ahci: Fix PCS quirk application for suspend
Content-Language: en-US
To:     Adam Tukaj <grozzly@protonmail.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <OM8HSmyIGyT2XF-f70AR7JA5kLpuIYEu5mYEIpyUT-4CC-u7ezc6po32ZIGOSN_7PlsF0RhOvUs8HpVJiAHGrh2ytgiBEltBpz0MuKiy-vg=@protonmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <OM8HSmyIGyT2XF-f70AR7JA5kLpuIYEu5mYEIpyUT-4CC-u7ezc6po32ZIGOSN_7PlsF0RhOvUs8HpVJiAHGrh2ytgiBEltBpz0MuKiy-vg=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/9/22 00:25, Adam Tukaj wrote:
> Since kernel 5.3.4 my laptop (ICH8M controller) does not see Kingston
> SV300S37A60G SSD disk connected into a SATA connector on wake from suspend.
> The problem was introduced in c312ef176399 "libata/ahci: Drop PCS quirk for
> Denverton and beyond": the quirk is not applied on wake from suspend as it
> originally was.
> 
> It is worth to mention the commit contained another bug: the quirk is not
> applied at all to controllers which require it. The fix 09d6ac8dc51a
> "libata/ahci: Fix PCS quirk application" landed in 5.3.8. So testing my
> patch anywhere between c312ef176399 and 09d6ac8dc51a is pointless.
> 
> Not all disks trigger the problem. For example nothing bad happens with
> Western Digital WD5000LPCX HDD.
> 
> Test hardware:
> - Acer 5920G with ICH8M SATA controller
> - sda: some SATA HDD connnected into the DVD drive IDE port with a SATA-IDE
> caddy. It is a boot disk
> - sdb: Kingston SV300S37A60G SSD connected into the only SATA port
> 
> Sample "dmesg --notime | grep -E '^(sd |ata)'" output on wake:
> 
> sd 0:0:0:0: [sda] Starting disk
> sd 2:0:0:0: [sdb] Starting disk
> ata4: SATA link down (SStatus 4 SControl 300)
> ata3: SATA link down (SStatus 4 SControl 300)
> ata1.00: ACPI cmd ef/03:0c:00:00:00:a0 (SET FEATURES) filtered out
> ata1.00: ACPI cmd ef/03:42:00:00:00:a0 (SET FEATURES) filtered out
> ata1: FORCE: cable set to 80c
> ata5: SATA link down (SStatus 0 SControl 300)
> ata3: SATA link down (SStatus 4 SControl 300)
> ata3: SATA link down (SStatus 4 SControl 300)
> ata3.00: disabled
> sd 2:0:0:0: rejecting I/O to offline device
> ata3.00: detaching (SCSI 2:0:0:0)
> sd 2:0:0:0: [sdb] Start/Stop Unit failed: Result: hostbyte=DID_NO_CONNECT
> 	driverbyte=DRIVER_OK
> sd 2:0:0:0: [sdb] Synchronizing SCSI cache
> sd 2:0:0:0: [sdb] Synchronize Cache(10) failed: Result:
> 	hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
> sd 2:0:0:0: [sdb] Stopping disk
> sd 2:0:0:0: [sdb] Start/Stop Unit failed: Result: hostbyte=DID_BAD_TARGET
> 	driverbyte=DRIVER_OK
> 
> c312ef176399 dropped ahci_pci_reset_controller() which internally calls
> ahci_reset_controller() and applies the PCS quirk if needed after that. It
> was called each time a reset was required instead of just
> ahci_reset_controller(). This patch puts the function back in place.
> 
> Fixes: c312ef176399 ("libata/ahci: Drop PCS quirk for Denverton and beyond")
> Signed-off-by: Adam Vodopjan <grozzly@protonmail.com>

Patch author name and signed-off-by name do not match. Please fix that.
(use scripts/checkpatch.pl to check your patch)

Also please change the patch title to:

ata: ahci: Fix PCS quirk application for suspend

> ---
>  drivers/ata/ahci.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 639de2d75d63..53ab2306da00 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -84,6 +84,7 @@ enum board_ids {
>  static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
>  static void ahci_remove_one(struct pci_dev *dev);
>  static void ahci_shutdown_one(struct pci_dev *dev);
> +static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_priv *hpriv);
>  static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
>  				 unsigned long deadline);
>  static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
> @@ -677,6 +678,25 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>  	ahci_save_initial_config(&pdev->dev, hpriv);
>  }
>  
> +static int ahci_pci_reset_controller(struct ata_host *host)
> +{
> +	struct pci_dev *pdev = to_pci_dev(host->dev);
> +	struct ahci_host_priv *hpriv = host->private_data;
> +	int rc;
> +
> +	rc = ahci_reset_controller(host);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * If platform firmware failed to enable ports, try to enable
> +	 * them here.
> +	 */
> +	ahci_intel_pcs_quirk(pdev, hpriv);
> +
> +	return 0;
> +}
> +
>  static void ahci_pci_init_controller(struct ata_host *host)
>  {
>  	struct ahci_host_priv *hpriv = host->private_data;
> @@ -871,7 +891,7 @@ static int ahci_pci_device_runtime_resume(struct device *dev)
>  	struct ata_host *host = pci_get_drvdata(pdev);
>  	int rc;
>  
> -	rc = ahci_reset_controller(host);
> +	rc = ahci_pci_reset_controller(host);
>  	if (rc)
>  		return rc;
>  	ahci_pci_init_controller(host);
> @@ -907,7 +927,7 @@ static int ahci_pci_device_resume(struct device *dev)
>  		ahci_mcp89_apple_enable(pdev);
>  
>  	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
> -		rc = ahci_reset_controller(host);
> +		rc = ahci_pci_reset_controller(host);
>  		if (rc)
>  			return rc;
>  
> @@ -1785,12 +1805,6 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	/* save initial config */
>  	ahci_pci_save_initial_config(pdev, hpriv);
>  
> -	/*
> -	 * If platform firmware failed to enable ports, try to enable
> -	 * them here.
> -	 */
> -	ahci_intel_pcs_quirk(pdev, hpriv);
> -
>  	/* prepare host */
>  	if (hpriv->cap & HOST_CAP_NCQ) {
>  		pi.flags |= ATA_FLAG_NCQ;
> @@ -1900,7 +1914,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (rc)
>  		return rc;
>  
> -	rc = ahci_reset_controller(host);
> +	rc = ahci_pci_reset_controller(host);
>  	if (rc)
>  		return rc;
>  

-- 
Damien Le Moal
Western Digital Research

