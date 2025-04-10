Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A84E28A401
	for <linux-ide@vger.kernel.org>; Thu, 10 Apr 2025 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744293873; cv=none; b=AgvcBSekyxJFCY33fdPeiOqKsW5FXiotNXxfVQB+8GA/ZYMgSXReo0S4HdI4d1dtO+yNr3Nogwbh1qx0OqUFdOcc8SAe3sW9LpkHgtQ6E3AVUh+grrl7veF2t1UGewQBkd0fgue5G1oo3KSYNBDFw2rFcvJ/uyUKXSbI/qNUyBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744293873; c=relaxed/simple;
	bh=Zkww2FwiMYpE6apLR5slKI5bsl64bviOQnl3sq792HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ND5XeMtNDhv2zWrEAwPvHa3qXID7wtainC6jIq5+PUiRTLNev62CpJb1SFTU9OvFBGLD2eFeL6yQyXcMxzJyRS1OiPnSdyxgln7lrdsgfBx/qvI9lf8caZ19LT9B5G/WY+k9qjnOsXPsCw0IHOVTG+L5xWXmugJ696LOY9ySmzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3/5gCbL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3/5gCbL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03C1C4CEE8;
	Thu, 10 Apr 2025 14:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744293872;
	bh=Zkww2FwiMYpE6apLR5slKI5bsl64bviOQnl3sq792HQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I3/5gCbLUrxSVB1yrJx4VUdfV28uUA4g15xo273UDhEszUuXYAv+1qBz/1bV2QNHL
	 CD/KXvuPAubBI67uxRo9GxwU5jvyZvmJicrAX6T+7TA0wB9j/ZwLhhUeh3JKWfOfiY
	 miDhYTbt6vfkf79ROvgP6/5RYCTFrsz5hqmjx8LlBidZjg295NjMf0ynHwuGNt2H4i
	 1ZzA+qFFkYaog05z/E4Eo1OPL/aX3wUVoV/T4O3Pc8rWMLkKGIfPWAYua2cbGIAJtC
	 Ls+N4Lodnp4cgL+cY7LxTyzEiBZt3LxjZ8N+BwxNiCuE0SgEKC70h2ZZcf0k7E1/oD
	 e45XxbMOW48/g==
Date: Thu, 10 Apr 2025 16:04:29 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata-sata: Use LBA from sense data descriptor
Message-ID: <Z_fP7RKf5AbybyXB@ryzen>
References: <20250409084546.121694-2-cassel@kernel.org>
 <Z_aul100eqb2-naM@google.com>
 <Z_fBaVZkcD9AtTaR@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_fBaVZkcD9AtTaR@ryzen>

On Thu, Apr 10, 2025 at 03:02:33PM +0200, Niklas Cassel wrote:
> 
> I guess now when we do have access to the information, the most consistent
> thing would be to fill all field we can in qc->result_tf... but, to do this
> for every IO might slow things down.
> 
> So is there perhaps some logic to only filling LBA (in addition to STATUS
> and ERROR, which are filled for all NCQ commands), since that is the only
> field that can change, as per the specs.

Looking at this more closely:
https://github.com/torvalds/linux/blob/v6.15-rc1/include/linux/libata.h#L574-L577

FEATURE is a union with ERROR, so we cannot save it in qc->result_tf.

COMMAND is a union with STATUS, so we cannot save it in qc->result_tf.


The sense data descriptor does not provide AUXILIARY, nor DEVICE,
so we cannot save these.


I will send a v3 that does populate COUNT (7:0) and COUNT (15:8),
since it is only so few fields that we do have, we might as well
populate them properly.


Kind regards,
Niklas
