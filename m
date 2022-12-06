Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E79CC4708C
	for <linux-ide@archiver.kernel.org>; Tue,  6 Dec 2022 03:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbiLFDOi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 5 Dec 2022 22:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiLFDOd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 5 Dec 2022 22:14:33 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE5525EA9
        for <linux-ide@vger.kernel.org>; Mon,  5 Dec 2022 19:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670296471; x=1701832471;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=d4ml79+yhNZpWQUaBZxdIHp0d7pz2eLLciI+YSwLg+4=;
  b=Rjx9I4IyMtGKfE+zqKV3ptzW2ciA/ViV/+84/2j0swz58RuTAaDdXQPz
   tSxgyRw5+k2e/pQBf2tz6G8UWcp4ns3MyBs1O80pAhXndK4zZOdhoqxdU
   oln7eYFNDW2txBeT16qOhAC1L4pFFH9ZBoey0M8G34Oinl/7+kTaIKUsQ
   5VwxjlVcPrJqWjALbZQvJXxoNHagdO1V9zOdGRrpXrnuQmYznj1C13cmf
   nVT1uA9Q47TrHF+W/ikyd9E/zjMxzSSoQ9snEq+Ub+DK+BUtO+3frAd+I
   G6s5nkn8uhPnlzIsqfSmiQT2LQdFCSNqfKUs90PXMsK25Lh+tIq+wazhE
   A==;
X-IronPort-AV: E=Sophos;i="5.96,220,1665417600"; 
   d="scan'208";a="217967348"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2022 11:14:30 +0800
IronPort-SDR: 8ekJWfGfThtJVxGasa6Tq1/jfL+RoerJ26oVYZ/x02LFNFwYQ8XgZJEx/nC8y0VvYayi44hcNX
 7dXqAztMJ4D2wpYIZX1Pc6xNhbHuN2G5NueKG0hCaZLi638P/XJVYdtG3IK5QcqFBKKCbT/aZ1
 rBtJwpJpMDNl7BnwxZ8ZdtnAkhDds5M5S6ye6Y5rDkRh3XvYlIx9TJBhqHIa5d46Tmkl3a5GDM
 rmt246j+SBw3L+kAGpEHEfHq2fs1v3yI0sZlBIyoBL2T0ysjZE20fyWWbSdpuhHzbPEGRgrC7o
 RDg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2022 18:33:02 -0800
IronPort-SDR: MTNGguS7eJbc/pQ3buEBgxo923W+1u7UED3erQXAFVeJdqRnAQZ/wy1cSxvlMENysxzVuPxQz6
 bwP9deen5pIVOmt1TQjVTMDoeg8SQJt4PaWnjJLHqNlZKBquzKviJr6I7hL7TR8AaxstbDxJ8x
 fp35r8vdyQiqsaNIT9hz1CuCjCn55z2yO5l/tH2PXfNWWBowPmxHGsIBgEXk0YEuSHGqRx0cEO
 DxvwKbCVondZnfL2pTORj3altUVOHgYEAzk+mnCCIyOQ2CL5VZIkPJ5TQlfRqQP3LIaU9I9vWU
 drw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2022 19:14:30 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NR59y2qFxz1RvTp
        for <linux-ide@vger.kernel.org>; Mon,  5 Dec 2022 19:14:30 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670296469; x=1672888470; bh=d4ml79+yhNZpWQUaBZxdIHp0d7pz2eLLciI
        +YSwLg+4=; b=fRBhMVpeU8iq3c/0WQo3Qatr36SkRdAst6iJspac8bTP+Q7T+s1
        SmjtD8UrILOSlhEFPGFwjoRsCPTB2ajvcozAkWcBbxjEaGX4Dfc56COgyagu3qWv
        jJqZ9eNSjqwIkypEAinIlBYwzT3sbOH0a2EDaTvsRNSnFp8EwOt9X+ddn4yAEFbs
        ta/c+HZ9bzy1uYmbAxCpMNA5RgkOJJgcqsZcafnm+i43TEXeIL7QU5MnvdvqlOFz
        yfVlxYuay5yPT/trNRwNicov9LzUpM2kp/HmKOrUqobcTLq8hk43Q7gvxrsF+Tr8
        TPvlXxhjx5cTWFDH71X9HTYC3boU+IBvIxw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id P4apR9Dzd2MO for <linux-ide@vger.kernel.org>;
        Mon,  5 Dec 2022 19:14:29 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NR59x2Hrzz1RvLy;
        Mon,  5 Dec 2022 19:14:29 -0800 (PST)
