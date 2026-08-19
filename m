Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33113429025
	for <linux-ide@vger.kernel.org>; Wed, 19 Aug 2026 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787146831; cv=none; b=uhvXe8TrXH2UdgqUlI4be4Ske82Du3RYW5PtmaL2IEk9UmwMQU1cYN2cZNBgeKlv3EwajnxdIshSjm/+XdLFhzNSOcBjKy3c+yyT651D0pH+bXdoEg4F6sukom/2LyLFWcfY+jK7UBT3HjE3bH2J6EpwMXGnfLdyhAV7rgO754E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787146831; c=relaxed/simple;
	bh=snQKLeLT75NhxJLM/cLRR/hycpX5EWBrYmLePIUVu5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVQbw5KUw/S1eydM7eOD+nY6c1j4o0ly8fBMI1h5A89p+xJSB8CZMyQ+VjTjUMI1fTfooKW4ZFmLhlsISVY4U66pCaKLI0DBnmSBoYVUBmA8o9/rXDmf3CgaKoDXJzOEM8keAt9ark4Au97BbvITQ8zNEXfZZ+lOQdQQjRLyOew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APCx5B1T; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APCx5B1T"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so10330595e9.2
        for <linux-ide@vger.kernel.org>; Wed, 19 Aug 2026 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787146826; x=1787751626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iNZrccnluIvzYumgzhKOaTGx9wbNf2yl74yeV2pPSb8=;
        b=APCx5B1TbUG6WCrSvg37Ca6FFFmW/b+/Pxnh584g2VpENy7j8ZYVcREarQ45NtFJM8
         rgF9x9+7KS1gQqKC1WqTOv/rqOBHSpSxMvhkpeAHEL3LYl4nTUK7ARuyvP0lX4SaojRH
         C8IKUlU3YM2CsVO2uy2AC2Q9rK7MDGevNqOFop70FShrBg/YElyar/L4KWrBjTRY7Ywt
         3OvHkhyqO6BmZH89OJe5a+PfrU7r7Wtlum77GFockR8saZ7tuBjhlZ4lh6FrbDgo8/Xy
         IWo9F3gedm4WlVJZbqwpsDhm1NU3psrod27EPbgkaBvDk4AwCH9iGdZbe1FEO4WQR5qN
         DJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787146826; x=1787751626;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iNZrccnluIvzYumgzhKOaTGx9wbNf2yl74yeV2pPSb8=;
        b=XMIZGD04NKhRC5aQg05hCT5igPSfHaV6bfFry/cnXtQba2weyc6wdlMMsBaMmgLOXN
         0HLkgymTzbhbKHaWlFcIsWCV/k2B2eNsx2zX4ibxAliochwgUgvC7tR2Z4yEomG6oV5X
         msV8SiCUlUGXwJSu+cAfLLsIoIW3sVqx9mp3Uk1xiMFqZOTThnQ1R6zKamIDjv0m16vE
         1ZFBkeftHkbgXRU+v35U8qi33Xe/S9eabx6pKNKcQlREgDK+qsdx2iaVwsRDXGJT1uRH
         IVwmFlh2Lc/+r1K0VCgVyNgwRqq1xvuqT0l4Uw8O88qmkOMdqqmat3Xj40IQJy+YBlmh
         Hj3A==
X-Forwarded-Encrypted: i=1; AHgh+Rr2347R0I8NhLZnaPI6binHP/HIdZiQSe5DYSFOJo3StPdoNhG93PKFjKDArhczYyRDRp7h+ji8bC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlg+Z5mBAEnz9yRdghs43hwz+CCgjLGwPYu7bDv2GyYi+qMB3F
	Tm79OHfcU5liWRJpMs3mgRJ5gzplzY2IMvaGfauMYxno9qVsVjQ3NhnZ
