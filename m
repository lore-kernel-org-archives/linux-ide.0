Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45951212FB0
	for <linux-ide@vger.kernel.org>; Wed, 26 Feb 2025 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565635; cv=none; b=NfpYpq4t3cOWf0lOIv2CAbGwG62M3EoCEqqndy6lXJN82ge3p36pgYpM4dxuGju77K47DFKHyTAAFmdTT/+hkGgEZZ99DFdkO4GNSL/rgH8K0b0u/0eyOmc6lwdf2eJBGy8EuSHAzBdW6sHWxsk0jcu6aGpf6wW89Q7Fm6wZ5cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565635; c=relaxed/simple;
	bh=3fjs4VcbYYga7CMlrfPY0QBAwhY0xKiN2Zv+uA1m6+4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UwMGEpm1OrIdDXLQbIyj03v+zVkoyTYXN0snXmAO3NaJK9OmRIJlD6KngCyWCbRx7Dtp1qJKilHhUzVfUhyAdN3wVqgVsrm1ytjV5ltiZFvwxE7T2gI3UskqImaEzxmXdfXgKojtmHCB00t5cA9QuCJb5NLfzIF7L36UYOdBgyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moPmS2KS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moPmS2KS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEBFC4CED6;
	Wed, 26 Feb 2025 10:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740565634;
	bh=3fjs4VcbYYga7CMlrfPY0QBAwhY0xKiN2Zv+uA1m6+4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=moPmS2KSvK85te2EROrGLbMLw888RBSViVILMJ0USgIQkSohHp1qv1df+xWS0OTiv
	 +6EiB3HCNpjFnN1dCFOYEEBm0e+UOZLjvA6DaDbQBFVG225MyQneahQT4beCB7D0hq
	 ysrmrWSXFgmW4VNxU55zWA6cO9Cwd58etp96DFFrBBIZl2BF+flnWoMPgqIqt/qWQJ
	 UxmPxIHzfDWya5v13WfL/moPYE0Yk/Z6nK0+/ExNzfSOFoZHU1XzbEeAcVsM72gEiA
	 tbCAsaoQ9gfAMvJ7cK3nV3Www6eRUIUCn6wRjMTh2lxqdXCkkv/RUhXasG8KFpFxdz
	 MWuoirJp/uNTQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, Josua Mayer <josua@solid-run.com>, 
 Niklas Cassel <cassel@kernel.org>
Cc: Klaus Kudielka <klaus.kudielka@gmail.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-ide@vger.kernel.org
In-Reply-To: <20250225141612.942170-2-cassel@kernel.org>
References: <20250225141612.942170-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: ahci: Make ahci_ignore_port() handle empty
 mask_port_map
Message-Id: <174056563302.961896.1619345664250522435.b4-ty@kernel.org>
Date: Wed, 26 Feb 2025 11:27:13 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 25 Feb 2025 15:16:12 +0100, Niklas Cassel wrote:
> Commit 8c87215dd3a2 ("ata: libahci_platform: support non-consecutive port
> numbers") added a skip to ahci_platform_enable_phys() for ports that are
> not in mask_port_map.
> 
> The code in ahci_platform_get_resources(), will currently set mask_port_map
> for each child "port" node it finds in the device tree.
> 
> [...]

Applied to libata/linux.git (for-6.14), thanks!

[1/1] ata: ahci: Make ahci_ignore_port() handle empty mask_port_map
      https://git.kernel.org/libata/linux/c/130ff5c8

Kind regards,
Niklas

