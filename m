Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A5EC4321E
	for <linux-ide@archiver.kernel.org>; Mon,  5 Dec 2022 13:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiLENm7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 5 Dec 2022 08:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiLENmn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 5 Dec 2022 08:42:43 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01381E60
        for <linux-ide@vger.kernel.org>; Mon,  5 Dec 2022 05:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670247761; x=1701783761;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=mBei9Ntt6sLf2a5tJ2YcxB89mK4yTe0E6xYSXCxPh7w=;
  b=rglFLxbg725LJBOXu3BRdnIYeypNOe9C46qkWe7V7D0MgzspOQWUdbO7
   HmnfikstM69WcYXk9q+6BxoTCzDGVtcAbJHRlav4Axl5SToZdQQq5PAbX
   281UYfAtiWo12kgwIk/QWOBBTMQPwe8pqQYdCjLVqhuNHjDBvC6BFCAWH
   zcoWeMp7L9kRrOhoD1yt1q6jICBdpn2u4dxMkrsLGrSt2kly8Bd72OoUe
   YyHADyG3CmbyFtD0iq91mtAghRwxGdlYEM7UiwKAD2mDOwRMfwgYTkuII
   6zt27m+2YYpkAH7GifN/Y9I2X0sao5135unk7aFAOI77QEWi5vqhIJkVu
   w==;
X-IronPort-AV: E=Sophos;i="5.96,219,1665417600"; 
   d="scan'208";a="223074708"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2022 21:42:41 +0800
IronPort-SDR: 97X58EazB1iVzrkCChqy0h+hEMtpLV+bmYLv8DHbEZj+T/KMww6iMboutGZkOBTrlCcjoaRkAu
 BL5SI8Pk9Y8IIytKpw/S9Z/qNi8MA3H9d4WxAp29bZknUxR/DdeTls4sOSfj9wffvsAakLYBge
 R3TqCwNiFygCsPddPB6TT2zpj7CBZ9XuCdlgIbvXoFdgxF8/t0yds5vPWtHmz2tD0+ADK/UVje
 om+KgZiqvFxAIxWf74O7nYAuir2xgNeP+xm3Ebf1jbpSuQ1Ih6mFLXJnxicJBZatYleJ2x+GCm
 bIs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2022 05:01:14 -0800
IronPort-SDR: Uz2SPw0bZk8lKSBUEsNhEUT70jbx2bLNFzx4l+zj7uJsOcgxpmkqTlbWQ4V806iCNIs0y2nLUU
 9t1p/rkQ6nFrbtOUrZU2mNvpqPafiIti+3/yRZVC0OoUXg/wKBgViFtvF9b3iAQ3Ss/anSq+Yn
 GkVch5Mm2nIl3J830/ivssKURTIVT0aNe4Q5V3938M4HZMlGVfiNmfbD7Wh/zdQOp89xFWjDto
 N0ArIfs7jWGMtgyXMw0ZxuHrOG89+CuWTp6CyB5FHeFshA98Cz0iEicxI4KVnutW9c0mqqsLtx
 USY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2022 05:42:41 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NQl9F0sqHz1RvTr
        for <linux-ide@vger.kernel.org>; Mon,  5 Dec 2022 05:42:41 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670247760; x=1672839761; bh=mBei9Ntt6sLf2a5tJ2YcxB89mK4yTe0E6xY
        SXCxPh7w=; b=aDl+fbU2wYf8T14uilabjjdIFPORu6IgZpKjI7PPbGAsVWLdUZ9
        DyVHegcZuu/lCqpr3tFBuzikQSIKlNgNj9i2jzmLsQLUC+UWrhRNRCMOdGNyJgxI
        C7GCmaxhRIabHjzUxnWkJprP3u5OBQoHq16GvmZp6cHkn2xL60deiXLpdvdtsvJ/
        P+yGFVEiQv7bQGOQyiQw9nc/eKmsmFDnhlWkIhlsBVl+zjJO2x5U8iaBvvZp6wcn
        QuFyYizmgejpVcsF4wuQmXV0BBjyBHqsDc+S3SX2J5RVJzYo5V/fTKH6edl9yUBx
        6Ri5dsH0LeqRs+AvFIlt/bTTmY+z9jpOp9Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1Lr-49CMLWNo for <linux-ide@vger.kernel.org>;
        Mon,  5 Dec 2022 05:42:40 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NQl9D0JYkz1RvLy;
        Mon,  5 Dec 2022 05:42:39 -0800 (PST)
