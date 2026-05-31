Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3363C1F
	for <linux-ide@vger.kernel.org>; Sun, 31 May 2026 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780236035; cv=none; b=lpmBXldNccbK57Dp9CVm16iG7/Rh+/pqV7cr9kE1DKZrPbp/5bmHadml4l9uoGqZz1rJPW495eTlXioYwhPm093FN594F3fFgFWkeRQ1ic1AhvJUlV+xDEpAxmUWw162651cR7uxdQdJ53IqKJ1sp5mHJkdqN8SUsOTh3wb+ZUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780236035; c=relaxed/simple;
	bh=lO4T7LpxBBEzg0rslFTrMKJE2H4aLnLgKs7j5/nF7AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtsnH4Gj7GeWtE3bvIo28t8eAHBk4vuiHtC2Xetx7hzhxm1q6x6yJt9k+2OInnpvpbES6V77SXdhiYK+s4HpaJvAUpkBjudkvLru0WZtOt0+fRqLKKEu6my2HgSaipvfn65q5fjypRcDujotaSB+xr009LUu1A+f1SMrhLUHVuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEhUBg+M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEhUBg+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3911F00893;
	Sun, 31 May 2026 14:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780236034;
	bh=ptztKX4rKWtHQPhOy8Os9N7vzcQ/uvh6jeMno/dGunY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DEhUBg+MYepKzT+6MFfQ2rbzx0IWun3OSUBhp2H+Yrfv24kivdcpNqHAyJ6ub1JS1
	 8JWbZY4MAmW5cHCQDuZMYZSYpADgILXMVj1E9gLzEO+3ZTPRgR0GUYe06DMiIsWPEF
	 JSzhVRuVlATl3CoAqgkaMdygMEMJJl3gSb2AElUjvqqiA1Tnh4VNCkOqjhdP2BALt8
	 p0srfHf2LyOFTyO+TWnGmXEXsHn3E0b9colcyLhsNer8cAnNtTnSrU2w6YrSaIAvSJ
	 1hwEjROQN0iCcL5KyZpZ7g2tJzjIeUxDunYDIXpXAZN/MkIB0kWIsID3BWAr0Slh98
	 v1aU2hd85wAtQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Marco Elver <elver@google.com>,
	linux-ide@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] ata: add __must_hold(ap->lock) annotations in issuing path
Date: Sun, 31 May 2026 16:00:23 +0200
Message-ID: <178023548968.927595.14698720079448094581.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528172855.703631-5-cassel@kernel.org>
References: <20260528172855.703631-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=649; i=cassel@kernel.org; h=from:subject:message-id; bh=lO4T7LpxBBEzg0rslFTrMKJE2H4aLnLgKs7j5/nF7AI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJk7H68Tl4x2bz9qmFTq/yNWc/+b5JmzL7uHdLH8OzTx r26G+RDOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjARgxSGP/zTFvrLu+qw+n1Y PoHVXX916fSXjDby6tvClG9YPM/+tZDhv++8tjV3uTmCJp2/vSFP+dQ3qWUG1+pkDMo7LnQejD2 zmw8A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

On Thu, 28 May 2026 19:28:56 +0200, Niklas Cassel wrote:
> This series is meant to be applied on top of Bart's patch that already sets:
> CONTEXT_ANALYSIS := y
> and adds __must_hold(ap->host->eh_mutex) for EH functions.
> 
> 
> This adds __must_hold(ap->lock) annotations in the issuing path.
> 
> [...]

Applied to libata/linux.git (for-7.2), thanks!

[2/3] ata: libata: Pass ap parameter directly to functions in the issuing path
      https://git.kernel.org/libata/linux/c/ebfb3924
[3/3] ata: Annotate functions in the issuing path with __must_hold()
      https://git.kernel.org/libata/linux/c/28cee4cb

Kind regards,
Niklas
