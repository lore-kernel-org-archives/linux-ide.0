Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDC23FE655;
	Thu, 30 Apr 2026 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777538783; cv=none; b=uvxE8gL/zeswTJTYHAK0fx/LZunZO/eOLNjw/WBKREEHWAjC0c4jC7kvU+WeB2LJn1Z5e5XKFvaT5kFz23ZsOdGIegc5wY46coaFLSh+UEApBQoDg1HsUUl8jAAzgvduPi3j1vZRhb9ExkhvVaixxn0nSkiiGNZ3/YdY+WKrN08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777538783; c=relaxed/simple;
	bh=S4p07wTaDCCHyd9JhFa3bsUouIcyzyZwumxpqPoexW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFZu1UK5F6EZaHyB7qO+V/RTo6qOGC50ftq4s/7DZBlo9Hm2eJM+aIL/enKPAlwXgUYyix27CHnbfJ+chF2evXeVIGrSeA0gJNnZpBZMF5VuotNFJh4uHAtPBGmEV8zlGw+LiM3wbLqdvmbYhLoWxlzOuDUjP43x/uV5yx8IASU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpIyQsvp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpIyQsvp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE98C2BCB3;
	Thu, 30 Apr 2026 08:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777538782;
	bh=S4p07wTaDCCHyd9JhFa3bsUouIcyzyZwumxpqPoexW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BpIyQsvpXp0DZei4o0htECvzdhPEGvosMj/88i/FF5h8/xTy0I7mwWZ9xuY7tbaz8
	 qf3nKgtcJ8YH5DNLwfHyMm/6YfXDtegeAA/dUfD3FQFzshS5sPdq9vxgCa65yjT/7B
	 EIE6deOMRGdHqY0n253WtNUVegGkWL4KVWvz1rJFEPdfH3VVAO7yzUWyj4oRjjFp5x
	 jkcgEzyikQwOyXBN5KOZMxuDqjvKXmkA0jnLrVtFzSIt3R0nWcU/QF7nhuiLhwA4Sg
	 asBjG1zI/umzaoKxn+E5X9UvQnMtrL+n37gRqqymBOf1Vj7pqg/HbtZ9zkNxUH8sfF
	 T7IshPi6+B++g==
Date: Thu, 30 Apr 2026 10:46:18 +0200
From: Niklas Cassel <cassel@kernel.org>
To: yangxingui <yangxingui@huawei.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-kernel@vger.kernel.org,
	liuyonglong@huawei.com, kangfenglong@huawei.com,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-sata: retry hardreset when device detected
 but PHY not established
Message-ID: <afMW2scJrBSI_jLo@ryzen>
References: <20260425060447.1312763-1-yangxingui@huawei.com>
 <e8d237bc-7191-4881-924b-86a34ff0f3b9@kernel.org>
 <a118114e-9828-06d6-d38b-2b426c92bb14@huawei.com>
 <33299d0d-d863-4e00-951e-4728ddc823e2@kernel.org>
 <0539efac-d9b5-4f95-eecd-b88cb3cb8724@huawei.com>
 <66bc004a-4a18-43d1-b296-463ea72cbc85@kernel.org>
 <c78f6dad-b0fe-a2fb-8458-9fe182cd6b54@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c78f6dad-b0fe-a2fb-8458-9fe182cd6b54@huawei.com>

On Wed, Apr 29, 2026 at 03:01:48PM +0800, yangxingui wrote:
> > > > > > This is preceeded by a call to sata_link_resume(), which calls
> > > > > > sata_link_debounce() and that function makes sure that DET is stable. So if
> > > > > > after that DET still shows that their is no PHY, there is likely a big problem
> > > > > > with it and it is super slow to be established.

I agree with Damien, sata_link_debounce() is supposed to make sure that
DET is stable.


sata_link_debounce() will not explicitly wait for SStatus.DET to turn 0x3.

If value is stable, and SStatus.DET == 1, and time is before "deadline",
sata_link_debounce() will continue looping.

Else, if value is stable, and has been stable for "duration" amount of time,
it will return.

Since your print shows that SStatus == 1, that most likely means that the
deadline expired in sata_link_debounce().

I suggest that you try to increase the deadline, perhaps start off by simply
multiplying it by some factor in sata_link_debounce().


It would also be helpful if your commit message explained why returning
-EAGAIN makes a difference, because from what I can see, if the deadline
expires, sata_link_debounce() returns 0, which should cause sata_link_resume()
to return 0, which should cause sata_link_hardreset() to
return 0, with online == false.

If that is the case ata_do_reset() would return 0, and
ata_eh_followup_srst_needed() (returns true only if -EAGAIN) would return false.

Which should eventually cause us to retry another hard reset, as long as
tries <= max_tries.


By making sata_link_hardreset() return -EAGAIN, the difference I see is that
we will for a software reset followed by the hardreset, but you commit message
did not mention that.

So, my question is, why is it not sufficient to retry another
hardreset/COMRESET?

Does it work to only do a hardreset (without if a follow up softreset) if you
increase the deadline?


Kind regards,
Niklas