X-Gm-Gg: AR+sD12WkDMu29R6cHMHGXe2+TWj7WwfNKuzWTDXKa9xizZ+NAFwinRPHwLSMfinbUh
	vOCKVnlIl7LYAVI7X1eNZzbFdsi4KW5v9WkhML+G9lzKXP1TA/M2OJaLa5jm5Ob0nlAEaQPxIMn
	Gus+QP2S+E329n30WKb5N++ny/ilFKjQn/2/htQxtJ+SJGWtKwqq86TCPL3EnLkLoaUHJ+Cz8p2
	txX1z/P5fiqvKf7h+VeRYzZiWOhyVOkH5c/5vLSXZGCuDH5NTrwYnpTBBdlhH27AGlfs13Jxddx
	Q8hdV2KUyEbqHtbdZRVuHjlMkVCATYgHIPRymmIdlBgLCOWcCKwLe1h5lw8tGbbVpJUc+MJ5nbM
	7yKuc2jYORwAF0taGq5+DC8RAwenonFZnEDG3GXnMe998XL6zxKI+Dm4IuAB+skHui1x1lrRXr+
	Orfb+2pfEumfXPLgQqcGdtye/S26r+/D1azVCtzU6amkXPf6V0ATwGl4jAzEtSsXaVxKSe+r3BL
	kD+0T7Zj7Tj12NZLrK1RarfUUQDqkvL8Wul
X-Received: by 2002:a05:600c:8b03:b0:499:621a:2ec2 with SMTP id 5b1f17b1804b1-499aa1800ecmr103322495e9.3.1787146826264;
        Wed, 19 Aug 2026 06:40:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0d6a84sm57126405e9.10.2026.08.19.06.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 06:40:25 -0700 (PDT)
Date: Wed, 19 Aug 2026 14:40:24 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 04/13] drivers/ata: Stop using 32-bit MSR interfaces
Message-ID: <20260819144024.7479a0a6@pumpkin>
In-Reply-To: <20260819102314.1499258-5-jgross@suse.com>
References: <20260819102314.1499258-1-jgross@suse.com>
	<20260819102314.1499258-5-jgross@suse.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 12:23:05 +0200
Juergen Gross <jgross@suse.com> wrote:

> The 32-bit MSR interfaces rdmsr() and wrmsr() are planned to be
> removed. Use the related 64-bit variants instead.
> 
> In drivers/ata/pata_cs5536.c don't redefine rdmsr() and wrmsr() as
> empty macros for avoiding misuse, but guard the affected code via
> a simple #ifdef.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - avoid sign extension when using wrmsrq() (Sashiko bot)
> ---
>  drivers/ata/pata_cs5535.c | 20 ++++++++++----------
>  drivers/ata/pata_cs5536.c | 17 ++++++++---------
>  2 files changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
> index d793fc441b46..e16c7f4c7c27 100644
> --- a/drivers/ata/pata_cs5535.c
> +++ b/drivers/ata/pata_cs5535.c
> @@ -90,7 +90,7 @@ static void cs5535_set_piomode(struct ata_port *ap, struct ata_device *adev)
>  	static const u16 pio_cmd_timings[5] = {
>  		0xF7F4, 0x53F3, 0x13F1, 0x5131, 0x1131
>  	};
> -	u32 reg, __maybe_unused dummy;
> +	u32 reg;
>  	struct ata_device *pair = ata_dev_pair(adev);
>  
>  	int mode = adev->pio_mode - XFER_PIO_0;
> @@ -102,16 +102,16 @@ static void cs5535_set_piomode(struct ata_port *ap, struct ata_device *adev)
>  		cmdmode = min(mode, pairmode);
>  		/* Write the other drive timing register if it changed */
>  		if (cmdmode < pairmode)
> -			wrmsr(ATAC_CH0D0_PIO + 2 * pair->devno,
> -				pio_cmd_timings[cmdmode] << 16 | pio_timings[pairmode], 0);
> +			wrmsrq(ATAC_CH0D0_PIO + 2 * pair->devno,
> +				(u32)pio_cmd_timings[cmdmode] << 16 | pio_timings[pairmode]);

That cast is horribly subtle.
Perhaps change the array to be u32 and shift the values in the array initialiser?

David

