Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870465;
	b=TwOD6pYM10cyaDA64Ih77YpA/wc6Dr/59kMxB2QDDmKJh6VytXN0UaaPdzmorhi0iUTi
	 BYHnmY+zXHH5N3ufuOjydEX/C5b+uCQsSXFxUVNNyxGpIeC3lw0D0TN6DvyZmEo3+Mnfi
	 K0mpeW/h9fExYC7BOeCrgikTWag6XvGGTKk2boVLdIiprQ12YNwJya3GLLe4Ljlxaa15W
	 +ombZPrqnxgLiCA2C+mdLGz9X8w7fA3FUhMJ6mVnGEtVpNaAIeVB/OMzhTvgfHCH3BOXA
	 pGE7qZkrMLcxIBaFinYS5FAq7QII4dGVliLtHOoHEXT9PdPtKn1D/TFOhxTWRjJHDOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870465;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=Wst+LDRzcSVTFePzkpCfXygrywKuV6vnyIhVCYwr1YM=;
	b=TANlbwRDWGl02DrgxeKlX4YG0jcmc5TNEYTXSbRtmM6vP+wHUJhuYt5L4bTWobqydvc8
	 mRCP2o9awlqhMUWedJKwzs3ApvKAD+pBoVxWAZf4Z1vwTsA8sgW6sNgCgrNzoerHi2JFc
	 3dddszwvTEJa8p4bLosYvo5RL90Vlapryd9oqIarVnlWdQnBLwX1j4iHwM+cxc8LfcQsW
	 wPDOqnIAyFmHVg2g1D32DEMy0mTAtiFrzcUH9T8HQvb0HJxFHOZtyTdFn0Hca1OJMyMC5
	 hKZxfMn6D83mxvcgMBZd8lH8Rkz09Nhc1X1lwL1QVqOP6rzOcbbJDCL6D/8tH0VFqcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Y1aVRoSW;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D208606A891
	for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2026 23:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D208606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Y1aVRoSW
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cdba1bbde0bso1411089a12.2
        for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2026 15:07:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870464; x=1795475264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wst+LDRzcSVTFePzkpCfXygrywKuV6vnyIhVCYwr1YM=;
        b=u+JbGygX2d3Lv3N0zUY/my7pOTXzVpftveWzuXE1zql+Mku63gzYVTSkytt3J/P036
         HSa7dr1l7sEPtDgCGks/qaJ7O4AKwGJuCAGgFW1rxdgEmM7Am/oQJ4Fgh5Ay7W5llfAN
         6aQN5+Ww3XmZcL5mp6Sjdw1/qVhMfkb07xkBJk8kOwQG+ZZJAM3ThU4FkPFwPoIqVeEP
         q2jLKSfLeFCQcRPdm8ezvKayqUi/D7DEkJg+eRjl7xv9/IaORSXp3wM6jMQZSpQLa5a8
         ZbqkjKpdhHLIp389KSpnIWi6LKS2I7jGR9bVdnZc4uXifQsj5DRfei+CcL8fEy+sADWG
         vQVQ==
X-Forwarded-Encrypted: i=1; AL+hErE1bHjNG6JjVHtQaxdLvvLoPhnvNuvRlnLubzroh/ZQapUuGr6wcPkC9JYi+54FzCLVBWZl9flUDes=@vger.kernel.org
X-Gm-Message-State: APuU4Z841PupL2BdkyFfgaI44Kxk6rG2hWsn53q2aHbaqkvoxS7KQFPx
	CqvRPbZeEKmwWOI5FrSRejw9+CA58FKcwMEjQXsK47Q8VFSERUZYmT37dg4OQx0gQQOjY4cO6rq
	u4qgqAzfN6Qki7YTuSeaS+TVuqi9Bgua2/qDgNfgvMEOOS7ysgZf3KI4N0THta1RX6WUF8dIDqX
	BVbtOWrWFnZyZ6Y/IqAARJOYQ+jvBMQcAmGft73JObXnyyPTRBmxhbM58WT5+1AwGhnwdA5B4eM
	/IkYVFp5HHOEwo1xfZS