Message-ID: <6f0876de-0621-9410-4c1f-6c5172bfa8f9@opensource.wdc.com>
Date:   Mon, 5 Dec 2022 22:42:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] libata/ahci: Fix PCS quirk application for suspend
Content-Language: en-US
To:     grozzly <grozzly@protonmail.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <GDLzJIZ_OPwuAzIjUg0sSe2tVHaJJvuAvlIv056rty6JTo-noLGRiVuY7YIEb0u-4w0kIZQvP2EwQuoKGwafcglUiXUQCkf6ufsZuv3IjgQ=@protonmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <GDLzJIZ_OPwuAzIjUg0sSe2tVHaJJvuAvlIv056rty6JTo-noLGRiVuY7YIEb0u-4w0kIZQvP2EwQuoKGwafcglUiXUQCkf6ufsZuv3IjgQ=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/2/22 07:49, grozzly wrote:
> There is a bug introduced in c312ef176399 "libata/ahci: Drop PCS quirk for Denverton and beyond": the quirk is not applied on wake from suspend as it originally was. Because of that my laptop (ICH8M controller) doesnt see KINGSTON SV300S37A60G SSD disk connected into a SATA connector on wake since kernel 5.3.4 or better to say 5.3.8 because there was another error in c312ef176399 until a fix arrived in 09d6ac8dc51a "libata/ahci: Fix PCS quirk application". Btw 4.19.y lts branch is affected as well.

Please correctly format your emails (wrap lines at under 80 chars)

