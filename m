Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686D05328AE;
	Wed,  9 Sep 2026 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951172; cv=none; b=KqVEsVYDb/aNeXYKD3o8iRi6wbAcWTh4+WMxGRI3Fh99a0oAY8tCIPTanGhLbahJm9Fg7G7+mAfNAda2wZodDuGpmrRPoGOTI5SjIUu5LXHB0/wq34QHwajiaTpWrUtSzS35vX3/NR8plg2m8G2hLPdJPhoJs9W/tUaUyKQ3ils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951172; c=relaxed/simple;
	bh=ZHjqnq9NH+Ikvi2NYFMSMojFJbnnQdXm7+7u1FfH6II=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f10IiiLAH0pzB6zmilTsDJVnin/i2xoAISNaBbI9tcP1YwBQ+VjAbh39ok7gZl+uLOzGK8E9afm2qJUAAJxM6KZzQsIu+FSSOsDLwRZIj70OhK44awWeC4zECXMPmY4zmUNCFN1IHAEm+yk1y2cL51GgrQegvrgHcKubdj2aTqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6EJG5bG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6EJG5bG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F061F00A3A;
	Wed,  9 Sep 2026 10:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951168;
	bh=3cKbNd616wWNajTVIynaWeEJ6Kr7Ap1typJBO+6xdFY=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=U6EJG5bGMtJmCAwQTsKf0cleAiy0ViPCIn+7Ik4WoiMNuHveOr7iwkYam78TW5Fe8
	 G6SCv9XsjqKftEszV66xLYboeMdlFgzCKJ0ziKFSHXscHxNhhSN/4FmIwSQLTXWJ1I
	 Dt4wtkLslWzSF5ToXGbTzK6blnOFpH+2fnkxG1RFX985gQXrZjQkETa/brLBYIil2e
	 xSynt53+avZxRAPEKsrkZygJpa++lfLaqz9aO+wRX2CSD5VgyUPK8xDWSuPt4tq+fZ
	 +nd9R/DxdzuBSr7ZJEMbxbVJy2zbcfPoU7xlmY7huPhPc9BleP9Q9b2bX8ZBu7/GKr
	 p82KBbDTtClwQ==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <cover.1788867690.git.xiaopei01@kylinos.cn>
References: <cover.1788867690.git.xiaopei01@kylinos.cn>
Subject: Re: [PATCH v2 0/2] ata: pata_parport: fix UAF on protocol module
 unload
Message-Id: <178895116744.2768460.12721406127250514018.b4-ty@kernel.org>
Date: Wed, 09 Sep 2026 12:52:47 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Tue, 08 Sep 2026 19:47:26 +0800, Pei Xiao wrote:
> This series fixes use-after-free issues in pata_parport when a protocol
> module goes away while pi_adapter devices created by it are still
> attached.
> 
> Patch 1 pins the protocol module before the device becomes visible.
> Previously try_module_get() ran after device_register(), so a forced
> module unload in between left pi->proto dangling from the moment the
> device appeared on the bus.
> 
> [...]

Applied to libata/linux.git (for-7.4), thanks!

[1/2] ata: pata_parport: pin the protocol module before device_register()
      https://git.kernel.org/libata/linux/c/5d3355c7
[2/2] ata: pata_parport: unregister devices on protocol unregister
      https://git.kernel.org/libata/linux/c/d82c5cf6

Kind regards,
Niklas

