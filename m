Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C1C364055;
	Thu,  2 Apr 2026 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775154128; cv=none; b=u6y0tLKVnj4UPKNSqOyygndtkfG0Wcj2Ivl5UCXW07Djjl58FZesvdcPHUggmyK9s9E4SpUCBo7rumt7rfi6hbScSYOZRejapiZ7RKUu4OY0aT0YmgCqj0+Gd1m8mOlxTqDpeM9vI4qnhp6I3EcmgYySEJReWSZf0yvCtti+5IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775154128; c=relaxed/simple;
	bh=ooH1GT+43tDuw82oe063FLCgWUw3xjlNS6lVLKGk6fs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hajbaO/z0A7iIbSHJkd+Nks+P2rtMifd+4Kh7rdKDPTuQP8/f1bMxQjQW7KZgtLw6PBonfipA6Ek4i6EHsRN+aZJD2weG/RWiQjJcOtozwkmAhvKM7jNH4/ke3vXQ4OCEbeglrZPMzq7ebZ/h6qZVWC2BW/D1LGZEQLCZKYgz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lu1EaqXE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lu1EaqXE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF85CC116C6;
	Thu,  2 Apr 2026 18:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775154127;
	bh=ooH1GT+43tDuw82oe063FLCgWUw3xjlNS6lVLKGk6fs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lu1EaqXEBiOwF3chliJCCEL2DN4XcoTpcmwnf1dI6FOOhpkDQLjtG650Gq01Hss3L
	 K7MuytVBPuGCvaM13AG6Mljgd4wjz5osTx2zx5x8XQk50sLetoNidTHzrqFF4Ji4ah
	 r6bwUzZbZ8wsMLrHN8PK4Nh5QQoBevnGE5gPkR9qimVc+TQLpGFd9S22Av7LdEcJSx
	 uFE40B6qsvqGnh1ool4obvVMyeeRfqWZbwPvPG9IM969BW07Df+q5CAy8RoBGjU6nt
	 ic5vLFjieLE+napwlkHMAfikTsEYifEZ8Zqzjm/PYbfUSjod7BFJmn0m+djKQ+zfJd
	 357X5p0egHTHw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Igor Pylypiv <ipylypiv@google.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260402160705.1033273-1-ipylypiv@google.com>
References: <20260402160705.1033273-1-ipylypiv@google.com>
Subject: Re: [PATCH v2] ata: libata-eh: Do not retry reset if the device is
 gone
Message-Id: <177515412664.2799064.7393928085063195647.b4-ty@kernel.org>
Date: Thu, 02 Apr 2026 20:22:06 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 02 Apr 2026 09:07:05 -0700, Igor Pylypiv wrote:
> If a device is hot-unplugged or otherwise disappears during error handling,
> ata_eh_reset() may fail with -ENODEV. Currently, the error handler will
> continue to retry the reset operation up to max_tries times.
> 
> Prevent unnecessary reset retries by exiting the loop early when
> ata_do_reset() returns -ENODEV.
> 
> [...]

Applied to libata/linux.git (for-7.1), thanks!

[1/1] ata: libata-eh: Do not retry reset if the device is gone
      https://git.kernel.org/libata/linux/c/182caa17

Kind regards,
Niklas

