Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48971CAB2
	for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705425786; cv=none; b=G/TaugV+pazbQoNlrvO/T/Rnc4mqpWzK2UuByqprxIT5asApj1PtFHXHsskH7RmpU5HH9M3L83r1Ky0IYR7Fk10O5WalIqBOoBvoCNGCR8KAdJu1Ary/sIIiCGtzlO//mOUsy9d+51pOkxS/Os+I0zTDNqfZZl1JSdA6tqg1RPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705425786; c=relaxed/simple;
	bh=cDuCftDHAq178CXCIRdNIPqC5eXtatqHCuqwW3bwKAQ=;
	h=Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:MIME-Version:Content-Type; b=UL7kc1kZPvmT4z6f/+VgLyTTiJWtaMVCQtinrIAGkKP0G5KVdLbvx+5XOOEp4a1nVOBlisWpbeK9jeEzu6QbU6XAKiDxg9ibGVPwW4fvEoJXvfjknDxHhueQ1Mou7SX5Rv6VbLHR408rSL+fiWzG+5yPndX4zUE0hH2Qjjy0wnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id EE5F61537C4; Tue, 16 Jan 2024 12:23:03 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH 0/1 v2] Only activate drive once during system resume
In-Reply-To: <ZZ1kMrTzRxyjF00T@x1-carbon>
References: <20231225151915.258816-1-phill@thesusis.net>
 <20231230182128.296675-1-phill@thesusis.net> <ZZ1kMrTzRxyjF00T@x1-carbon>
Date: Tue, 16 Jan 2024 12:23:03 -0500
Message-ID: <874jfdb3bc.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Niklas Cassel <cassel@kernel.org> writes:

> 1) Your patches are missing a Signed-off-by tag.
> Without this, we can't accept your changes, see:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

Yea, they aren't ready to merge yet, so I didn't add the tag.  I suppose
I could have put RFC in the subject.

> 4) Please use git format-patch and git send-email.

I did.

> Looking at
> https://lore.kernel.org/linux-ide/
> as well as my local inbox,
> the threading seems very wrong.
>
> There is a [PATCH 0/1], and then a patch "[PATCH 0/1 v2]"
> that replies to the [PATCH 0/1].

Yes; I sent the second version as a reply to the first.  Isn't that the
usual way of doing it?  So that you can see the whole thread going back
through the older versions?

> Additionally, there is also a [PATCH 1/4] that also replies
> to the [PATCH 0/1].

That's a few replies down from [PATCH 0/1].  There was some discussion
first, then I sent that patch series as a reply to that discussion.

> It is just impossible to follow.

The flow makes perfect sense to me.

> For more info, see:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#explicit-in-reply-to-headers

I see.  I guess I'll avoid that in the future then.
