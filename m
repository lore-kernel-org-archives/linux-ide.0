Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8480325483;
	Thu, 28 May 2026 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952199; cv=none; b=lXBkhckDD0XroyIGPy383tYd3xCzxNR1vWG069n1OvMbcRfjL5HfW9pRncr+gYMB1CgL7z8L/PPiY08lEbyQ0nuNSgnEQ5YE9fLIZ8qj6c+p7H9/FpnfPhBVWE1mSeWVdpCVchfUGo3H31pEhDZcy7VLMurqPWxg3LVrIfIaBqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952199; c=relaxed/simple;
	bh=nQxAvfQtdZBFXyup409YXZIaE/435lj8EcH7N+NIY8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7ZvOiQLC2+3MfYLPDJXUo/OaFWPtTo1bAYebOIJzU3IOvNHL8bRGhlkCEmdbyq2DCRESYRVu7ZwYrsEsynK7ZFJEQynTdqj4bwSOpnYdW8xXtvn/bQQMzCBjmwG0XeO7TKWAoaAlzDoUTxwyOutVmTmUVH6hRe29ZcGYba1b0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHBwvGqU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHBwvGqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1492D1F000E9;
	Thu, 28 May 2026 07:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779952198;
	bh=Q3o6nnd+bHzYV+50uSFPmYDvCi1rLKCA27OZvR2X7wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JHBwvGqUiS9euFyWDclaJ8VHpBmvXJdNluKvyXsbBf+4VE0WhxGgmcr9hxYK0z+wv
	 em+FDsg1nIdndsc83Um60bImLqqIVS1C0lPLuoTd+IWNzlKhUQ6Qym/zeRKlPyAFAf
	 HZaSLfjR3yeb2tBDqRPcrVUg+PoD1eBSiQF4gStEGPY33zQWyHnzQ7xSudOF0/r0w8
	 831/QEpNaqlcNJM631GpyRiSmgArCHflf/keJMz93RccuJzmJJ7lAwacFxwdh+pL9+
	 2pWpftIo9QLg8qpef3DcjLS/YHykg78pWQC70DwQYYxPrIinEKVCJzpNsvPc+PARVD
	 0sdFcDgWieGdw==
Date: Thu, 28 May 2026 09:09:54 +0200
From: Niklas Cassel <cassel@kernel.org>
To: yangxingui <yangxingui@huawei.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-kernel@vger.kernel.org,
	liuyonglong@huawei.com, kangfenglong@huawei.com,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-sata: retry hardreset when device detected
 but PHY not established
Message-ID: <ahfqQtalkjBuMa9f@ryzen>
References: <20260425060447.1312763-1-yangxingui@huawei.com>
 <e8d237bc-7191-4881-924b-86a34ff0f3b9@kernel.org>
 <a118114e-9828-06d6-d38b-2b426c92bb14@huawei.com>
 <33299d0d-d863-4e00-951e-4728ddc823e2@kernel.org>
 <0539efac-d9b5-4f95-eecd-b88cb3cb8724@huawei.com>
 <66bc004a-4a18-43d1-b296-463ea72cbc85@kernel.org>
 <c78f6dad-b0fe-a2fb-8458-9fe182cd6b54@huawei.com>
 <afMW2scJrBSI_jLo@ryzen>
 <b241ef3f-d476-12f2-2862-ca95ff509046@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b241ef3f-d476-12f2-2862-ca95ff509046@huawei.com>

Hello Xingui,

On Thu, May 28, 2026 at 03:01:39PM +0800, yangxingui wrote:
> 
> Latest update: The issue we are currently facing is that the SATA host side
> is continuously waiting for the disk to return the COMWAKE primitive. From
> the SATA analyzer, it can be seen that the disk has already returned the
> COMWAKE primitive. This may be related to poor COMWAKE signal quality,
> causing the host to fail to recognize it. Performing a hard reset might be
> able to fix the issue.

I'm a little confused. In your previous update you said that the issue had
been resolved.

Now you say that an additional hard reset (COMRESET) "might be able" to
fix the issue.
That does not sound like you have actually verified if it does so or not.

Perhaps you can try implementing my suggestion in:
https://lore.kernel.org/linux-ide/afMgoFBFPWR0f4gK@ryzen/

which does an additional hard reset (COMRESET).

But please only send out a patch if you have actually verified that the
suggestion actually resolves your issue.


Kind regards,
Niklas
