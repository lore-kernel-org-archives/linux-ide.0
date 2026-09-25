Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA4F34DCCD
	for <linux-ide@vger.kernel.org>; Fri, 25 Sep 2026 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327918; cv=none; b=WH6wSdpulq5NWOzNa+6TVTa2sHthL0JcEPwKaXfdWQ/BfVjETpLcyDGzp+dAVgRv+3shtrGMTFdHL7QA9umHbyp23pG3y0ogr4siXYK2Z79gkKfD605mo+hxJ7f4wPbgD5h4fRTxBPCc7nbYplQ58qr6qHjQ3rUc5Ohg17E9mwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327918; c=relaxed/simple;
	bh=ckBle56u0rRsVxkAQS2Xhe3KH27xktP1tNQm/PpJ72g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BQsksgLTUZlxw8k61OLFor655D859LWL9nJJq84b2EP0COHO366ZgCosFNo/rv1jj9vJldzwhLM8CwjkzJOER6UWyGRgWpSm3589Tq4eHOI9v716LNS2IMDIpk1zfqhAm/2+EFJZDguDvFiIiWsN6RmSnLvlX7N/MRUrF92MWcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4IF0ZXM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4IF0ZXM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775C21F000FF;
	Fri, 25 Sep 2026 09:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790327917;
	bh=1XWa5fC22sCHI1AX6A1b/yYscUrdimsxK232t6/rqT8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=n4IF0ZXMmp7AxUTo+85s3eJLUpisJo9bSZQieqNUB46dOjy7+5F1WACWeU3eoE9MR
	 gWQbfsNlT/MkCEmYHQm5TwdXlMwF6SlRdBBZ8Ch84QfYaYPuLZQKlJzYGP5YqkSPc4
	 PF66MUUwZ8HUSTtmbeIm2FQ0/h2zn0nXjfwGprhqjCFxS2z8ZrAGYj2iWXg73YrzYc
	 68m2ldH8pzZaeNbkNw9PqiZAYVHqI3xxew+lwNKDvp6KMNxr13HOrrCJiYoajQJPib
	 KzfGe0/PcrlFL0mgtFmnLKxPUt4Akf/KB2oZ8rfSHYpbSfZml0lYZ8PpmBz+oMTEAL
	 SKHigCyzUAPgA==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org, Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-ide@vger.kernel.org
In-Reply-To: <20260925052329.2683619-1-matthias.goergens@gmail.com>
References: <20260924033545.3624716-1-matthias.goergens@gmail.com>
 <arTuIxpEsaYIQXU4@ryzen>
 <20260925052329.2683619-1-matthias.goergens@gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: name the libata/linux for-next branch
Message-Id: <179032791620.190428.9225088776530462326.b4-ty@kernel.org>
Date: Fri, 25 Sep 2026 11:18:36 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Fri, 25 Sep 2026 13:23:29 +0800, Matthias Goergens wrote:
> The T: entry for LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)
> names libata/linux without a branch.  The repository's HEAD pointer
> points to branch master, which has no active development.  Active
> development is on the for-next branch.  Name the branch so the entry
> identifies where development happens.
> 
> Documentation/process/submitting-patches.rst sends contributors to the
> T: entry to find the tree to prepare patches against, so a branch-less
> entry whose HEAD is already in mainline points them to the wrong branch.
> 
> [...]

Applied to libata/linux.git (for-7.3-fixes), thanks!

[1/1] MAINTAINERS: name the libata/linux for-next branch
      https://git.kernel.org/libata/linux/c/113dcdfa

Kind regards,
Niklas