> 
> The problem somewhy doesnt trigger on another disk though (WD5000LPCX HDD). I discovered it upgrading the laptop with the SSD in place of a HDD with some 5.4 kernel.
> 
> Here is my hardware:
> - Acer 5920G with ICH8M SATA controller
> - sda: some SATA HDD connnected into the DVD drive IDE port with a SATA-IDE caddy. It is a boot disk to test kernels
> - sdb: KINGSTON SV300S37A60G SSD connected into the only SATA port
> 
> Booting into vanilla 5.3.8 and beyond (built from upstream sources with configs extracted from https://kernel.ubuntu.com/~kernel-ppa/mainline/) I see both disks in lsblk. After wake from suspend the SSD is gone from lsblk output.
> 
> Here is sample "dmesg --notime | grep -E '^(sd |ata)'" output on wake:
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
> sd 2:0:0:0: [sdb] Start/Stop Unit failed: Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
> sd 2:0:0:0: [sdb] Synchronizing SCSI cache
> sd 2:0:0:0: [sdb] Synchronize Cache(10) failed: Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
> sd 2:0:0:0: [sdb] Stopping disk
> sd 2:0:0:0: [sdb] Start/Stop Unit failed: Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
> 
> The patch is tested on 6.0.10, it solves the problem for my hardware. Compared to c312ef176399, I miraculously revived ahci_pci_reset_controller() and intergrated internals of ahci_intel_pcs_quirk() into it.
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index c1eca72b4575..2f2c8176808c 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -677,6 +677,43 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>  	ahci_save_initial_config(&pdev->dev, hpriv);
>  }
>  
> +static int ahci_pci_reset_controller(struct ata_host *host)
> +{
> +	struct pci_dev *pdev = to_pci_dev(host->dev);
> +	const struct pci_device_id *id = pci_match_id(ahci_pci_tbl, pdev);
> +	int rc;
> +
> +	rc = ahci_reset_controller(host);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Only apply the 6-port PCS quirk for known legacy platforms.
> +	 * Skip applying the quirk on Denverton and beyond
> +	 */
> +	if (id && id->vendor == PCI_VENDOR_ID_INTEL &&
> +			((enum board_ids) id->driver_data) < board_ahci_pcs7) {
> +		struct ahci_host_priv *hpriv = host->private_data;
> +		u16 tmp16;
> +
> +		/*
> +		 * port_map is determined from PORTS_IMPL PCI register which is
> +		 * implemented as write or write-once register.  If the register
> +		 * isn't programmed, ahci automatically generates it from number
> +		 * of ports, which is good enough for PCS programming. It is
> +		 * otherwise expected that platform firmware enables the ports
> +		 * before the OS boots.
> +		 */
> +		pci_read_config_word(pdev, PCS_6, &tmp16);
> +		if ((tmp16 & hpriv->port_map) != hpriv->port_map) {
> +			tmp16 |= hpriv->port_map;
> +			pci_write_config_word(pdev, PCS_6, tmp16);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static void ahci_pci_init_controller(struct ata_host *host)
>  {
>  	struct ahci_host_priv *hpriv = host->private_data;
> @@ -871,7 +908,7 @@ static int ahci_pci_device_runtime_resume(struct device *dev)
>  	struct ata_host *host = pci_get_drvdata(pdev);
>  	int rc;
>  
> -	rc = ahci_reset_controller(host);
> +	rc = ahci_pci_reset_controller(host);
>  	if (rc)
>  		return rc;
>  	ahci_pci_init_controller(host);
> @@ -907,7 +944,7 @@ static int ahci_pci_device_resume(struct device *dev)
>  		ahci_mcp89_apple_enable(pdev);
>  
>  	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
> -		rc = ahci_reset_controller(host);
> +		rc = ahci_pci_reset_controller(host);
>  		if (rc)
>  			return rc;
>  
> @@ -1624,36 +1661,6 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap,
>  		ap->target_lpm_policy = policy;
>  }
>  
> -static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_priv *hpriv)

Why remove this function ? Calling it after ahci_reset_controller() in
ahci_pci_reset_controller() would be a lot cleaner and less changes for
the same result. It is always better to try to keep "quirk" code separate
from the regular generic code.

Can you send a proper patch for this ?

> -{
> -	const struct pci_device_id *id = pci_match_id(ahci_pci_tbl, pdev);
> -	u16 tmp16;
> -
> -	/*
> -	 * Only apply the 6-port PCS quirk for known legacy platforms.
> -	 */
> -	if (!id || id->vendor != PCI_VENDOR_ID_INTEL)
> -		return;
> -
> -	/* Skip applying the quirk on Denverton and beyond */
> -	if (((enum board_ids) id->driver_data) >= board_ahci_pcs7)
> -		return;
> -
> -	/*
> -	 * port_map is determined from PORTS_IMPL PCI register which is
> -	 * implemented as write or write-once register.  If the register
> -	 * isn't programmed, ahci automatically generates it from number
> -	 * of ports, which is good enough for PCS programming. It is
> -	 * otherwise expected that platform firmware enables the ports
> -	 * before the OS boots.
> -	 */
> -	pci_read_config_word(pdev, PCS_6, &tmp16);
> -	if ((tmp16 & hpriv->port_map) != hpriv->port_map) {
> -		tmp16 |= hpriv->port_map;
> -		pci_write_config_word(pdev, PCS_6, tmp16);
> -	}
> -}
> -
>  static ssize_t remapped_nvme_show(struct device *dev,
>  				  struct device_attribute *attr,
>  				  char *buf)
> @@ -1788,12 +1795,6 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
> @@ -1903,7 +1904,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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

