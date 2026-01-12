Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BABA2DC763
	for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2026 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230321; cv=none; b=rU//V9K5GEWZKUTprUimhaOOjDtocAvKXYhvdYCAq7Y81OeKYhzMkSX3Mo2ophUuCNKfVo7BX3LJB8WSQI4IgYhnRrIA6K4gXxo1+J+UHIBKDuMu3lI6e+G4gRCvhAD3hwTumR0J0sy5HGMMF9S++4omOHErhTKUjGbF9ArBdvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230321; c=relaxed/simple;
	bh=6jBWdXZMhVkY69moXdQdlKCk8neTBul/f1U1dX6QdcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVDrAzn8A9GS+4qru9/KueN7Qv8U14PRI2+ucGPn7j0BaxRUNtdkCsD1NsuD18ExslubaSweNwljBdGXd1ffyKL32bFt/AlXYddvmkxwbTB5xG+gzCEKTldCxJ+9Hj/u3H8zVAcFmEGvPDl1Hxdne8HdUZ+Uh3eazS9jwb8DGbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=si0QLla2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="si0QLla2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AE4C16AAE;
	Mon, 12 Jan 2026 15:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768230321;
	bh=6jBWdXZMhVkY69moXdQdlKCk8neTBul/f1U1dX6QdcY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=si0QLla2TbfkKpncQ2x1ma4Ue8rahnpJtCYaQBXxw96sOOwFCFzvzESI7RuhAZ6L1
	 0xCNlRNiZS4XVCqjFLxi1nxfPsys+1jDhr6yZY95Ah15o3/uAE/dpcNwSoAlGWPgoY
	 nEEZMjh0JT/Kzs0I7Sm3zsR2+9pJx+Cw21TZKh+QpDGnMImJNOOkkJXm2ays3DSjWo
	 lQIxB9WdKLZEQ01bAAi6n8/lv8INnr6D+um3D5SQVrUaRJ4aQx1zpKf0rrqCwg12Vr
	 2+JkNUV580ZujU+jdlEOWpbiIXrVEGpf/yxl00j5+DZ7P49am8kT/HzdBjj5KqhVMx
	 4kW648Avbeh8g==
Message-ID: <698e738b-5ad2-4c03-ad5c-837123872a10@kernel.org>
Date: Mon, 12 Jan 2026 16:05:18 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] ata: libata-sata: Improve
 link_power_management_supported sysfs attribute
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, wolf@yoxt.cc
References: <20260112122044.143637-8-cassel@kernel.org>
 <20260112122044.143637-11-cassel@kernel.org>
 <5b945fcf-059d-409c-9475-630483c14a5e@kernel.org> <aWUHvdhs8oIFVgvp@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aWUHvdhs8oIFVgvp@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/26 15:39, Niklas Cassel wrote:
> I'm not sure if we should set sysfs attribute
> link_power_management_supported == false if ATA_LFLAG_NO_LPM is set
> (Currently we don't). Because if so, the sysfs supported attribute could
> potentially change value during runtime, isn't it supposed to be static?
> 
> If we really want to, I guess we could do something like:
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 04e1e774645e..1134943f49ae 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -913,6 +913,8 @@ static bool ata_scsi_lpm_supported(struct ata_port *ap)
>  		return false;
>  
>  	ata_for_each_link(link, ap, EDGE) {
> +		if (link->flags & ATA_LFLAG_NO_LPM)
> +			return false;

Yeah, I think we need this. NO_LPM == max power, but cannot be changed. That's
the same as for external ports. So we should report not supported so that
userspace cannot change it.

>  		ata_for_each_dev(dev, &ap->link, ENABLED) {
>  			if (dev->quirks & ATA_QUIRK_NOLPM)
>  				return false;
> 
> 
> But if so, that should probably be a different patch.
> 
> This patch was mainly to stop lying to the user that dummy ports could
> change/set lpm_policy.
> 
> 
> For the record, not all libata drivers provide a .set_lpm() callback.
> 
> Right now, the only drivers providing it are:
> ata_piix.c:     .set_lpm                = piix_sidpr_set_lpm,
> libahci.c:      .set_lpm                = ahci_set_lpm,
> 
> 
> Kind regards,
> Niklas


-- 
Damien Le Moal
Western Digital Research
