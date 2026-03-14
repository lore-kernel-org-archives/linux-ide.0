Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62AC17C203
	for <linux-ide@vger.kernel.org>; Sat, 14 Mar 2026 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773509894; cv=pass; b=utlqQ2z6Onu+x2JXWjHKNBwZ9Qvrr407xfV5pi4+Hf4NkVcpPoU/1ILiHbDHvKa5B023NnitorjHDznRhZQr4xhmq07J6lQI6YZRIg+YtdgJXI/RCNi20FpqRhSCqJCumuycE6Zwg/1c5y2sF1gTgXtb0ZXYsI/q6DE25Ji0ymc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773509894; c=relaxed/simple;
	bh=eFS4Y6P0NviASyPTUWoyT3D4kAhUdvRmA607npifPRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMulant7NDI5NNxtDXoTJ6DBIPoijU5oyHP2mnapWY2Lh5CwmrXiuACaa2OFDu+q4/c2DnjFTDpJPyfBK0s9+VFxPYgk+IPipug1nzNYugGoj8ER4jJgKbeJGDIRpUzB/MAF+dELGwsuIQZKVxp1sqLvAvOa2kgPkMFeXRru5Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKFfmR6J; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKFfmR6J"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-509134ab2d2so28821331cf.0
        for <linux-ide@vger.kernel.org>; Sat, 14 Mar 2026 10:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773509892; cv=none;
        d=google.com; s=arc-20240605;
        b=YiLHviyJ84C3IMqKNzXg70Ap6f229kL5xPmzjI4cLFGJX7sJsSDWHyZwnNN3xmDPMc
         rR8JZMKdNtRvbL0/YR+tpYj1YcCe8cOxWt9laSRXP+9WuKbD7G5+w+fIbhHN9uKcz6sI
         HNHNk2YXkHRXKZTLrIw/KNMGWhVUD8n/0t+DmRZ5SHBzuQQh4SJ76TZwBgm99pHK8bLl
         DgVscGZNas/3a46avMuE2ydiJ6+1X6OvhHULenoynJNO2dZNG9L3gxxoH5NRxWDR/Qh6
         +8pzDoWxGbd4TqPCMBMZWNgBlBeMm7IL6VFRscUMxy6u/w7UOpAsSAgRiN1mD1T5tiLb
         WDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=07NfAhuqNl9yNYib44cmXWgZq3Hp1Lc585Pdo1TZ+os=;
        fh=xwbopahXrHvZHA0C/4BG1IIz1hyQ2x5swPUXWsXNVZg=;
        b=dG7emUVafL5qzLbA3DDGgwVnV1z4rEf+yrG/dVY3GqEcvD8PT9ior0DTZH3bSSVpXT
         9/PoeY0/A5PCGSsype7hAvDIHTLOHXr1y8lqA0pAfsHXmhy1sJV2acKV7KuIxufy2wiV
         h6dR6EyWhVOdMuLITQG4e9a7NbCNfzL5kjRX4yqm1b7ud+vH8A3tfp2R0JnJMlWjtUk2
         2Jb8d1JiQLuHaNVbFQTgIAKYQibAboLcDQXfWKKB8NzH36mmrdFQ19BMfcSQY1nn8Fkc
         JAtdJDoGMs/Xy27lAOyGiSShAl4ifi4nflIW0aMUuMfZEOJuaDMN49+w2vzVPg0dislD
         O7TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773509892; x=1774114692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=07NfAhuqNl9yNYib44cmXWgZq3Hp1Lc585Pdo1TZ+os=;
        b=bKFfmR6JWYisoo78Jx/F/ud2U6fkybtq0jax0tpiBzKQXEWy/jyvsb+Gc1oJegajY4
         npXDE3jRND7xKY0aeZSN6qY4OIB4It3VkeyIgJ8rVxvItngS/MECb2H1Oii7cvp019qp
         ey/rOKvbuR9BIHkKqI5CdwQ/IpbBBBRzsyLlbFUPvXoUPVxGDpcFIcK6ZB6yWEVk9Xco
         yOcA7Pk814yYO6RHAbex/WIpajfshE08ObParq1HPPowpdKlNtWZL+sASTCElFK0GOk+
         nMWpWtNIXEI37BglCF741TxsEK5mRE4PXUOTLCE3q3P3EHa5BqdnKs4okvZJ77Zljto/
         KLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773509892; x=1774114692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07NfAhuqNl9yNYib44cmXWgZq3Hp1Lc585Pdo1TZ+os=;
        b=X9yM++nYfZTgTHUz/x7UH/ZS6awcg2xKzkiGMAFFg5KjstF5NlDjjG7YLiR1Y/vF2Z
         2+TDbOC8VsaAkGF8ORldkoVD26aCDl1DDz8QhwrqPyvpPlEWSgRD0Yi22RBpIkyOP0St
         bxGBIBIotajAXGnjJQpjOfxTX9QCumhV6tEYyYyUL7Ff1v2jzKh/eHE0dDsooCJrTVSm
         9YfkqXWjOMhbvclxrp35bkEH5UuuIKe00s7zPXEQF+NSl8w0zDn8TDJ+NWFonskTj1Iy
         L5W0DVOH9B6qEbTHrSQx9UupD254hdtybFHEa2ewyX7VTQ4q2CeYUnOY+0hWSTW+MXvO
         aSAw==
