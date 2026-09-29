Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C8C4AF692;
	Tue, 29 Sep 2026 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672298; cv=none; b=sKQwdojyEBfhS6R6ARCLdyYds2YIWlBDTHt/L2Y44m7KCnJ+f5kETVVZFUcDLycEy9zJDa3CC1P8RX2lUDMop790sO440TOVPMa+Y32v7+4k4kShmAHR/pmKcf1t28oOCd4jaTfE/5P95wVJ2RhRda/8pl285OY1R+3upPB3bWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672298; c=relaxed/simple;
	bh=ytqSed9xnm4iyX5QYCm733vxTNzxg4otFQRRTWelMwU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l4FxdUtooSj6U4/5uIPpDnWfH441UQqL8xUTwTW2+AunWj3SRozQ55a5ljdDTCk6G03lIk4UpcQVNyCXLMzK8r+srF3zr7J6C3DGtnsTL2Bf51boX7++XiRiczTC/iaBkHddE43rkceri7DSgwvhaeeLtzGD9jKK7Z6VgEFzMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRLI/8cw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRLI/8cw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A031F000FF;
	Tue, 29 Sep 2026 08:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790672297;
	bh=VzaZ3cuRUXj1zxxv3zrlFAQLqSrbbccojoR61/yuPJY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=LRLI/8cwq5sBCYMq3rUiYXb/e45JYJ5WliVNAhS9Iuvgoos93k3u6z3SLtWzh79h5
	 0kokNq3KOBtrQvS+8tDrt8kn1Tsnhcj3IXN0FzKtCeNJlNuDEnCoz9joQjSNXzVrVN
	 MB7SpSb779E3lqJEMEe3WWwQ71AeLeF2qjADD8Zx3mWW4Ss0pAp9tz9xtiOtyPYvDb
	 AiOCfdtZ4ayrLXpTD7HsEoMFWFff1eC3afCq2e9IR43PSQFJcj6gW3Qk4sHDlviVtF
	 Timh4bdeiPXHs2Xl19X2EsZ7rqrRx1I90vpSlxKX5zW3hmZztDL6okg7b+xpMJOqbd
	 n2lM+gSwdwaRQ==
From: Niklas Cassel <cassel@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, Bart Van Assche <bvanassche@acm.org>
Cc: linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, 
 linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
 linux-ide@vger.kernel.org
In-Reply-To: <291519238580d795929d44437f3c863403d14e1f.1790359497.git.bvanassche@acm.org>
References: <291519238580d795929d44437f3c863403d14e1f.1790359497.git.bvanassche@acm.org>
Subject: Re: [PATCH] ata: libata: Fix scsi_done() documentation
Message-Id: <179067229552.862993.11923464516609418725.b4-ty@kernel.org>
Date: Tue, 29 Sep 2026 10:58:15 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Fri, 25 Sep 2026 11:05:43 -0700, Bart Van Assche wrote:
> In 2008 the SCSI core was converted to use the block layer timeout
> infrastructure instead of its own infrastructure (see also patch
> "block: unify request timeout handling"). Since then, calling
> scsi_done() while SCSI host recovery is in progress has no effect.
> Originally the REQ_ATOM_COMPLETE flag was used to prevent double
> completions. Today the SCMD_STATE_COMPLETE flag is used to prevent
> double completions.
> 
> [...]

Applied to libata/linux.git (for-7.4), thanks!

[1/1] ata: libata: Fix scsi_done() documentation
      https://git.kernel.org/libata/linux/c/cfce1dc6

Kind regards,
Niklas

