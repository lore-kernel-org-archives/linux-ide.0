Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870453;
	b=WssI35FqGHqE76bZ9sAN6l6UV0NshTIk+e6epslxktGxrNfgA4YL+Pxz8arGflbigLAI
	 AQiesOpspvIjLdFmuyYpTmxY9dw9Q8oKJZH1mMSmjD47iKI9kxZt8m7OkNMRTHuEfLxWo
	 S3jKhPQgipQL6tHsaxFOADo2v8Bb3fRxeptDF5nA/MOILcKy7qOF+iEtd1S9QaPz01DCj
	 gJuOnvnFkoJOh3xjtOsHWIvcSDa/5XoiY7+WYjswvBuSWumLj+2Fng6V0Sa7ToTrwfJ8f
	 QuLmSDNERFp1XUcGBsVy953IZdm1qtEx2PAH7VAilH5YQ1S+HnsFSFCYsl3VyV3FNrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870453;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=hpknOOfaXRSRwzsy+zJvYqiC8yonJsdMZo1b7Unb9Gc=;
	b=JvWHhSwvQRT8BNDSxCscGQGIqemguBwjDID4g5rfvB6nYQo4pIm/6RokLkuQnGtJs9El
	 9fDSB0qAxzDr/bhnDMxn9f4Xe3B3KoNAa+iUkzrjATDfNvtPD/kxvGC7wqkK9habcskSx
	 Utrv7ELKlDlFa1sOXvaCh8lhidqgy9ZaCPhgZO8K8I57/GVji62hWL6vPrxaNWN44n7Ec
	 mQkXxXWwvFafx3Kr7BZPB0UgV52X0opqi0wl6AwrNJLCU5tdLYsSU+RDZ/LpiZEWJVckL
	 MYyG55bTsDEFTrmeqnNjOwXYjU97re5LlpjsNVkvI9UBacq8xRFikbUpKozh9pw676g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=CCsc6fve;
	arc=none smtp.remote-ip=209.85.219.97
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C94960A2600
	for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2026 23:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C94960A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=CCsc6fve
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-91c1f548f87so73147156d6.2
        for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2026 15:07:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870452; x=1795475252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hpknOOfaXRSRwzsy+zJvYqiC8yonJsdMZo1b7Unb9Gc=;
        b=Z/IYvmz9xSnEPD/qMqimzryoZFE8bSLUFMOQVZHWF2ZXfMn06X5lwL3AtUOpCH6/K9
         DMeSu9xjWVM5hp34siKFWSODylccVAjZCEfjrfvXR6bkwM1pQf9ES0Rp9GWoA1apcRTo
         RTPMsv5oLATj1xgujmHJNm0/l2jT0dQv/jb3BZ8ydCVh8MPnWsZLiO2ifZQKhfuiRCjT
         PPsgwRxPcxVMxUDVmRXGpO6+X/zacoeaPX7bXUuUWQ4xP3fvD91ucwmWeUKG8RWp26CP
         76D1FMKVuiJH7QsaImLx1QC7vzffnzhldoeFvErz1BYcdXSl/Kqe1UQR904AsIYiMATx
         WUyg==
X-Forwarded-Encrypted: i=1; AL+hErFOD3xfp2TpSn8J8xWukkpU8Xt/zPTLWH69IeQ4OEfZkw+PkXrl+A4FUKo7sq/1XOjTOucjzqKdWnE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wr5MYNeftwP3piOgXffFA+lYlFlwjJ1vt4kOYrRUMRPIFiPVr
	rtlSnu2UUYSrT6RSpru+q5zcoRFbkA0tgLVpCiYNtZw2hY1n2ARdpm86pYTE69RYcTCEzf1Lb1N
	gfKq1KoXC9aitGgPbdblfX5hK+UN8+LGFlHjGDSgxZs36kVGaUzfl27wkcV/3xLGgyJQN1owVbP
	TjZPDL6jpQYjEwYYoZ6MRI/KocB+ulFNta3AqdpHDUXuJmRzET4zNGrIHnVQ+0dpLnMwJ7ZZGQO
	H9sQ1Jd5Ds5sDTiic6p