X-Gm-Message-State: AOJu0Yw5xMfsqQZ62FNDG9VSTWhZ/XVygc9x4jTPeIJ7CW/ad/3C/V5+
	RoXQq4MAyHx4ADnbVmsjuF9QwYlFc+M9Sa4NvNQBFUP7uqs8VIR2xR0FV09lsAAhwIfPjr2iwk1
	xC9sD3lOLj3FAItJpFzuW/+DP7Ih7B70szLGXcX1C5mta
X-Gm-Gg: ATEYQzwtnc3olF+zSLtbhA64P+BjEpzA+SMp2qNo+Am0G0CRTudBggneQcLZ1ljyca6
	qzTSJmZCHsNDG55uugrts6bQOBqH98zIWHt4sALPdbBi2XQ8/PYtG6nEy+4H8YakPJA8Wbut/2S
	CbuJW5gKot9NbpoOCY5I07PgeMepb9gahBs1o2mgm8mwQn0LbvaTZtpxFKwVdmw/vLjO7VLZQ2D
	g9wIRUIrXCkkkixikQIQtRKs4NknIDwib8qsti4Y5VWJb6hqeI416Sa2q45zYZxUChViVQLXxaC
	309DDU/H3Ftg7G5uSd3MHYHzTooXMucKqGV6rEQGNyWccbCP2B5C17Ep2w78I7olXY/rWk33qbT
	sL2mIF+8xJYvs+PY1TrxmHju5VA==
X-Received: by 2002:a05:622a:210:b0:509:aa4:4a02 with SMTP id
 d75a77b69052e-50957d21b89mr100232531cf.29.1773509891640; Sat, 14 Mar 2026
 10:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABn6530JJUe5vYA9f-TBY9fgi-wacqNriVPeiKD0EfYQ+ZPi0A@mail.gmail.com>
 <d3ab269c-697d-4768-b7c7-61d0beed3879@kernel.org> <CABn6531ukajHmBNvq5z-UKN8nX8Uf2a86+caMcpGk4kGDFEbsQ@mail.gmail.com>
 <e1b944e1-e0ae-4329-be4b-f6b278df6cd8@kernel.org>
In-Reply-To: <e1b944e1-e0ae-4329-be4b-f6b278df6cd8@kernel.org>
From: Mohammad Khaled Bayan <mhd.khaled.bayan@gmail.com>
Date: Sat, 14 Mar 2026 19:38:00 +0200
X-Gm-Features: AaiRm53LNvaDQvjuw4Vtx4fq1CA23qwGYBJNy0N6EmGpij45G-tAD0FuNYROwS4
Message-ID: <CABn6533+uexL-W_83dVF_yNa5n_zOeatU2K4GyvCvD5YwS5FnQ@mail.gmail.com>
Subject: Re: [BUG] libata/AHCI: ADATA SU680 on Dell Vostro 15 3510 shows
 repeated FPDMA timeouts, ATA bus errors, hard link resets, GPT/metadata
 instability, and SMART reset-counter inflation unless link power management
 is forced to max_performance
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

I tested an Ubuntu Noble HWE Launchpad/PPA kernel prepared for this
issue by Alice C. Munduruca, carrying the same quirk:

{ "ADATA SU680", NULL, ATA_QUIRK_NOLPM },

Ubuntu-side tracking / validation:
https://bugs.launchpad.net/ubuntu/+source/linux-hwe-6.17/+bug/2144060

Test system:
- Dell Vostro 15 3510
- ADATA SU680 1TB SATA SSD
- firmware VE1R910D

Summary of the validation:
- On the official kernel 6.17.0-14-generic, with low-power LPM re-enabled:
    - the issue reproduced again with repeated
        - WRITE FPDMA QUEUED
        - Emask 0x4 (timeout)
        - ata1: hard resetting link
    - SMART Power_Cycle_Count / Lifetime Power-On Resets increased
during the session from 17439 to 18347

- On the patched kernel 6.17.0-16-generic:
    - the kernel logs show:
        - ata1.00: Model 'ADATA SU680', rev 'VE1R910D', applying quirks: nolpm
        - ata1.00: LPM support broken, forcing max_power
    - attempts to switch that host back to low-power LPM fail with
Operation not supported
    - SMART monitoring remained stable at 18370 -> 18370
    - no timeout / hard-reset incident was observed during the
patched-kernel session

So from my testing, this quirk resolves the problem on my system.

Note: I did not build a kernel; this validation was done using the
Ubuntu Launchpad/PPA test kernel prepared for this issue by Alice C.
Munduruca, carrying the same quirk.

Tested-by: Mohammad-Khaled Bayan <mhd.khaled.bayan@gmail.com>
