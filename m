Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D0A24DD15
	for <linux-ide@vger.kernel.org>; Mon, 10 Aug 2026 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368939; cv=none; b=esYcRGBwhrY9LtXXiHbkHnpFE6ewVntKBPG6JoBqK7Q41zqEGCAR8k5HEKlpueZRP4bQez28DQhK7W7fwaylv2+uj1q/NfIit3nFSIcrqVxWIX+zp2ug19RJc9/6VcmP0dNPUmMAu4tbE7domKYzMzv1fF61h5gP6VaW41fzIJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368939; c=relaxed/simple;
	bh=uMlMzXOFekSOgSa6TqrdTsPzRw5MGlyZTfplb06SFjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XhxvVJlDnHzAbB0opE/TfLuPe3B2g7TDL+OM9KqoydjDB8RUMboj5CP1lqdhiAbeHBR61/jE5CRZNZnNh7xZJH3XstHlexOZrpw0St0JVLMjbfmQ6MNXaJebPtuS06pWjQV1cNqsTsXjLKdKH8PlRzA4Atnj5AVsq61z+RFWriA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fo5HCdb1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fo5HCdb1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58F81F000E9;
	Mon, 10 Aug 2026 13:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786368937;
	bh=bXeJ4MkTUt7DhUbvCsZfFmuul7ORglQ/4A9QLRL0gcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fo5HCdb1JP/GvoXkNLXJdD41uo95TkmR30YHxCDWHjhZwFgyags9x7QtgHS7wG5uQ
	 6uMcjiVyuxAtR14fR0D6NUfhhDAXruyHKVadBUsMH+I5Kju6BXgD8EOY9/jzWwoFKI
	 kCVJF5CBYdVG2PGIaYjwr9oVfIWi6Q0ecnQhj8ZJkJ+xjrOk0ozpk01yXwUKkWjGXr
	 JGus/26xS/JeLwVn3sWmSlidxY3OCR3XYKe8XMzknLSaw1WXiGJbhPQF0Hh6sz9+aZ
	 xuiRu+FgxjdiKXuxWYKsjGL897YNiUkM0uqB/dO83/ZXUB0dj4vOTH6muiQMlp0tcd
	 tTv91C3sEkrsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9] ata: add <linux/pm_runtime.h> where missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260810132502.460566-1-vladimir.oltean@nxp.com>
References: <20260810132502.460566-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 13:35:35 +0000
Message-Id: <20260810133536.B58F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the sata_rcar dr=
iver uses asynchronous pm_runtime_put() immediately before pm_runtime_disab=
le(), which can leave hardware in an incorrect power state.
--

--- Patch [1]: [PATCH v9] ata: add <linux/pm_runtime.h> where missing ---
commit a948ddb3d02a94769e1f9fcb8c82c720adc71ef2
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

ata: add <linux/pm_runtime.h> where missing

This commit adds the <linux/pm_runtime.h> header to several AHCI drivers
that use runtime PM operations. Previously, this header was indirectly
provided by <linux/phy/phy.h>, which is dropping it.

> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 58f512f8952a9..d1cdbf86da78d 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but while reviewing runtime PM usage in the
ATA subsystem, I noticed a potential problem in sata_rcar.c that might cause
power resource leaks.

In sata_rcar.c, during the error path of sata_rcar_probe():

drivers/ata/sata_rcar.c:sata_rcar_probe() {
    ...
err_pm_put:
	pm_runtime_put(dev);
	pm_runtime_disable(dev);
    ...
}

And similarly during driver teardown in sata_rcar_remove():

drivers/ata/sata_rcar.c:sata_rcar_remove() {
    ...
	pm_runtime_put(&pdev->dev);
	pm_runtime_disable(&pdev->dev);
    ...
}

Does this sequence leave the hardware in an active power state? Calling
pm_runtime_disable() immediately after pm_runtime_put() cancels any pending
asynchronous suspend work.=20

Should these paths use pm_runtime_put_sync() instead to ensure the idle
check and suspension complete synchronously before PM is disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810132502.4605=
66-1-vladimir.oltean@nxp.com?part=3D1
