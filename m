Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30E01C6F75
	for <linux-ide@vger.kernel.org>; Thu, 10 Oct 2024 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550798; cv=none; b=XHSC5St2zx/RmxypKZFQV9LuHJsz7spNPSvp0LvJlteiV116t6fYI2/xOdcDzcH/j61E36raMHnbq71b1wHECKZ5wWLWnMGAA83SjxejR+gxf19/hhrM7pQAStwXXEQ9QzW+/fVyD/xzgWmttR2hOtG60fQz9xkNrIvVbnBP+Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550798; c=relaxed/simple;
	bh=T0825uOMcxE4K6IFTeIaRBpdBgp7WH3W5HjkhQ62aZg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WTdFHJEYXCfTtGrHNzFy6eSUK1uKjXl2ldGUuvgsu9RuaCMe07OQMJnRTIV5cBe25Ya0TAj2KvTsUvKq/YuViU1za9klboq/OB3mA0UtuFaoKOCNoX6P3dSRt7u9sowXJIb3XWHE52eTRvXpFGaiDIFKJuqZ2Kofbnoj6fS+mww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKQyaqXu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKQyaqXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4076C4CEDC;
	Thu, 10 Oct 2024 08:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728550797;
	bh=T0825uOMcxE4K6IFTeIaRBpdBgp7WH3W5HjkhQ62aZg=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=UKQyaqXu7/9dMtKIoDBDgsxEIZ7tNeNtbAGHD1IvEHluz4pHq656yhLgDuIPkyjJf
	 9rKAKajheoW9Y9OpSLZFOmXFI1CXEttgcmMmrG3BHvmwm7XL+rkvhUgr8mqK0LDHfN
	 V9yja89s/AszlgIsI4CTLxfAfcpVIwg/HBiWffCJcAUBuJs6rwWoJFRFpVt0VkCEEP
	 yI5jpZ9SdX4NUZ+gM0R8E9c4Uc932HsB6aQB5AAxO19EP+dSXsviKMLv3Zz4mCXgxj
	 w3xey7y1e7UAzOLDXlBTZSMQYgiLgc5qjjN3QzPw5jDePa/nmlHdmlRqaCUsjwqUFJ
	 wnCGZLg+Awr6A==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
 Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20241010020117.416333-1-dlemoal@kernel.org>
References: <20241010020117.416333-1-dlemoal@kernel.org>
Subject: Re: [PATCH v2] ata: libata: Update MAINTAINERS file
Message-Id: <172855079632.1800289.17110837101151672861.b4-ty@kernel.org>
Date: Thu, 10 Oct 2024 10:59:56 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 10 Oct 2024 11:01:17 +0900, Damien Le Moal wrote:
> Modify the entry for the ahci_platform driver (LIBATA SATA
> AHCI PLATFORM devices support) in the MAINTAINERS file to remove Jens
> as maintainer. Also remove all references to Jens block tree from the
> various LIBATA driver entries as the tree reference for these is defined
> by the LIBATA SUBSYSTEM entry.
> 
> 
> [...]

Applied to libata/linux.git (for-6.12-fixes), thanks!

[1/1] ata: libata: Update MAINTAINERS file
      https://git.kernel.org/libata/linux/c/0df4b9d9

Kind regards,
Niklas

