Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870441;
	b=DrNYBs/G5gd7x94h1eawPs0gno11cfvbgjscvTXBkOlxjVdTZ0+aRmCU02I9vQpQivTz
	 OVSZXfxZdzxT9jNInkQGD5cdfOx/7BPeQVJwsVbUTfgNs3zKiKzKTeoFdGR3XJz1H9iTW
	 q3mmNNuEXAq4zGwsvU/iEARsHKfjXz8Cps+1nneY0BDLlQpLB/p6haI5vJMOeazEh0OIB
	 JKPoV7pRnsb8BH3IkvE2gG9coI6XqHknAEp7ctciLIthhOV5xFe80a8Wp81Bc5gR7RKkM
	 zSXhYh1hdrM/zzxkNxF1JIF90ftpSamu+7zk0f2TJVshKFpIJiFSCINo8mSoTzoOiyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870441;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=d7QIkQGcuhgCwpwukZfMYl/m0eNiW9yDpQCv/4z6USA=;
	b=jpVxUopJ6bOO3MQdzCznB13AMpFRwiSXr6r75QGA9AqFtWaz9B67vMcoq9P6i/FWgcbx
	 hUIpxEa5Eg+oyzXVdBzcJFGG94j4xnyQo6yU/isiAMwVJx5grCyYe2rxvzI3aLN+VAVN1
	 hg0RLWmToy08wtfSaKenvFZoTdmio9etmGyzAqFNTCOLePA0TcE+DUKACBcLRDhmeTtTW
	 eo+lZQJSg04kE5VjzLnJFcpAl1LToysntC5gkqiY861x22kk6PJ4kBoI8XSRLa7e8yGCD
	 bttDaQyk3ZE288jieGkqyV6E5+2Ub1lYYFM7C+XT6dLeJR/ylJmPqDCLbJf/SwMeZMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VaeBDszm;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBA960A2633
	for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2026 23:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DBA960A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VaeBDszm
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3b16896b8ceso1886926a91.1
        for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2026 15:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870440; x=1795475240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d7QIkQGcuhgCwpwukZfMYl/m0eNiW9yDpQCv/4z6USA=;
        b=GhXI/7fU0C12gV6hYfWa4W//5ynDTqBWnCTHjVGqWiwix5K961GtbJ6aBGvEa2CoU2
         uG8pz5/euI0m5CL6GW1mRyZyMeU9dl+NBGUIjwzrBFLCNMuzqgj2j6khQ09bzTDAawVq
         UbiQxYHmQC0bZnWP1ppr1zIuOEQVJldMCpFx91fnMrfSdvf4+idXntHEKqBLspr/Y2Hr
         dK++BWfyleh+OtEUkG/UWCbMz67rxdGmVlI1N3XXabh6shu1LfNNkkBRa6lts9Gzrod5
         F9tt2ZiXLcmdt31mZ+D3JGLyPcNwZC9V8o/P9zwZ5uNy2NsTfEhtK/JXM5lpnPIW9SyA
         C5dA==
X-Forwarded-Encrypted: i=1; AL+hErGdef//f6xyfzAgVmShG0T6q3I10FgnBxc+bmwiMYZCm+rK0urCH/7gjTk62oGZkhYD03geRSfJDkw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IJ7i8jUUMtm6pe3UpAzTMFNM91KMH5VXyzE9sh1sLYhHCuE8s
	2snbNhePLFJqzhQtGMIAw8M/IW6csUKD0SFXtFpo9hzHyScfWylGwCerGmSk2xVyWDUB1wZmSnZ
	lmcrQkY266K6hwoi+NfHd/82v+WRM/R7y8/m4aptqsxYlyJk/Z9Kxp59kglM1a7DGokZAT/SkD7
	S32OJY6QE4y3uBNJHDu4XbOK5smoFR3r8iQ4pUKnNQTnmdInx9NHDsQI7sVyRu+PWfnCecFa+ov
	sD58BiLaPtsJmXcN19a
