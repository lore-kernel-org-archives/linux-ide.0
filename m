Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9963DE45B;
	Tue, 26 May 2026 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801794; cv=none; b=Rlyx80yGUg7xVI98V5dQlDWfhd5/phoKZc8PhEwxgOM3BX/XBpMbDh6Msn1O/G4Fbqb/KaOODFDltedpDvbfon49F4UmiU1AbWnUO6omNG569cI/xAhsWLKZS1d7qf2okK7/N020HHMJ98J0PtQm7SmoYpU3LPI1ub/Dw5y9fIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801794; c=relaxed/simple;
	bh=z1EX1y3eTOSNije56JGNkJv5GlMio1sI7PfR3ibeePE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNNriPuVLEzzbiZfVxoQx6AKe5/DKUyvJh9cAVTlWPoIEmDBldu1cKQN+QtWSVOQYAn7BhZwZ/Uz9VgGDnMZ7cRMfoVn5fNqXWV3n5OAwNS5PnIVGzxqGjiYIpuLKl1L+yTxHeWoQFGke5N617WikFbXfHZU5Cm5GqpTeLb6CoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyO7H5s5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyO7H5s5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD9D1F000E9;
	Tue, 26 May 2026 13:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779801793;
	bh=BWRrZsTSIqa1OZh4RsvbkgqfY2S1+B5z4OFhmXbZtVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MyO7H5s552NrQx3oOOgSQJxofFvyXNcMLu737HbAc4g55B8GGkZipPx3/7i+ror0P
	 x+tu2B9PplvIlqv3Rv7RW/xN1gu8kNs509Sk5T14rtEgQb/BE6qexlrPVCidSxINcA
	 T700FiArtKvoCf10ApNphUJYjRcMua0E2kOLx5hwRcqMvU76N0UL4Cv+taer9LBg/4
	 7DZXS2LiYgn0syalfJ5jEjjqzy0PBFke0SN4Zuq8X307RJebrgJ5h9xjKMwR19JQSQ
	 ibXOHrwRpaFZIhEeJhcan5qjDXmsfsK6ZkI22yGQYhtnVbFbXezqraKzQFrlxwzuyp
	 Ntmn0JtXDQNLw==
Date: Tue, 26 May 2026 15:23:09 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: sashiko-reviews@lists.linux.dev, dlemoal@kernel.org,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 4/9] ata: libata: Pass the ATA port argument directly
 to ata_qc_complete()
Message-ID: <ahWevefc2xkbmGMY@ryzen>
References: <20260521173347.2079560-5-bvanassche@acm.org>
 <20260521184035.DAD131F000E9@smtp.kernel.org>
 <d5103cd1-5940-495b-823f-055631b76f03@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5103cd1-5940-495b-823f-055631b76f03@acm.org>

Hello Bart,

On Thu, May 21, 2026 at 01:30:20PM -0700, Bart Van Assche wrote:
> On 5/21/26 11:40 AM, sashiko-bot@kernel.org wrote:
> > [Severity: Low]
> > Is the kernel-doc block missing the new @ap parameter? Since this is an
> > exported symbol, omitting the new parameter might trigger kernel-doc
> > warnings during documentation builds.
> 
> Yes, the kernel-doc header needs to be updated in this patch and also in
> several other patches in this series.

I agree.


> 
> > [Severity: High]
> > This is a pre-existing issue, but does this code prematurely complete an
> > active internal command on a spurious interrupt?
> 
> Since this is a pre-existing issue not related to context analysis, it
> falls outside of the scope of this patch series.

I agree.


Kind regards,
Niklas
