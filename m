Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B613DA7D0;
	Thu, 15 Oct 2026 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051145; cv=none; b=d3F8YRssaQpFXkYspcj5zIWLSSsnL4zbY1OWphlnGCZuwxturzMrrQIFX+uAZ0o1aA7imk5xePBapQACKNWwBli2mq6FT+2V7tn1svkMFD+bj/jlzGI3Bb7m9nMdMfrQ5bmbkala/qF7Bp4aSqSYAoTRd3m2+S/nZARnSbl4Q8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051145; c=relaxed/simple;
	bh=N5QC1OUeVm3J7wz0Dtypj8r+bYbtGE8nOXGl6Jc7QU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYxen4xs3Um86k/FcSo9NwVp+i53CllghF2X1c33gZ/zYi91wIzg3v9BXkPghYvCv3SbslbH89GsRfewWCeDEYE6wHRNb1tVIboprZ49qwkRJ9j8Ts3r6B+69kHe1qofuhycOtOGYNbJkLO3UjH258FHXJnLOn4Spq2fsMixGQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kt0pjop6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kt0pjop6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694151F000C4;
	Thu, 15 Oct 2026 07:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792051144;
	bh=rXcu8XJqPxqe9r34T5V/+Jof28dpsSI6rtsrOItxgxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kt0pjop6YkJqKrpobS8C2OOYNIRsxrEDOBtpU6r6zJTXptNsv1/vDZf1ME4n/X0pY
	 BG9tKw+F5p6kvEcbG+eADn75BHiB+7L3H+s+zk6Iha5HCjijA9pkyJFKtNeizhBX3m
	 hKTJOlE6FNqrRxOwxXlAn57FxAQdF5JiYqFQ61PfM76Wigo7vrpf2ZZqVpwGfmHrxG
	 BcXPiw76+h3vAENGrffazTdbRJiOLijCWPIJFfihLjj8b0A0i7o9kTCQlzDrtOhhLL
	 95SdGFuJujWsW7EtgOVQQkEufFNNNJ0Pne2vy/fNUzeIYwJriCHbYCRW7aZNNW+Phg
	 2yjk4QDRCAl6Q==
Date: Thu, 15 Oct 2026 09:59:00 +0200
From: Niklas Cassel <cassel@kernel.org>
To: zhoumin <teczm@foxmail.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: ahci: preserve preset port masks
Message-ID: <atCHxGZDY4heAXwE@ryzen>
References: <tencent_E0E7052529B6851284963EB90DF4D28CBB06@qq.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E0E7052529B6851284963EB90DF4D28CBB06@qq.com>

On Thu, Oct 15, 2026 at 11:06:55AM +0800, zhoumin wrote:
> ahci_get_port_mask() returns zero for absent or unmatched parameters,
> overwriting the mask set by the Marvell PATA quirk.
> 
> Update the mask in place only when parsing a global value or a matching
> device entry. Preserve existing numeric parsing and override behavior.
> 
> Fixes: 70c1595c181c ("ata: ahci: Allow ignoring the external/hotplug capability of ports")
> Signed-off-by: zhoumin <teczm@foxmail.com>
> ---
>  drivers/ata/ahci.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 9b8c0935001c..324e4918a055 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1654,22 +1654,21 @@ static u32 ahci_port_mask(struct device *dev, char *mask_s)
>  	return mask;
>  }
>  
> -static u32 ahci_get_port_mask(struct device *dev, char *mask_p)
> +static void ahci_get_port_mask(struct device *dev, char *mask_p, u32 *mask)
>  {
>  	char *param, *end, *str, *mask_s;
>  	char *name;
> -	u32 mask = 0;
>  
>  	if (!mask_p || !strlen(mask_p))
> -		return 0;
> +		return;
>  
>  	str = kstrdup(mask_p, GFP_KERNEL);
>  	if (!str)
> -		return 0;
> +		return;
>  
>  	/* Handle single mask case */
>  	if (!strchr(str, '=')) {
> -		mask = ahci_port_mask(dev, str);
> +		*mask = ahci_port_mask(dev, str);
>  		goto free;
>  	}
>  
> @@ -1704,13 +1703,11 @@ static u32 ahci_get_port_mask(struct device *dev, char *mask_p)
>  			param++;
>  		}
>  
> -		mask = ahci_port_mask(dev, mask_s);
> +		*mask = ahci_port_mask(dev, mask_s);
>  	}
>  
>  free:
>  	kfree(str);
> -
> -	return mask;

Invalid values still wipe out the Marvell mask.
ahci_port_mask()  returns 0 when parsing fails, and the patch writes that
0 into the mask.

Before 70c1595c181c a bad value left the mask alone.

I suggest the following change on top of your patch:

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 324e4918a055..fdce365969b4 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1642,16 +1642,10 @@ MODULE_PARM_DESC(mask_port_ext,
 		 "where <pci_dev> is the PCI ID of an AHCI controller in the "
 		 "form \"domain:bus:dev.func\"");
 
-static u32 ahci_port_mask(struct device *dev, char *mask_s)
+static void ahci_port_mask(struct device *dev, char *mask_s, u32 *mask)
 {
-	unsigned int mask;
-
-	if (kstrtouint(mask_s, 0, &mask)) {
+	if (kstrtou32(mask_s, 0, mask))
 		dev_err(dev, "Invalid port map mask\n");
-		return 0;
-	}
-
-	return mask;
 }
 
 static void ahci_get_port_mask(struct device *dev, char *mask_p, u32 *mask)
@@ -1668,7 +1662,7 @@ static void ahci_get_port_mask(struct device *dev, char *mask_p, u32 *mask)
 
 	/* Handle single mask case */
 	if (!strchr(str, '=')) {
-		*mask = ahci_port_mask(dev, str);
+		ahci_port_mask(dev, str, mask);
 		goto free;
 	}
 
@@ -1703,7 +1697,7 @@ static void ahci_get_port_mask(struct device *dev, char *mask_p, u32 *mask)
 			param++;
 		}
 
-		*mask = ahci_port_mask(dev, mask_s);
+		ahci_port_mask(dev, mask_s, mask);
 	}
 
 free:







 This relies on  kstrtou32()  writing its result only on success.
 That is documented ("@res: Where to write the result of the conversion
 on success") and matches the code in  lib/kstrtox.c.
 So a bad value now just logs the error and leaves  the Marvell mask alone.
