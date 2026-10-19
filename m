Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B659F4E77EA;
	Mon, 19 Oct 2026 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412944; cv=none; b=o+YXS34pd0KlNcr/mPvGav8cEnbhwHHDofDmXMCduZlSecxNkR5QntiWrvGTBV11haOrjN+hoijTHrGSKsv32/qmBEXw5HkfFU7faziRG2PW6mfZmPqwr0uVGX8IND2UeJICBuAKDnOgpOD686rnZOiYmmsWAJt2veOk1LuD/yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412944; c=relaxed/simple;
	bh=aqhyXvTzNx5I5WUZ9FD7X+4Oz8LIh3kk1As6n10Kck0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FUz7pbJLCWWVB7cfRAgYK4CbdZUhCV7hW9VNZjKm+KYP470a/QkYwzP4bUGIiCsfdiGi8Ye8TudAQVM6TL7XTpqCazCpFfsK/BDMr51JTE6MJCh3gLViP+6/OZHjd72sr4Y5aZl706Ag3Ny4ebz5bbFozxTBqRZO6jzA1UWONXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKS8ylkq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKS8ylkq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B621F000C4;
	Mon, 19 Oct 2026 12:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792412930;
	bh=iNKmKGYobT3A6cE23USta9m/M3jhHiWb9ViGC8Qr1+A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lKS8ylkq2m/aBj4SFPrZV+adf+K0ghgdkSymID9jh8Fz4Bfs45NU1Wl4Wen5+Qri5
	 QCxUeudRz/YNS5Q3Ou4GpSqFBKWcBZwdBKzi4MxNgPu6mMdh0SCoWdrooGhFKLRa1B
	 lHKYcO6/6wQ2c+qPonNiUBhjygBZDKNmoZWhP142lymSZwVz0coJKhn0/wbE+5Yevf
	 oFVJWuz1dju1ajsZzUQ+CcU24zRoAInHIsAiQEM2rrtRVodSNESSFqVSzOyaIP6umw
	 Du8i9tGGnW85BYQmYxYrL6KYqRRDbqqNuE9P3U7p+MwpL8GS7fuPVgjzSnu+mEfzlx
	 msOQggOx64CAg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Rand Deeb <rand.sec96@gmail.com>
Cc: deeb.rand@confident.ru, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
 shda@confident.ru
In-Reply-To: <20261015194935.1497-1-rand.sec96@gmail.com>
References: <20261015194935.1497-1-rand.sec96@gmail.com>
Subject: Re: [PATCH v2] ata: libata-core: Ignore forced transfer modes the
 host does not support
Message-Id: <179241292859.1142303.12975000399554875054.b4-ty@kernel.org>
Date: Mon, 19 Oct 2026 14:28:48 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Thu, 15 Oct 2026 22:49:35 +0300, Rand Deeb wrote:
> The libata.force parameter can force a transfer mode (pio0-6, mwdma0-4,
> udma0-7) for a port or device. ata_force_xfermask() applies it in
> ata_do_set_mode() right after ata_dev_xfermask() has limited the device
> masks to what the host supports. It replaces those masks with the forced
> mode without checking the host masks, so a mode the controller does not
> support is passed to the driver's ->set_piomode() or ->set_dmamode().
> 
> [...]

Applied to libata/linux.git (for-7.4), thanks!

[1/1] ata: libata-core: Ignore forced transfer modes the host does not support
      https://git.kernel.org/libata/linux/c/abbb03d0

Kind regards,
Niklas

