Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8563393DDA
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778757445; cv=none; b=rSWQk5SsYnHSsJpY8I4N79rsSc/3MzNCtg0S+e32rgedYKUJlWQV5ba5gTdinrODxySyd1JH2KiEp9YaOFLHZv9OTRO31+xnbLbPM0jSZlK8PsuM5YYMm/tffZ58ZhRj41wdfSY8i1lgtq9y0bchbVjylh6K6m79PDa0wpfLWXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778757445; c=relaxed/simple;
	bh=61s1yo5ADnH5QxCFBrQ3+7sonR/9TS7sDkjVcZsPRLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt72Bv/5SsHVMI/3rN7FznpG73Rhwju5uXr/1ATngWr07RWq+0PDoNrAkIw6tPUQtWNHgbQMQ4GkCVsiS/iqET37nx0hnOX+LmJcQwQ4R2fwJBaXdFnLv6qBWDsGh+vXmpwK+evRFVHQETfBCSLaWwE4kRQLXUtvwG72GcVSn6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ea8ZbNKe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ea8ZbNKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDABC2BCB3;
	Thu, 14 May 2026 11:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778757445;
	bh=61s1yo5ADnH5QxCFBrQ3+7sonR/9TS7sDkjVcZsPRLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ea8ZbNKepuHpzz8AkE+vlmsnKDhBEq+HVrbzz7AB0Vt654CtEtdXu+pyWnzj/8S0g
	 y6IgGIuq1ds+iq0xesvi30Fq2AymjRo6rz5zIcjnWJPuIWfWHw+PSXYvu5tFyyww3P
	 bd3c571NlnL6WqGQpiKxuIBcKFNzRwYy3gEyLkySyZqm4LItcMOWx6icxStCyB9jRf
	 vonrjLVCynw/pAN0VHjm+02ZENYOhPsfUtr91T2UFhZVOGfa7btiT3heFJU789bmWu
	 /hIklCvM+4j+tU2ScXY1TaqigtoFu59gS1MPjt6Y0A8VgK46oq+vGBF5SYSr7gxVLO
	 V9kC214Jwrpjg==
Date: Thu, 14 May 2026 13:17:21 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v5 0/4] ata: fix deferred QC handling for port multipliers
Message-ID: <agWvQd0I-Sr1ZKfA@fedora>
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

Thank you very much for all your help with reporting the issue and also
helping out with testing. Much appreciated!

If there are no new review comments on V5, this will most likely be queued
up in a few days.

Considering how broken the PMP CBS support is in Linus's tree right now,
this series should probably go into 7.1, even though it is quite big,
but I don't see any other option.


Kind regards,
Niklas
