Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A05342526
	for <linux-ide@vger.kernel.org>; Thu,  4 Dec 2025 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764854512; cv=none; b=l6PA2c7sOZ/FDBjL4T4PSTpc8uqs5wAireaJQQAmlU+YZuUN+fitv6V6twWGNB26wb/Z84xloTsDXuBRFSVtgwn8hX/QCIl3gasdog5Do6q5n0DnjB+lnSBbXD+hhlX/rGHOXMWDcMHoKzBj9/Dh553Qw3OPGiqvgaDd9p2DvdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764854512; c=relaxed/simple;
	bh=xKTIEp3OE+92oTK4gBC3yQkqBmrjYt5hhHbw8zD5ZIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Is7WCfCO8XMo6qOVGX5bV2FP7qjYl+P6WRGw8z03toX0h5RYUwtbvW5bSZogiP4QQCf1UVxyqhKyXhNo0WRruoPMzeXZePprt+ej124CfrArBUUc7P2MCJBswZWlihjMxsW7cY+JV+6cneaWYEiT8egmjyfJPHFgMv0BFyiUfII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0Tex9zO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0Tex9zO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5606C4CEFB;
	Thu,  4 Dec 2025 13:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764854511;
	bh=xKTIEp3OE+92oTK4gBC3yQkqBmrjYt5hhHbw8zD5ZIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e0Tex9zOB1DYv2o0oLVS9hkma1KOMGnEtXOV+wfqc0DUmkikCOgF7HnBysET2YtKZ
	 yA808qHMizSAikB0exFAYiuNRYllrqQTSLB9cka3W8xEwpKO+BPEe/6NK3L6Dzn9G/
	 AjYJ3OJTmTLUs+c3DiRBPUjpC0gIKn3rfsRgz4atCZ+zTO5l9Gc+f7LNJ5FOogfsEI
	 yYvaI44TSiPYFKDziOPuV9S0Xz1d9Zy6AN8NQ7Il9rogKDnPbwsK3A9XEanC3T3CM1
	 LjJRF8vhD3R6AE/mgTNNuZ1ouYHxWiyfJeJ6w2pYmM82Mxn0INvzn5p7KHQfmuOPVe
	 0E1nJZ9lcc+XA==
Date: Thu, 4 Dec 2025 14:21:48 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-scsi: Remove superfluous local_irq_save()
Message-ID: <aTGK7GYPiSVCxoMh@ryzen>
References: <20251204131804.946417-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204131804.946417-2-cassel@kernel.org>

On Thu, Dec 04, 2025 at 02:18:04PM +0100, Niklas Cassel wrote:
> Commit 28a3fc2295a7 ("libata: implement ZBC IN translation") added
> ata_scsi_report_zones_complete(). Since the beginning, this function
> has disabled IRQs on the local CPU using local_irq_save().
> 
> qc->complete_fn is always called with ap->lock held, and the ap->lock
> is always taking using spin_lock_irq*().

s/taking/taken/
