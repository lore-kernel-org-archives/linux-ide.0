Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6F543CED9
	for <linux-ide@vger.kernel.org>; Fri,  4 Sep 2026 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525284; cv=none; b=V2uKTTw4SQdZSyjYXFpdxUjRbLYNEK0zKGeWm9ONHM6Dm0ifgr1yzT5YUKEDm+YHWSwppTd2JGifpLyzJabCTZPSD1QwjRxYs36SfBsvlLVUdbqU7br1GR3GXLSY0NF21wPDqVNwit5NHUiEVGW5t3fqJtOsTvQXt1Vwi/A1c7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525284; c=relaxed/simple;
	bh=RwU3VXswfmh4KRqfzpDcLSagclpeiwQOXcQDsNmAiLM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r+h9TOjDEHut2W0pUmpxz1kR6RtX5c0p7NdFmPIE6jhWia+zTXzCbIhEGTO+4US1j0nTtsK9JU65DjcWTBry4+S3qM+4r2jaMYasVMop1JArR+qXrUO8wMB2H+gd4vMCAP0wel/FHT0gQxB+9XN96QxjFJFsmxUgfx3FgmDrg3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwmaTrc1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwmaTrc1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979F31F00A3D;
	Fri,  4 Sep 2026 12:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788525282;
	bh=v/cwOVbgbjg91wrRkd3tRjLBVSj9SvXrqeuIjYJqbXA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fwmaTrc15XGW6FzNWSlXigR1P4zLZ1neXVdVDZftNII843u+5IC6ldp4e7qNRs8xl
	 ewW28QWSErkR2pAFFJO051wDQXnuJHFmHoL84oqM5XkQfTnFTCD9bFVtVoscPrFMlo
	 oLk5oOpWkWZJoSL9s/nXesIIIchvvLiuTq2dsSNtNE5Bldmt6AnSrvCDrWjg+bw+tn
	 Xv1t8LuuwTdZU1nBwLsM/8TpebmE17kxEUhToAvu+hOMtQGqyujr7BT3JHiFBKI6SY
	 pAC5sNeXoCUNnjMG4IDSUCQYD0wIo6aDnkfzNjy2MG5sKATJ0BO692o/W0vqYb/yDZ
	 55wWZBRfQEDvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] ata: fix repeated words in comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hemanth Selam" <hemanth.selam@gmail.com>
Cc: linux-ide@vger.kernel.org, cassel@kernel.org, dlemoal@kernel.org
In-Reply-To: <20260904123110.35532-3-hemanth.selam@gmail.com>
References: <20260904123110.35532-1-hemanth.selam@gmail.com>
 <20260904123110.35532-3-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 12:34:42 +0000
Message-Id: <20260904123442.979F31F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch blindly removes a valid occurrence of the word 'in', crea=
ting a grammatical error in the comment.
--

commit 82b3223c0ee5c7c14e26327dc44e83c5226cc9b8
Author: Hemanth Selam <hemanth.selam@gmail.com>

ata: fix repeated words in comments

This commit drops repeated words in comments reported by checkpatch.pl.
It only touches comments and makes no code changes.

> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index c154103d892c3..bdf25c535c07c 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -923,7 +923,7 @@ void ata_eh_fastdrain_timerfn(struct timer_list *t)
>   *
>   *	Set ATA_PFLAG_EH_PENDING and activate fast drain if @fastdrain
>   *	is non-zero and EH wasn't pending before.  Fast drain ensures
> - *	that EH kicks in in timely manner.
> + *	that EH kicks in timely manner.

[Severity: Low]
Does this accidentally remove a valid occurrence of the word "in"?

The original text uses "in" twice for two different grammatical purposes: t=
he
first is part of the phrasal verb "kick in", and the second is the preposit=
ion
for "in [a] timely manner".

Removing the second one leaves the sentence missing a preposition.

Would it be better to change this to "EH kicks in in a timely manner" or=20
"EH kicks in promptly" instead of just dropping the word?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904123207.3620=
3-1-hemanth.selam@gmail.com?part=3D2