>  	}
>  	/* Write the drive timing register */
> -	wrmsr(ATAC_CH0D0_PIO + 2 * adev->devno,
> -		pio_cmd_timings[cmdmode] << 16 | pio_timings[mode], 0);
> +	wrmsrq(ATAC_CH0D0_PIO + 2 * adev->devno,
> +		(u32)pio_cmd_timings[cmdmode] << 16 | pio_timings[mode]);
>  
>  	/* Set the PIO "format 1" bit in the DMA timing register */
> -	rdmsr(ATAC_CH0D0_DMA + 2 * adev->devno, reg, dummy);
> -	wrmsr(ATAC_CH0D0_DMA + 2 * adev->devno, reg | 0x80000000UL, 0);
> +	rdmsrq(ATAC_CH0D0_DMA + 2 * adev->devno, reg);
> +	wrmsrq(ATAC_CH0D0_DMA + 2 * adev->devno, reg | 0x80000000UL);
>  }
>  
>  /**
> @@ -129,16 +129,16 @@ static void cs5535_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>  	static const u32 mwdma_timings[3] = {
>  		0x7F0FFFF3, 0x7F035352, 0x7F024241
>  	};
> -	u32 reg, __maybe_unused dummy;
> +	u32 reg;
>  	int mode = adev->dma_mode;
>  
> -	rdmsr(ATAC_CH0D0_DMA + 2 * adev->devno, reg, dummy);
> +	rdmsrq(ATAC_CH0D0_DMA + 2 * adev->devno, reg);
>  	reg &= 0x80000000UL;
>  	if (mode >= XFER_UDMA_0)
>  		reg |= udma_timings[mode - XFER_UDMA_0];
>  	else
>  		reg |= mwdma_timings[mode - XFER_MW_DMA_0];
> -	wrmsr(ATAC_CH0D0_DMA + 2 * adev->devno, reg, 0);
> +	wrmsrq(ATAC_CH0D0_DMA + 2 * adev->devno, reg);
>  }
>  
>  static const struct scsi_host_template cs5535_sht = {
> diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
> index 73e81e160c91..61d232a82b5e 100644
> --- a/drivers/ata/pata_cs5536.c
> +++ b/drivers/ata/pata_cs5536.c
> @@ -32,11 +32,8 @@
>  static int use_msr;
>  module_param_named(msr, use_msr, int, 0644);
>  MODULE_PARM_DESC(msr, "Force using MSR to configure IDE function (Default: 0)");
> +#define MAYBE_USE_MSR
>  #else
> -#undef rdmsr	/* avoid accidental MSR usage on, e.g. x86-64 */
> -#undef wrmsr
> -#define rdmsr(x, y, z) do { } while (0)
> -#define wrmsr(x, y, z) do { } while (0)
>  #define use_msr 0
>  #endif
>  
> @@ -85,22 +82,24 @@ static const struct dmi_system_id udma_quirk_dmi_table[] = {
>  
>  static int cs5536_read(struct pci_dev *pdev, int reg, u32 *val)
>  {
> +#ifdef MAYBE_USE_MSR
>  	if (unlikely(use_msr)) {
> -		u32 dummy __maybe_unused;
> -
> -		rdmsr(MSR_IDE_CFG + reg, *val, dummy);
> +		rdmsrq(MSR_IDE_CFG + reg, *val);
>  		return 0;
>  	}
> +#endif
>  
>  	return pci_read_config_dword(pdev, PCI_IDE_CFG + reg * 4, val);
>  }
>  
> -static int cs5536_write(struct pci_dev *pdev, int reg, int val)
> +static int cs5536_write(struct pci_dev *pdev, int reg, u32 val)
>  {
> +#ifdef MAYBE_USE_MSR
>  	if (unlikely(use_msr)) {
> -		wrmsr(MSR_IDE_CFG + reg, val, 0);
> +		wrmsrq(MSR_IDE_CFG + reg, val);
>  		return 0;
>  	}
> +#endif
>  
>  	return pci_write_config_dword(pdev, PCI_IDE_CFG + reg * 4, val);
>  }