Message-ID: <16be2a8e-2091-1869-153e-5b1356ca4f93@opensource.wdc.com>
Date:   Tue, 6 Dec 2022 12:14:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] libata/ahci: Fix PCS quirk application for suspend
Content-Language: en-US
To:     grozzly <grozzly@protonmail.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <fLroqLOFhUGt2lB-B8_AtSA_DAiSquwKdghmGqsgLPJUZy3dz9DN81T2CE9aOJs2h9f0ZQrWvEmz5W7Xu3XE4ESlwCXNVfJoqnhc637ObGs=@protonmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <fLroqLOFhUGt2lB-B8_AtSA_DAiSquwKdghmGqsgLPJUZy3dz9DN81T2CE9aOJs2h9f0ZQrWvEmz5W7Xu3XE4ESlwCXNVfJoqnhc637ObGs=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/6/22 07:11, grozzly wrote:
> There is a bug introduced in c312ef176399 "libata/ahci: Drop PCS quirk for 
> Denverton and beyond": the quirk is not applied on wake from suspend as it 
> originally was. Because of that my laptop (ICH8M controller) doesnt see 
> KINGSTON SV300S37A60G SSD disk connected into a SATA connector on wake 
> since kernel 5.3.4 or better to say 5.3.8 because there was another error 
> in c312ef176399 until a fix arrived in 09d6ac8dc51a "libata/ahci: Fix PCS 
> quirk application". Btw 4.19.y lts branch is affected as well.
> 
> The problem somewhy doesnt trigger on another disk though (WD5000LPCX HDD). 

s/somewhy/somehow ?
s/doesnt/does not

> I discovered it upgrading the laptop with the SSD in place of a HDD with 
> some 5.4 kernel.
> 
> Here is my hardware:
> - Acer 5920G with ICH8M SATA controller
> - sda: some SATA HDD connnected into the DVD drive IDE port with a SATA-IDE 
> caddy. It is a boot disk to test kernels
> - sdb: KINGSTON SV300S37A60G SSD connected into the only SATA port
> 
> Booting into vanilla 5.3.8 and beyond (built from upstream sources with 
> configs extracted from https://kernel.ubuntu.com/~kernel-ppa/mainline/) I 
> see both disks in lsblk. After wake from suspend the SSD is gone from lsblk 
> output.
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
> sd 2:0:0:0: [sdb] Start/Stop Unit failed: Result: hostbyte=DID_NO_CONNECT 
> driverbyte=DRIVER_OK
> sd 2:0:0:0: [sdb] Synchronizing SCSI cache
> sd 2:0:0:0: [sdb] Synchronize Cache(10) failed: Result: 
> hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
> sd 2:0:0:0: [sdb] Stopping disk
> sd 2:0:0:0: [sdb] Start/Stop Unit failed: Result: hostbyte=DID_BAD_TARGET 
> driverbyte=DRIVER_OK
> 
> The patch is tested on 6.0.10, it solves the problem for my hardware.

Please address the patches to me directly in addition to the linux-ide
list (see scripts/check_maintainer.pl).

This needs to be tested with the latest 6.1-rc7 kernel. If you do so, you
can remove this last phrase in the commit message as it will be implied.

And this patch I think needs a "Fixes" tag:

Fixes: c312ef176399 ("libata/ahci: Drop PCS quirk for Denverton and beyond")

But you are also referencing 09d6ac8dc51a "libata/ahci: Fix PCS
quirk application" above, but the text is not super clear regarding the
patch that triggers the issue. Please clarify the text and add the Fixes
tag referencing the patch that introduces the issue.

Overall, the commit message describes the problem, but does not say HOW
you adrees and fix it. Please add a few lines describing the solution.

The patch applies but its format is weird: It is missing the "---"
separator here. How did you generate it ? Did you use "git format-patch" ?

> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index c1eca72b4575..28d8c56cb4dd 100644
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
> @@ -1788,12 +1808,6 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
> @@ -1903,7 +1917,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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

