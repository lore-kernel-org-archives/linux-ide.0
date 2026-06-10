Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F81538E8A3;
	Wed, 10 Jun 2026 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781077367; cv=none; b=gPbsegsRph5NZqd56nuspby9OIknxe7ukxYmCsamBZCwNWReTUpEoxI8MEMDU++BvYlUCX+ovjVgRneUMzDyFrMCYBZpGStyvzBD3HiYzvHc5EP5TbaOpdV8kJ4ase5LEB3kueUNv0pE7a8PQxKwuJbcUOhJgwXOzGWFoIwxy9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781077367; c=relaxed/simple;
	bh=OPkFPZYeBihskAmIYiygGBHSBNTM2Y5gg5k8wwif1s0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uW7trhSK1FeUVTa15SIHKObdGRuHPxG2n/73L2zEOVXvipmKX3r7cSYp2LSXYcKLUoI2IdeF2awy+PjJ1APgwhWoo+M1x9cSUiVOKxa15Dd1h74Bkbe/WTcSklEhsjhd4KSjr4F6bNbxEnIKqr5tNdKDY9wn6p8XuBtMEkM4kGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mY3fxI12; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mY3fxI12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DF51F00893;
	Wed, 10 Jun 2026 07:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781077366;
	bh=5hkjgTzMvI68eRzwxxhWMNZCvPZAz2SsUE+TKW9SnLE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=mY3fxI12GWuL1TmOhLAFfInyeNFcblXSEmCzPR44ehzrThPzC+/mDz+qCF6JmZyDI
	 AvXxKDbzUpOTvB5FtlXn20ZIedy9jIUYRtAiRyPH2MgsfLy/+BgB5cqeVonFwHk9DV
	 htM1v/233s3sWQREXbamyEQsg2+4qa99PpyIalJvuuiQdaPrK1QeGpl2L7OLGS+xV6
	 eSz5mYzmOH+ayLM7DbnnhNJd++XqgvBe0UaQDQbcA+RvO62Yz61/Qo/Ve4Bs0+B5Fb
	 ISQ4rL4mA+zLtUaEGw1MVkHwnerv+xqJO7wwA6S+nBBRsu8ZXJeddLh9d4IG0HYBEx
	 wNJzAXyo4QHNQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <395c2f2ed11614410956337fd0e10b7adb47f8d1.1781023750.git.u.kleine-koenig@baylibre.com>
References: <395c2f2ed11614410956337fd0e10b7adb47f8d1.1781023750.git.u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1] ata: pata_isapnp: Drop unused assignments from
 pnp_device_id array
Message-Id: <178107736506.519042.7921631931830766505.b4-ty@b4>
Date: Wed, 10 Jun 2026 09:42:45 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2

On Tue, 09 Jun 2026 18:51:13 +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Explicitly assigning .driver_data in drivers that don't use this member
> is silly and a bit irritating. Drop it. Also simplify the list
> terminator entry to be just empty to match what most other device_id
> tables do.
> 
> There is no changed semantic, not even a change in the compiled result.
> 
> [...]

Applied to libata/linux.git (for-7.2), thanks!

[1/1] ata: pata_isapnp: Drop unused assignments from pnp_device_id array
      https://git.kernel.org/libata/linux/c/0a77385b

Kind regards,
Niklas

