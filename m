Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5415451A73A
	for <linux-ide@vger.kernel.org>; Wed, 16 Sep 2026 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568740; cv=none; b=rQBnHZmmRHEEMoLKfbgoHvl0uACBDMH52djWP/Y2q1+o/vHBLlj9IYSJZu1uJjFOPyxzPfbcoUiuvWFrlrXhrV4LaDkYhFcSSKD453hTUBVGmwuCeR1QDR4lsBmROyMmRUl8XjmCvY9vEWblfmYdeOgnkQqHE+UyejzwIsTjPgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568740; c=relaxed/simple;
	bh=ci7kATO+I13LXXwO5JPn5SQMmu2C/sZxXNSy71kU3Nw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QNMP+StcSxrP6U7WLfJgRfDk+PNUuOerdNrcQdfAMC24DiIrKeThskZQvI2bLQN+XlziHy7viEgI63pdi/gVj1mozcwyNIip9i1GN63uE7N44fsgXgpznngt2l/G8kp/olmD2CtRW7VcqeMEPKBDf+WOT3HQa2xXrLxNeDjRvDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWvkyTCV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWvkyTCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1ED1F00893;
	Wed, 16 Sep 2026 14:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789568739;
	bh=YfuJet7XfG8p8Mt0RjpkZmF+sfzjG3mOfqKVV4EErss=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=eWvkyTCVK9U+3lsVX2UMlzciIluikb0qJGBLV+pnMgUSe9hpf6/zPQCzMzoEzUWb0
	 owtGiTpo9UZdcYXFD1pnDQ8cHtjK0iVE5UaMVggY3SHlmm6oZ3vKu03Y2T01fjegW0
	 9XPmFP26Il0K5I1tnT6Tzdfm50wNlT5HqZH2jjGIu4gYl/avljmZl5KszhWGkXBpgZ
	 QkOb/MDhe8ztw2i8omdqynxgSmnmUXko2c57Djpsh+v8XLRzsXzhrNTTXRWR7WdnWW
	 D4nI7LaPoIInpO58x9PvsH8PzIdHpGK2FtX2lDYfQqb7T76bv4MdN9hgsOZnLInxQS
	 XnEKqJ1PE/J7g==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>
Cc: Thomas Huth <thuth@redhat.com>, linux-ide@vger.kernel.org
In-Reply-To: <20260916130031.29990-2-cassel@kernel.org>
References: <20260916130031.29990-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: libata-scsi: fix ata_dsm_trim_pages() kernel-doc
Message-Id: <178956873766.42681.2080354340360015288.b4-ty@kernel.org>
Date: Wed, 16 Sep 2026 16:25:37 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Wed, 16 Sep 2026 15:00:32 +0200, Niklas Cassel wrote:
> make htmldocs fails with:
> 
>   Documentation/driver-api/libata:604: ./drivers/ata/libata-scsi.c:2301:
>   ERROR: Unexpected indentation. [docutils]
> 
> The Return: section of ata_dsm_trim_pages() ends its first sentence with
> a colon and continues with an indented bullet list. reStructuredText
> requires a blank line before an indented block, so docutils chokes on
> the list.
> 
> [...]

Applied to libata/linux.git (for-7.3-fixes), thanks!

[1/1] ata: libata-scsi: fix ata_dsm_trim_pages() kernel-doc
      https://git.kernel.org/libata/linux/c/8d836581

Kind regards,
Niklas

