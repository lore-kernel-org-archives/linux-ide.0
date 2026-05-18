Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30462F8E92
	for <linux-ide@vger.kernel.org>; Mon, 18 May 2026 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779100405; cv=none; b=cCaJOPiaARhYJbOtQ3+PTx3mygI26Y6OBE+CB9kjgP7rSRW66C3f5EUxVgZHe56aQAPORwj53sejqp8Xo5qXqH0QmC46T1JC3iFDEgxhlAimyXuPxUXS84i5DP9+uVKyYjGPsDZQ9KTqnzoHYyGdy0pV7Bqp81MPaf5wHUXc++c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779100405; c=relaxed/simple;
	bh=IBDngdYpOgMFq+khGljNaKiNd2thWSZl85fX1lwcH5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ipa8CLOhXc7Hz0wLDjjGmLh0mnx45S3Tx78GCa+xF70I1Rzw0hO4hy5Dgrw+k6jVPCaaMQLc2dniiX21+4801C/UBv9JtoGb9nAN4YcwckBkMiCErdtzL5yMcy43XdbJuUdFiVjMGsO2gIO+Cmp93ixfY/7ISXm7xg0jLoYBNgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpJnSWxT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpJnSWxT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B99C2BCC6;
	Mon, 18 May 2026 10:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779100404;
	bh=IBDngdYpOgMFq+khGljNaKiNd2thWSZl85fX1lwcH5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qpJnSWxTOiAsgDmB9CwFGQPAhTTY6lztqMQVgUnLHpUCVBTRBTAMsNYjW5nyZD0LB
	 3IaDkJjACTufQ8rGv95OCzdfutoy0ji8sTsnsNcj1Lz3UA9eViTMxy0d3r3gPG2Sx3
	 8SgbXQ6ezG6E4tqyWACQItau5rBH4CNYzBqWhtLihKDISPEHlTKZB7o0HQGoky9WAi
	 hW8J0GaLTufZ9ZrSUvBMtpfsEmP/kxgr0pcurYAN8sbBchlWyxiPp2M+Xt6iYLy7HA
	 mOAWo5qoQFsAdVZ+ziZicM6icZOdvFRsDrri5uvD76diWPPzZgRd9UY+R0SjLMbOxO
	 LWRNPM6FpQ8aA==
Date: Mon, 18 May 2026 12:33:20 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v5 0/4] ata: fix deferred QC handling for port multipliers
Message-ID: <agrq8PaA3yWc6xzw@ryzen>
References: <20260514073858.1175072-6-cassel@kernel.org>
 <87402a36-57ef-40a5-8668-988f58e31ca9@tkel.ly>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87402a36-57ef-40a5-8668-988f58e31ca9@tkel.ly>

Hello Tommy,

On Thu, May 14, 2026 at 03:43:30AM -0700, Tommy Kelly wrote:
> On 5/14/26 00:38, Niklas Cassel wrote:
> > Changes since v4:
> > -Fix ATA_DEFER_LINK_EXCL to use the correct goto label. While refactoring,
> >  I accidentally used the wrong label goto defer_qc instead of goto free_qc,
> >  which of course broke PMP CBS in v4.
> > 
> 
> Good news!
> 
> Tested with Linux v7.1-rc3 + v5 patch series.
> 
> Both FBS + CBS worked fine, no errors/warnings or visible issues.

I added your Tested-by: on all patches while applying, thank you!


Kind regards,
Niklas
