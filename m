Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D20939183A;
	Tue, 22 Sep 2026 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088983; cv=none; b=L+o/e6GyZ2VxqQ8ySADwZRQuZbjv75R4UbkfInKi4++r48bJnL9fvnShr0Yb/lxsmm2d+bZXW0xB5ysDSaXK+c7q7Zss5X/yoR4V9vIjUkkKYRVwxxwkpJtTpnTFJMp/DdAYcIwPu71eGCCKyQyZOVbow9ELdqhX1GZ1h+U2m/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088983; c=relaxed/simple;
	bh=CyFizXE7C2QRDFaXSfC27emtRA4qBBViR6eZEnTCX20=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c7cLb8la5yBX3lUpuBjqCkVQg5Csnh5t0jqLy+Yw7bdpMMYASjjgQJA+RROGiJZScRkxe5DKwV3iI7sMHg7tyNS3sMBAyjWu/SdvXNG0MSFPbDewHxBmkKIuzB9iutxvHThv+tQ6QmQk3l62QQeBbhfATBy+m4wIxsLC4ACKob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZ3jKtJ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZ3jKtJ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B535F1F00898;
	Tue, 22 Sep 2026 14:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088981;
	bh=Gi7W87KWTsCWTuVv4IDUNCQeAirdSdaiGy2GrnJAdvI=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=WZ3jKtJ42UeOXtmHMy8vvBy7LEpS4Tv5xXQvco26sxoZbCm9oToG23BQ8bsQM3iV2
	 XPts7biCcdBsNc9QTc3q2gEp3LrR8IbwkC67Qjx/PwKBScABHLhYfe8tuVUIKcwL2/
	 Uhi1lgkp1c9j6/7+fWj8auKFpJM4uT5BiZDt68vQ44DPkce4pqakRYhSLG5ZGSWNuX
	 YRDLRPwls+YsVeguJRSGbOUnYy9ODI2wDrC8CRi/j1+wSzwT+o13tgwX4Rej4+6HWQ
	 Vaq9+imtkQduNjTtUggeTH/8UN+TgqvMEF9cqOk0IdWdu9D5hMW64+Ool0uBQpcgE3
	 QK8dJAfCF6sJQ==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <cover.1790047457.git.xiaopei01@kylinos.cn>
References: <cover.1790047457.git.xiaopei01@kylinos.cn>
Subject: Re: (subset) [PATCH v3 0/2] some fixes in pata_parport
Message-Id: <179008898045.3129348.7193947972653657905.b4-ty@kernel.org>
Date: Tue, 22 Sep 2026 16:56:20 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3

On Tue, 22 Sep 2026 11:37:59 +0800, Pei Xiao wrote:
> Patch 1 pins the protocol module before the device becomes visible.
> Previously try_module_get() ran after device_register(), so a forced
> module unload in between left pi->proto dangling from the moment the
> device appeared on the bus.
> 
> Patch 2：fix parport attach idr_alloc for port numbers > 0
> 
> [...]

Applied to libata/linux.git (for-7.4), thanks!

[2/2] ata: pata_parport: fix parport attach idr_alloc for
      https://git.kernel.org/libata/linux/c/193f5b84

Kind regards,
Niklas