X-Gm-Gg: AZFdTZcQ6H9lUrgVKZZVKoSmotN6EFM3nJENfuF3fpqpNbKQ2GwOmHUwZi2mAocijAW
	ALIwFXv++h3HdDuSoFNFviEyHt3R2HPU74bFNYAgw7hwLWbzMNAgKZW8C6n0X3mKjOie+VTUWhT
	vHr8DulFu+0Ua7jNlMytimDlkEMnyxrkYcMMJgkweO7htjGxw/I40d7J6Og0dwKvLyfInXf6/z5
	2Z9x88VPdon4EtUxJ5GLu6w5xREUIyPXbbrHHRcJnTxwh9xz6IqgXHjdoItG100IopM1o/Gp/Ea
	RW6q4tKlK92u8AtPEqeYxmotDNYbHOin3gWYCUbe/7F9fppUZz4aaaqfVrb7siXexleU7A7SNLF
	NJ7MCn6vjcsE5v6fQXA2DZyhGZ+VUB56nqGKzeTXZgbj7ATE5phnswu/C1znIN111d1EXSwJKQ+
	2FtWRh0FhTUt3sfCEJqPYhTwuH+SZEXWCDbR+rnpfz
X-Received: by 2002:a17:90b:4410:b0:3ad:818f:3da2 with SMTP id 98e67ed59e1d1-3b1b0b9a342mr9587903a91.63.1794870440436;
        Mon, 16 Nov 2026 15:07:20 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b3abb97be4sm536660a91.1.2026.11.16.15.07.20
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:07:20 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c0d568830so5045645eec.1
        for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2026 15:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794870439; x=1795475239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d7QIkQGcuhgCwpwukZfMYl/m0eNiW9yDpQCv/4z6USA=;
        b=VaeBDszmKHnDGk/R7SIAlVzIe1CwFTI9g1YhyDFwB38Ltud2DWD/tmVEPlcnj7gASe
         qxAqxciVVs4SXBKHt0SNl7h+oDdu/WV+ODf2bkd5biR1stNy+FZvaLSH7yDuBLcViTol
         3eDG7iAP7ru1wX21Ti/DrLRLEcg37bP6BGA3I=
X-Forwarded-Encrypted: i=1; AL+hErHPkOYI+xGggypKozL7K0qCGFsgAzwQscGorBE7iWFkC/nbpsuABzfOQh378fsmdeYZBXvz6YZAeOs=@vger.kernel.org
X-Received: by 2002:a05:701a:8458:10b0:1b5:22fb:848d with SMTP id a92af1059eb24-1b522fb84d4mr6306511c88.16.1794870438560;
        Mon, 16 Nov 2026 15:07:18 -0800 (PST)
X-Received: by 2002:a05:701a:8458:10b0:1b5:22fb:848d with SMTP id a92af1059eb24-1b522fb84d4mr6306480c88.16.1794870437878;
        Mon, 16 Nov 2026 15:07:17 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm50516401c88.9.2026.11.16.15.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:07:17 -0800 (PST)
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
Subject: Re: [PATCH v4 4/6] ARM: dts: broadcom: Add the NSP SATA IDM registers
Date: Mon, 16 Nov 2026 15:07:15 -0800
Message-ID: <20261116230715.1489712-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029212513.4126083-5-florian.fainelli@broadcom.com>
References: <20261029212513.4126083-1-florian.fainelli@broadcom.com> <20261029212513.4126083-5-florian.fainelli@broadcom.com>
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

On Thu, 29 Oct 2026 14:25:11 -0700, Florian Fainelli <florian.fainelli@broadcom.com> wrote:
> The NSP SATA description omits the IDM block at 0x1811e000, leaving the
> interface clock and core reset dependent on firmware initialization.
> 
> Supply the IDM as the third controller register region so ahci_brcm can
> perform the downstream clock/reset sequence. Extend the AXI bus range to
> cover the complete IDM aperture.
> 
> Fixes: 8dbcad020f2e ("ARM: dts: nsp: Add sata device tree entry")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
