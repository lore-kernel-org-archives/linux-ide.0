Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467192980AC
	for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2025 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558820; cv=none; b=S90mwXuzSGJ6ROa5xZ8IKlTcZYEHyQWx9PSWQFMZmlkXqimmx3+HPnCV4x7X4cMDO8K1xXxrGc+8ucqwrlymNctjxk0MA/4BCHN0aCn6YqufARUp8q66e92wJnKGyCa/dSz5VG9mP6VGyyvbpK6mYCdx0QZZ1gvH6MywxvUMryM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558820; c=relaxed/simple;
	bh=ui5pk3o2mGoTs/C/hOlhvKkRYKzWvjD9Gpv55BTGBg0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Sbt2x3yOXIlRw0KaLGaK37DA37AhqK0UkYpw76e+WrwgWW7e2houTssBhqF4FANLl1Ao9A5rrKXhffoHAcQzmY36xf5b+c+SAW6pzAEwlwj0mAgJ/oH8lW7FGNXk+oodB/EXeYyrT+PYFKe6IJA/C3ukjOucmVK+q5CqqVkMfAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBtGF4ST; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBtGF4ST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7325DC4CEED;
	Tue, 10 Jun 2025 12:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749558820;
	bh=ui5pk3o2mGoTs/C/hOlhvKkRYKzWvjD9Gpv55BTGBg0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uBtGF4STsKIZEUwnfn8UDGGv9o2Gm3eBojxpYXoy2w7DKPikXam1E45i1meULR6GU
	 iKG+ZVLwOwRYhjPryV/Tb/dSOFi/eHlo7u9fa8u9dlhz7Ec/YSCGttPbnnaeJHnD/n
	 EiN9qHjAqkoLAnc6B6hTADc2ihx2IoZhVWXUSTk3CDIqmt26JM+1Mav2JVdx4+HmNi
	 PrWHx+w/2KZtKZEy80XWLLd0HrOs27fqX1cCnVoS5KoMieBsXBfV+vuIfBXAAoWOet
	 QoANEtQOr3AjCH+JviAF8aSeaFvEjfabpq05dTsDGV8D5lFtG/X7hCr+AZpajH4kYT
	 iuDXgwInilGAQ==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, Tasos Sahanidis <tasos@tasossah.com>
Cc: Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20250519085945.1399466-1-tasos@tasossah.com>
References: <20250519085945.1399466-1-tasos@tasossah.com>
Subject: Re: [PATCH v2] ata: libata-acpi: Do not assume 40 wire cable if no
 devices are enabled
Message-Id: <174955881920.1439612.3983026713002170732.b4-ty@kernel.org>
Date: Tue, 10 Jun 2025 14:33:39 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 19 May 2025 11:56:55 +0300, Tasos Sahanidis wrote:
> On at least an ASRock 990FX Extreme 4 with a VIA VT6330, the devices
> have not yet been enabled by the first time ata_acpi_cbl_80wire() is
> called. This means that the ata_for_each_dev loop is never entered,
> and a 40 wire cable is assumed.
> 
> The VIA controller on this board does not report the cable in the PCI
> config space, thus having to fall back to ACPI even though no SATA
> bridge is present.
> 
> [...]

Applied to libata/linux.git (for-6.16-fixes), thanks!

[1/1] ata: libata-acpi: Do not assume 40 wire cable if no devices are enabled
      https://git.kernel.org/libata/linux/c/33877220

Kind regards,
Niklas