X-Gm-Gg: AZFdTZdHP2zTx1q5UNQve3F+O98MV3/sAeimJjuYnC5j0+LZn2xxqMo/GcUztLqU3cK
	dJpzYjvpdNU7BM4SnMgS1sLeEqfcdos3U5WQkfX5gSurDvNy0YpwOYLGXDSmyDYkQpbil+lgdJ6
	lMEHOGwSglfpBjUfhDOyk+a/VjOg4VjDQeIXb9EkSXKXQvXSV4UOKFuFcyXu4JhWu9aIcbhU2lC
	QKGvwIaKfpCk+f9MzEVTwmhEUUOcckv9MiNbN4K3g/ePWE6BOoLWfVvf6aiXJDvC35Wxvnc7dph
	H2AKGF4+b+kv/AgdHfemo/McXyMkSP3ijzjSpmlnAczvpSGJRG+9UAp3Yxe+0VsCt6eDM3mxSnJ
	znbVjb5v5GvPXJKIR0jIQdaOQ4slixWRcZWh4A8/Z/PZQc30m5hbQeOOY6VOYZta3sVurxQw7BF
	NhRJNCB242918bhLcXsA+C2fSd14BeyEi/XEtbAhpE
X-Received: by 2002:a05:6214:628f:20b0:91f:17d0:979e with SMTP id 6a1803df08f44-91f2415101bmr138168496d6.19.1794870451720;
        Mon, 16 Nov 2026 15:07:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-91f23dbe5cesm1491216d6.53.2026.11.16.15.07.31
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:07:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-378722fd4a3so4467562eec.0
        for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2026 15:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794870450; x=1795475250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hpknOOfaXRSRwzsy+zJvYqiC8yonJsdMZo1b7Unb9Gc=;
        b=CCsc6fvexHQp5kbxGis2nJkzION/CgiADIqoWcZQNlqWjhULXR03igQ/p4t3J55eii
         b6h2MxjqSWgfReRhei/JSnVpeJKccqgPCLc1DyoQ0rXux9jwmfyvtxrVemMbbBhXSjGe
         ZLoHfmHh/VThEzBfkj+PUqo2LvF3kkCOTeEnc=
X-Forwarded-Encrypted: i=1; AL+hErFCD/vnXpvl8p+3kECGHmuKQWGcWfdWUv1xk9cX/C5nHfTPXolx7JNsxOZRZ9aKY+lB3su/SYDDEYU=@vger.kernel.org
X-Received: by 2002:a05:7300:cf8c:b0:369:f70e:bd40 with SMTP id 5a478bee46e88-3796628f4c8mr11453324eec.16.1794870450470;
        Mon, 16 Nov 2026 15:07:30 -0800 (PST)
X-Received: by 2002:a05:7300:cf8c:b0:369:f70e:bd40 with SMTP id 5a478bee46e88-3796628f4c8mr11453300eec.16.1794870449743;
        Mon, 16 Nov 2026 15:07:29 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-380e031f3e5sm4677314eec.12.2026.11.16.15.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:07:29 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:BROADCOM IPROC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v4 5/6] ARM: dts: broadcom: Use noncoherent SATA DMA on BCM958625HR
Date: Mon, 16 Nov 2026 15:07:27 -0800
Message-ID: <20261116230727.1490184-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029212513.4126083-6-florian.fainelli@broadcom.com>
References: <20261029212513.4126083-1-florian.fainelli@broadcom.com> <20261029212513.4126083-6-florian.fainelli@broadcom.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Florian Fainelli <f.fainelli@gmail.com>

On Thu, 29 Oct 2026 14:25:12 -0700, Florian Fainelli <florian.fainelli@broadcom.com> wrote:
> The AHCI controller on BCM958625HR fails with the dma-coherent property
> inherited from bcm-nsp.dtsi. Soft reset times out waiting for the first
> FIS command, subsequent engine resets fail, and the disk is not detected.
> 
> AHCI allocates its command tables and received-FIS buffers with the DMA
> API. Declaring the controller coherent bypasses the cache handling that
> these buffers require on this board. Removing the property restores
> hard disk detection and operation, as confirmed with a diagnostic DTB
> that changed only this property.
> 
> Use noncoherent DMA for SATA on BCM958625HR, matching the downstream SDK.
> 
> Fixes: 56e2ff0346a3 ("ARM: dts: NSP: Add dma-coherent to relevant DT entries")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
