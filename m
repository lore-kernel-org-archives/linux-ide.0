Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F0242056
	for <linux-ide@vger.kernel.org>; Thu, 17 Oct 2024 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152844; cv=none; b=n9PWF5yrfjrPoOezg2SVa3DOmn7f0E2kflkIzsN+arQs69nnISjP0LYvnvw9J9imvJ1fTJzZ/wiQGeyu1VJP0B/eQU1KU9Dbp5TJ828Wi+Kd1TUOVhAugaETO0SZvB9Mp26kJ5xq0NkmOVLOAAh0/4DOPU8xzki5Asaiu7y7OWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152844; c=relaxed/simple;
	bh=JuckAjaPpzB+CG/fdZhkrpiPi7nbIPxNV3Uj3QqYRVs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gzqYm1dzOGs16gH5e+cvuRuVpY7lpYQo++ZtjZhNJqxa8PmAI0VzTGPizZnWttH7OUckKOqHhIhrX1HcdsRBWLH00m8G6/7XIm91UBCXn7S5D+9maJrdpXIQe5YU7avveDqnMA8mXhI/ijT3X1kZ5y/ud5d+5qHyCpuzDsg5em0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEpIFtv6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEpIFtv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6175C4CEC5;
	Thu, 17 Oct 2024 08:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729152844;
	bh=JuckAjaPpzB+CG/fdZhkrpiPi7nbIPxNV3Uj3QqYRVs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TEpIFtv6GBtLRJ/WY92F+y1iS8rkFTIsvRI2czBzXBVtpcGCz0rGsmX1emeSnGG/a
	 T4vuq3lyXPsKODLS4PPMw/GBj9etGLFRCZLv/pQr6AhhoDrfkmtoWLW1v5bmFBv/wW
	 ykjVnBPUlGkXy1ATrK5uSNcLtR22ZjwK6zcbYPA1IHwzKGgbzhn4RdmeR8zH6cYxod
	 7ThJgKbawKu2zyJnJ1pJa3ZqKb8Wk0k3+aLzG/+71EzZfDvKrT33oCqu8ak/2iActk
	 YBfGjZmzIoecpGyBeYywd51gg1xFt7JiUAGuochyIf8zbNP5WG9XXq2RtAu/uVheUk
	 kTJ2iqE4534nA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-ide@vger.kernel.org
In-Reply-To: <20241016141609.27329-2-u.kleine-koenig@baylibre.com>
References: <20241016141609.27329-2-u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH] ata: Switch back to struct platform_driver::remove()
Message-Id: <172915284345.3923532.4985967072991759003.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 10:14:03 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2

On Wed, 16 Oct 2024 16:16:10 +0200, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/ata/ to use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> [...]

Applied to libata/linux.git (for-6.13), thanks!

[1/1] ata: Switch back to struct platform_driver::remove()
      https://git.kernel.org/libata/linux/c/2d910fe1

Kind regards,
Niklas

