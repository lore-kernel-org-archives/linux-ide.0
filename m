Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E6C19CC0C
	for <linux-ide@vger.kernel.org>; Sun, 31 May 2026 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780235261; cv=none; b=f1wwpdRZ8Ipb1dwPz03WBGIkcLuyCJIcL0vgfYDFmcL/RM1m/O1yl8fpBVefdT1L1rs7lJtE6glpDxNE3gGLnFd+CLkCPVYUGyz04EXcjPlBbfhmpuVGod+ddxHB0xSomOQmjgnhf5YtIP8Yr8ZQ48D+KZ8hRhkblnTfe6xEaY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780235261; c=relaxed/simple;
	bh=3QomvKbtz6lKam1SV7LG08k7JBhnFsqVBJTgB+qJEeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvJ4ocxSasjqb+/WtblNp9TP6tPQxB2G5R99dUra/9l4dldyr9bEusakpoSHOia7tkOsqNACIe1E/TLz5Kg7EwMdNirrEU+Og6+OrHbm0IKcloSTUiidca8cD0dc6K/heVW6GKGlTfGnMMo8UVqBfBF7Y/4/eBKEBJ+6z7k6o9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxumPYL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxumPYL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FA21F00893;
	Sun, 31 May 2026 13:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780235259;
	bh=NCeruZGyEWdD9GuhmVRma7jFIxGIuNRki2Nj9JVLiDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VxumPYL9FIZDvF7NIHC+r2wNWYr0SWvrycAyFrmNrYC7gcbjq9ZI07oPCYZDkOLS0
	 nsk0DzDtOy16oKE7jISwcKnao9GnFR1t3fUKrGFXUDMbiqL4+Q5pij3o8MExqX1Cuz
	 IsCZB+M0zg/+Owa9kXo5ZezWtn+jdkRXnQgItOoexyrvTJvO+MU+e9bbghI5gjPw12
	 YAkucslE15ubBaB6fZCWkOx99YDDdrojmTd0gOd8sL2tW1oYOe8a0tX2x7s5ES+Cqo
	 95+I+vQu/IwefbPFQbIS+p0hRuB5o+krSPjHoq+UFwgvgJnv6wiPoyI3mBrUuM3MhI
	 rKEC9Wws7aC7g==
Date: Sun, 31 May 2026 15:47:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Marco Elver <elver@google.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/3] ata: libata-scsi: Remove lockdep_assert_held() in
 ata_scsi_translate()
Message-ID: <ahw794UEfbGSO8d_@ryzen>
References: <20260528172855.703631-5-cassel@kernel.org>
 <20260528172855.703631-6-cassel@kernel.org>
 <07a727ab-7f0a-4574-8cac-a9e876b1e6be@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07a727ab-7f0a-4574-8cac-a9e876b1e6be@kernel.org>

On Fri, May 29, 2026 at 03:42:31PM +0900, Damien Le Moal wrote:
> On 2026/05/29 2:28, Niklas Cassel wrote:
> > lockdep_assert_held() indirectly calls __assume_ctx_lock(), which will
> > suppress any real context analysis from being performed.
> > 
> > Remove the lockdep_assert_held(). This will be replaced with context
> > analysis in a follow-up commit.
> 
> I am not really liking the idea of removing runtime checks and replacing them
> with compile time checks that work only with clang. What about gcc ?

Intel 0-day CI testing robot builds with Clang as well.


> And are we sure that the compile time checks are as solid as the runtime
> ones ?

Runtime checking can be performed on more complex cases (like Marco said checks
in runtime does allow to compare two pointers which might point to the same
object, which is something that context analysis might cannot catch), however I
expect in the cases where compile time analysis is possible, as it is in this
case (since we now supply an ap pointer), it will be as solid as runtime checks.


> 
> As the sashiko comment mentions, can't we keep this and simply add a
> __must_hold() annotation in the declaration ?

What I don't like about it is that, since lockdep_assert_held() has a
__assume_ctx_lock(), it will tell the compiler that that the function
always has the lock, which renders the __must_hold() in ata_scsi_translate()
useless. I can even remove the annotation without getting a build error.
(So it basically yields the __most_hold() in ata_scsi_translate() a no-op.)

Without the lockdep_assert_held(), we do get a build error if
ata_scsi_translate() is missing the __must_hold() annotation.
I do like the fact that we get an error if we don't have annotations all
the way from ata_scsi_queuecmd() to ata_qc_issue(), if there is a function
in between that is missing annotations.

And since the lockdep_assert_held() was added only in December last year,
I don't see the big deal with replacing it with a compile time check.

But since both you and Bart seem to want to keep it, let's can keep it.


Kind regards,
Niklas
