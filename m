Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652469;
	b=PciYXN9TvQPEBpyXDddBwh0Bq1UDX1qDxS+6O9Elm+a76T80LdM1u/fSTrwmg8EpklcB
	 ijje9F1iL8CC2rFsBlKV7y330nCjw5nQbvIcIw61uiGvNfYSjKPQkpFhnUNC33BXVBHhK
	 3l8XCde/M47dT9Ju2OtZBH+SGrpDZ52AbmFfmgx+/dCtLe0J6sUBGfy14SncUKLRQvUJN
	 WDwVbx7+M7WqzMFvGggFPM0aH4odJJnWvFgrREE1l1Wqiy0n3aORd15VIx2ojvQDM47Vp
	 H+b1KLdDwnHVr+3BjMyo/AjWCqIg3ht8Gsr3mJblvXGZZHVMiSwgy0/lQ1bc+gVZ/Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652469;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=EXjmarcs8jPMRVcm820ceFNk9nolMb8Iitf1PYFVGXY=;
	b=tFWFw+gBqyHa4wp4moS+POGl+qHA7f/WW4I1ZFxH5sOC+xKZ4GCIQO/z4tdGVeTffYjz
	 JY9NC8T+vIpYEZaO0XqgdYKApq+hJjQ59ci6XT2sDt2m619M69i4UanRftJZtmASfXN+Z
	 M8jq9VHzabJbykDSPG3dbWWDCn8XCpYnNDHZZHV+0LQLuznoWkSKhMbWLwSQizWQfDwuD
	 Y+FL2Lqmxqkswu1QSrXlsJW9690sspuJJmwou+k20YyeP9C5RtjRuP5tPbVVGBJdSkKX7
	 qyX/0rhR8pnM2kMDW0oOOGjNtr49sWF4SKQQjADJIaBvPpT1lOdyD5l3m3v61ZXZw7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOpcw62D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E42C606A319;
	Thu, 22 Oct 2026 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOpcw62D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B6B1F000C1;
	Thu, 22 Oct 2026 07:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792652469;
	bh=EXjmarcs8jPMRVcm820ceFNk9nolMb8Iitf1PYFVGXY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WOpcw62DU8gibkhW2vEgsyGAsBB19FUq95K2E9GjjhBhLudBjKFLRWiR6sKZCqFiS
	 6KsnGELeDLc+J9alftd8tfiYUUlyEcre1sxQWoSGJSNacb4WRGUQNutS5En9/+Oi7q
	 78ZVVbFzTWEePVavInekIeQ60500OAZq4m8nxVdL4WIDb7lsq9gcG5ZOLn4HPm0eAo
	 9+k3Uy/RjnlSDtkGneF8USxti5DoxjKo8Hu+qI2UdEu/rlCwgHkG+txWDuaF/MoPz0
	 2JoIuJ12lRbW5aX0c6HjNt1ur3ieXKfsIW0MxE0Ni1m5Y9+69MXqGJ1pTdghqDc6b3
	 A7elOM6Ayc2sg==
Message-ID: <3f657b75-64c9-442b-a609-987cc16f5501@kernel.org>
Date: Thu, 22 Oct 2026 09:01:05 +0200
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ata: pata_artop: read the ATP865 mode register
 through pci_iomap
To: Daniel Palmer <daniel@0x0f.com>, ysato@users.sourceforge.jp,
 dalias@libc.org, glaubitz@physik.fu-berlin.de, cassel@kernel.org,
 linux-sh@vger.kernel.org, linux-ide@vger.kernel.org
Cc: geert@linux-m68k.org, linux-kernel@vger.kernel.org
References: <20261017041419.311921-1-daniel@0x0f.com>
 <20261017041419.311921-2-daniel@0x0f.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261017041419.311921-2-daniel@0x0f.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/17 6:14, Daniel Palmer wrote:
> artop_init_one() probes the 6280's "fast" bit with inb() on the raw
> start address of BAR 4.  That address is a PCI I/O address, which is
> only a usable port number on platforms whose I/O port base maps PCI I/O
> space one to one.  On an SH7751 LANDISK (identity io_port_base, PCI I/O
> window at 0xfe240000) the resource starts at 0x1400 and inb(0x1400)
> dereferences that address:
> 
>   BUG: unable to handle kernel paging request at 00001400
>   PC is at artop_init_one+0x10e/0x170
> 
> Map the BAR with pci_iomap() and use ioread8(), as libata-sff does for
> the BMDMA registers later on.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  drivers/ata/pata_artop.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
> index 9f8d41639a62..351ff4c8e48e 100644
> --- a/drivers/ata/pata_artop.c
> +++ b/drivers/ata/pata_artop.c
> @@ -405,13 +405,21 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
>  	case 1:		/* 6260 */
>  		ppi[0] = &info_626x;
>  		break;
> -	case 2:		/* 6280 or 6280 + fast */
> -		if (inb(pci_resource_start(pdev, 4)) & 0x10)
> +	case 2: {	/* 6280 or 6280 + fast */
> +		void __iomem *bmdma = pci_iomap(pdev, 4, 1);
> +		u8 cfg;
> +
> +		if (!bmdma)
> +			return -ENOMEM;
> +		cfg = ioread8(bmdma);
> +		pci_iounmap(pdev, bmdma);
> +		if (cfg & 0x10)
>  			ppi[0] = &info_628x_fast;
>  		else
>  			ppi[0] = &info_628x;
>  		break;
>  	}
> +	}

This is really ugly... Please move the "case 2" variable declarations to the top
of the function so that you do not have to do something like this.

Of note also is that this switch does not have a "default" case, which is really
bad practice, even though in this case, we should never hit unknown values.
But I would still prefer seeing something like:

	default:
		pr_warn("Invalid driver data\n");
		pci_disable_device(pdev);
		return -ENODEV;
	}

or a big hammer:

	default:
		BUG();
	}

>  
>  	BUG_ON(ppi[0] == NULL);
>  


-- 
Damien Le Moal
Western Digital Research