X-Gm-Gg: AZFdTZey9+PUcex7WBqZiviyC75IJevJOUp/C0WoHvYnROso1NM6skNveX/Y86bpdsO
	wwZLiy9KgFJgRWFcJDIE+2pXIaTs7hOHtU7QS2EmIKuM0VLyj6DQ/MXTbXXy8I0Noek0nJig8L2
	QK5KjFB865xNuESV2Gdt1a1BwSxcPnZLp5srqibSlBLSBhP7lsj/Ky85gWZf2EF4X8U8RhYV/eM
	g02piu48D7ZfX7UVXYesNXcHP62moKKpFaM70/4NgewV7KemrDqr1tnsCOu8Zcd+1x1uUwfLhvd
	/k+wV4nTjv2vs2mDIBMlihv7P64Ul9w8Lrr7qNn5lWoWbnNaEYXp6XOngRZN1XI0AdQrBk36UE7
	IfGZ1F12IrlJcqIMJY/gfyfnYeVz1jvWHrex/Wv12ujvq0Z8MA3EP2fbra1kSovZ12m2nlpG6Zu
	r6gSGP3dWlUrhT4mN/1u5v5XC3qtC/9vSDoQ8sbTvM6o8=
X-Received: by 2002:a17:90b:4ad0:b0:3ac:b3ff:b476 with SMTP id 98e67ed59e1d1-3b1b0b52e13mr12384461a91.38.1794870464178;
        Mon, 16 Nov 2026 15:07:44 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b3abece214sm550506a91.3.2026.11.16.15.07.42
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:07:44 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36f479b9819so2271657eec.1
        for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2026 15:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794870461; x=1795475261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wst+LDRzcSVTFePzkpCfXygrywKuV6vnyIhVCYwr1YM=;
        b=Y1aVRoSWpidXZCftNIebi+dCwEd+4KobpnVtHAFpTFuNyFg0wbWuxmTbDnuVIo4dXB
         AmNWblLmoyHKsYVe/mIM5RiYMAVK2PsBho2TUEc3hBf7eaVRcQutgIvdpnoxGqWyQDLX
         b5ye9NQ4994n1ZE6B6BtukmC8qjggruXTRHVA=
X-Forwarded-Encrypted: i=1; AL+hErGMkk0VEK4haTkS8WpaUT/PyclQyjzDkZgr8ubygCnLfPeAVoT/3ASRP/lLiA/PGScs5wOzdUgF3JY=@vger.kernel.org
X-Received: by 2002:a05:7300:c00f:10b0:361:1dd6:531b with SMTP id 5a478bee46e88-37967600b2fmr12357848eec.26.1794870461073;
        Mon, 16 Nov 2026 15:07:41 -0800 (PST)
X-Received: by 2002:a05:7300:c00f:10b0:361:1dd6:531b with SMTP id 5a478bee46e88-37967600b2fmr12357825eec.26.1794870460396;
        Mon, 16 Nov 2026 15:07:40 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0919sm36874961eec.29.2026.11.16.15.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:07:37 -0800 (PST)
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
Subject: Re: [PATCH v4 6/6] ARM: dts: broadcom: Enable SATA on BCM958625HR
Date: Mon, 16 Nov 2026 15:07:36 -0800
Message-ID: <20261116230736.1490551-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029212513.4126083-7-florian.fainelli@broadcom.com>
References: <20261029212513.4126083-1-florian.fainelli@broadcom.com> <20261029212513.4126083-7-florian.fainelli@broadcom.com>
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

On Thu, 29 Oct 2026 14:25:13 -0700, Florian Fainelli <florian.fainelli@broadcom.com> wrote:
> Commit 77416ab35f57 ("ARM: dts: NSP: Disable AHCI controller for HR NSP
> boards") disabled AHCI after reports of boot hangs. Both SATA PHYs
> remain enabled, but the disabled controller leaves the eSATA ports
> unavailable.
> 
> With explicit IDM clock/reset setup and the corrected shared PHY
> register aperture in place, enable the controller on BCM958625HR.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
