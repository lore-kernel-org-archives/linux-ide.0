Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC26417366;
	Mon, 12 Oct 2026 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791803755; cv=none; b=NXIZMIcp2gLOE9labhIWZdr/ijLHXpWpVrVD5G0sloWx4Aa1U0obdupoi8ztOlbyXlz4VwAvMVYWhOOiywNslhtyr1oIaWc3R/2Y+ITOuyTrdLdgRIVR+tNZh+npp+6a0LlPxBRn5iEKBXzvpGhVV30K8cA9PSA5VrwTSNw11QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791803755; c=relaxed/simple;
	bh=JBxvTGnOH4a/k2KqFWX8iYjAxzSA+sEe2qSeEJxpEOc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MPfwZr1stzgVvks/A/+0/rE8rHflvlvYoTCFQL9KqcJMWS8og2+DgogF/HsFrMvUTzxTPkeAaXfWj5ucs9W0vuQVnev6Fix03BUAqHKD11L3bMwkaw6yiqcbrzZHp2VaRI1fQ/zo9HxcZyQOMMDW4WHogRN4EKbf0rvZCWsXyao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBRapO2c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBRapO2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6C71F0089B;
	Mon, 12 Oct 2026 11:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791803754;
	bh=PlFpmrf2MIPEq2Yt1WSkJng4FI9M/8qXY380L3y3Xxw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KBRapO2c0MKYJU0KfQtjXBHWHvIsrzdWwh/Wob7AjE523X+zj0pfRroHVIFuQq+bU
	 rnBnwiJiTdRavJI+VhX6/axjmZ+PD9Rgk5YDGs4rY8h+YZaxe3UPSBaMTMFn2TKNDF
	 NF2p0m4J7UxYxGp9tLAHVElEnWDxnAAsNLzeoyUSoJt8DidNM58WTv5fA8f53OPZNa
	 agx3Gr1KvStwZVrdxIg6j5LBPKc2w+rs220cCdLXZE1pxel2bptM6A0mg57bemXmB4
	 VvqQR2vCVbIsi7QjGrtdMOJ9fSNMRwmRDot0Nr6O7MAsSA453JeilQDmg5shoIAZi0
	 +SsE9WYoC9mzw==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, Kyrylo Biryuk <illofspeed@gmail.com>
Cc: dlemoal@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261012103917.389-1-illofspeed@gmail.com>
References: <20261012103917.389-1-illofspeed@gmail.com>
Subject: Re: [PATCH v4] ata: libahci: re-enable FBS after error handling on
 a port multiplier
Message-Id: <179180375308.3361750.14419165345521200532.b4-ty@kernel.org>
Date: Mon, 12 Oct 2026 13:15:53 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Mon, 12 Oct 2026 12:39:17 +0200, Kyrylo Biryuk wrote:
> ahci_do_softreset() disables FBS before resetting a device behind a port
> multiplier, as required by AHCI 1.2 section 9.3.9, and re-enables it only
> when that softreset succeeds. If it fails, for example because a
> hot-plugged drive is still spinning up ("softreset failed (device not
> ready)"), EH escalates to a hardreset of the PMP link, and nothing turns
> FBS back on: only ahci_pmp_attach() does, which runs at the next boot.
> The port keeps working with command-based switching until then.
> 
> [...]

Applied to libata/linux.git (for-7.4), thanks!

[1/1] ata: libahci: re-enable FBS after error handling on a port multiplier
      https://git.kernel.org/libata/linux/c/21d333ab

Kind regards,
Niklas

