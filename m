Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDC711CB8
	for <linux-ide@vger.kernel.org>; Sat, 20 Jan 2024 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705774118; cv=none; b=ImabT/PtmWCczvifIIo9gApluf/LDX1eM7UyIV/zo2L/NuOrhHRru0FoVsbMEzAU1fA/uYFMvC2imX7pI1ZOC2krZsxHjG5wdBSaKY9FZI8UTMgZvKdsZ5dOml0eHeLa4K+6rmyLkxyF2GMeIQwNwWz4wp519Opbmb32kH6IXuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705774118; c=relaxed/simple;
	bh=0dDCzhfRFrSyZf7/2v8y2EsRgmNfWMFiqNFCVwOOI8M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ShrAIbaSS9f+uKwD8hVh+qw0Rcq1UW+ROh+hU3KtETfwJDgc/yys3bNoTI6gAd6J6153KWTj8LN8hMEgP/Ohx0v63lV5dYtfl/44kt3XpfjGu/0SiSqpO9OOtP+IpfapCQIUS3n0izyKO/ZuMPr3HAdDnJHaApNDTKfClVEHwas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=pass smtp.mailfrom=thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 380001542E5; Sat, 20 Jan 2024 13:08:36 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 1/3] libata: avoid waking disk for several commands
In-Reply-To: <878r4l12c5.fsf@vps.thesusis.net>
References: <87msthdo11.fsf@vps.thesusis.net>
 <20240107180258.360886-1-phill@thesusis.net>
 <20240107180258.360886-2-phill@thesusis.net>
 <f6110204-338d-42b5-8ec2-153dd862e799@kernel.org>
 <878r50uf97.fsf@vps.thesusis.net>
 <abd85855-0767-4e48-a8a7-8046cd339f9c@kernel.org>
 <87a5p5b426.fsf@vps.thesusis.net> <878r4l12c5.fsf@vps.thesusis.net>
Date: Sat, 20 Jan 2024 13:08:36 -0500
Message-ID: <87plxvnahn.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Susi <phill@thesusis.net> writes:

> I was trying to do this.  I think the right place is in
> blkdev_issue_flush(), but apparently bdev->bd_device is not the same
> struct device that gets suspended.  I can't seem to work out where the
> right struct device is to pass to pm_runtime_suspended() and skip the
> flush operation.

I don't know what I was thinking yesterday.  It can't rely on
pm_runtime_suspended() because it would continue to flush and reset the
suspend timer before it ever gets suspended.  I wonder if it could use
the performance counters?  Whenever a flush is done, and also when
suspending, store the value of the write counter, and only if it has
changed, issue the flush, otherwise skip it?

