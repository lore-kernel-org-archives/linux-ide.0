Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E614C44CADF
	for <linux-ide@vger.kernel.org>; Mon, 24 Aug 2026 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586118; cv=none; b=T8Z4UEpc9HWSWZTFHmouPSKw4qSBIiEtA1PtZL0IrMJAyViTpje8h2OZ71vDK3/y4gHR7urJ2lra0/3OFzKcflV8geq3SQgG2phqlaC5hkAINjfZINDtxSrjcbFEiFFgRwlvDF9CYQgNd5FehxOHX0KkXYkMqv/5SiW9FwlT6Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586118; c=relaxed/simple;
	bh=GI7X0hDCX4xYOR0/FpaapsJtiwCu4ZjSIP3WhjyoC4A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UfpfCsxlKckpu6xgTA61HRKODrHNQtSLyXKe7FFYcGGgf/W11ftS9fqmgn1egUHh/WJclTgw9rFQyirwUlCyTI+3fDk0jGZDKQ7RfqMymCnUlofUbEjiuHX3WImRR6rAF8EVjsdIjlXPNNHq3W03JHd6KzmuUgGLM9sXpk8ne4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A72gUnDO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A72gUnDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F41B1F000E9;
	Mon, 24 Aug 2026 15:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787586111;
	bh=GI7X0hDCX4xYOR0/FpaapsJtiwCu4ZjSIP3WhjyoC4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A72gUnDOVyPu9TKo6pgL844wnltzNYBS2LUO2e9hDPK1RocVmI0lZNJmP/U/I/8tB
	 QTygL9EJfgArYHEChfeuimPoC7N8MUv1euW4bwAsSuypLrn9zeir7KKx+k9pdFwj1h
	 /93elaKb091o1CgjaNJlQJ7XdhQaoISRIRHWuim+F88zLYwrJu6nY1UfM37Gj3OL7x
	 KtgwVCkCNgOuSPmhn6j6yk8GOiEeThjCtaMZMTsuAiVuuyLezBi6REwBOUH43Ff1xE
	 /rLoXgVwsxyRG/BnKhk9hS6tZgz3/cQ4AdSEjGFVgzxCuTjM0xlNF8FTEaDXxqsAJz
	 tlqYv6/xtMCwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] ata: pata_cswarp: Add Amiga cslab ata support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Pisati" <p.pisati@gmail.com>
Cc: linux-ide@vger.kernel.org, cassel@kernel.org, dlemoal@kernel.org
In-Reply-To: <20260824153339.512487-2-p.pisati@gmail.com>
References: <20260824153339.512487-1-p.pisati@gmail.com>
 <20260824153339.512487-2-p.pisati@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 15:41:51 +0000
Message-Id: <20260824154151.9F41B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing NULL check for ioremap() return value.
- [Medium] Resource leak of I/O mapping on probe error path.
--

--- Patch [1]: [PATCH v5 1/2] ata: pata_cswarp: Add Amiga cslab ata support=
 ---
Note: The format of this report is altered due to recitation restrictions. I
will not quote the original patch code directly, but will instead provide a
free-form summary of the findings.

commit 50c3007b9ddccb0c0a488126c545810ad538a593
Author: Paolo Pisati <p.pisati@gmail.com>

ata: pata_cswarp: Add Amiga cslab ata support

This commit adds support for the on-board IDE interface on the CS-Lab Warp
Expansion Card. It introduces the pata_cswarp driver handling initializatio=
n,
data transfer, and configuration for PIO mode.

[Severity: High]
In drivers/ata/pata_cswarp.c:pata_cswarp_probe(), the code calls ioremap()
but does not check the return value before using it.

Could ioremap() return NULL under memory pressure or if the vmalloc area is
exhausted? If so, using the returned base pointer without validation to=20
calculate static offsets (such as base + 1 * 4) and assigning them to the=20
ATA port's IO address structure might lead to an immediate kernel oops or=20
exception vector table corruption on m68k systems. Should there be a NULL
check immediately after the ioremap() call?

[Severity: Medium]
In drivers/ata/pata_cswarp.c:pata_cswarp_probe(), there is a potential
resource leak on the error path for ata_host_activate().

If the call to ata_host_activate() fails and returns an error code, the
function exits directly by returning that error. Because the base pointer w=
as=20
mapped manually with ioremap() rather than a managed API like devm_ioremap(=
),=20
does this leave the I/O mapping permanently leaked? There appears to be no=
=20
explicit iounmap(base) in this specific error path to clean up the mapping.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824153339.5124=
87-1-p.pisati@gmail.com?part=3D1
