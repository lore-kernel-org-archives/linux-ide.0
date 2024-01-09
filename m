Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782D539FC1
	for <linux-ide@vger.kernel.org>; Tue,  9 Jan 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwxPDmZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BB1C433C7;
	Tue,  9 Jan 2024 15:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704813622;
	bh=Qn1+8FMHSe8YPHzHflimwTjDnOQbrPBa9kLEPT8/ZhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BwxPDmZ4SJdhWsWwBYlenqYecuysuwmJEN2ySA7iG2TRLD6KGhix55pTlEKim/5Rm
	 h6RITj7pHNuP5ORJhfX0HFSdC3vMnfTccrLrGvOBnUZXp8n4rduTVIgMNX4MEHuPnq
	 T4TGtEMn0DGVf5qYhWybocNH/BJkusxt4sSQgO2eYNEY81NEIEIK8x4VyR5/mL+0a0
	 05soXpgqPT3GqzwAO9n/Um0Vjrs/4/ViBcCTe4sXxow5ha8cWuHiwY9cfmk9J/h5/K
	 IXk5pa/h5urvP75TlCA42OYhqmn+pZoWxh7Fqlzr0/Xy0rytA4eLBT50sawmbvlVwl
	 w+9dN+afxX7pg==
Date: Tue, 9 Jan 2024 16:20:18 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Phillip Susi <phill@thesusis.net>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH 0/1 v2] Only activate drive once during system resume
Message-ID: <ZZ1kMrTzRxyjF00T@x1-carbon>
References: <20231225151915.258816-1-phill@thesusis.net>
 <20231230182128.296675-1-phill@thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231230182128.296675-1-phill@thesusis.net>

On Sat, Dec 30, 2023 at 01:21:27PM -0500, Phillip Susi wrote:
> This version also works and may be a bit cleaner

Hello Phillip,

Thank you for your series!


Some small advice:

1) Your patches are missing a Signed-off-by tag.
Without this, we can't accept your changes, see:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin


2) The cover letter should explain and summarize the
overall problem that the patch series addresses.

It is also nice with a small change log, so we know
what changed between V1 and V2.


3) The commit messages should explain the specific
problem that the commit fixes in greater detail, see:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

After the problem is established, describe what you
are actually doing about it in technical detail.


""I have been wondering why I kept seeing drives activated
twice during system resume since this got added.""

If possible, please reference a specific SHA1, otherwise we
might not know what "this got added" actually refers to.


4) Please use git format-patch and git send-email.

Looking at
https://lore.kernel.org/linux-ide/
as well as my local inbox,
the threading seems very wrong.

There is a [PATCH 0/1], and then a patch "[PATCH 0/1 v2]"
that replies to the [PATCH 0/1].

Additionally, there is also a [PATCH 1/4] that also replies
to the [PATCH 0/1].

It is just impossible to follow.

For more info, see:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#explicit-in-reply-to-headers


If you simply use:
$ git format-patch -v 1 -o my-series-v1 v6.7..
$ git send-email my-series-v1/*.patch

for v1 of your series. And then:

$ git format-patch -v 2 -o my-series-v2 v6.7..
$ git send-email my-series-v2/*.patch

for v2 of your series, there will be no explicit
In-Reply-To headers that messes up the threading.


Kind regards,
Niklas
