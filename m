Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9191D41A8F
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021615; cv=none; b=cZYWXKrugQpnLy+6mOTfUW+tNhPmTbUxjZx06HgzKb5XBFywF7JUv8QF7wRCgiTxg+iN/QLOM9w4iRlKLT+HqGBUZTSMY2f6pCCYzUns+8f4GWnBvvg0yhTsXjPH6TvQqRUcRFXh2ae+Gi2RAf+Tt52L0bIP+IOYSOSsz+v0i7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021615; c=relaxed/simple;
	bh=dFCFr5RtyEMX6AY3lgQkdaEwVgJO5X1tqmhRpT3Hpjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLzfZbKXQCWtBSg9VshDOJ6P9bIn7PprQ+iE1d0jYc+LSomZ5NNRItNdiCdhNeqWJDPo2TCREfSh6LTf7D0a0FnjPltCZDdfQk1u70ErH8USarXFhaOk856ytPuIStwophyKYhPERzqyOACVdpGfUgwgprG0DM45h03Tg2xkZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDMsbB1V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDMsbB1V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597A1C4CEF0;
	Fri, 27 Jun 2025 10:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751021615;
	bh=dFCFr5RtyEMX6AY3lgQkdaEwVgJO5X1tqmhRpT3Hpjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jDMsbB1VOVTQw0wP2pqhAmzJPBWWxMX55YUZ1vmCFexJk/MLvMAsWmsK93GrbmPHL
	 Bjr/AXhnBfvMMUNrwpqDylelPdFoGQSnhazURDB436oAX/I67i4LXkORZ7i3nzXqYh
	 qefquNa0x+hcfKSRvxe9270KG5hdBFfEZjW7C8rxYKRZFEUfaR98YLOP6b6xurCtrM
	 aDcFgJBvAuQM5bIPuWRr3aF99ZKUAW3WQee48W9exksnqKGaGHssEFwg/a1kK4GIKn
	 k/NtDEcfDF9379h80SRUtd2awlMfuxrh4HIhsKlNL4JbJ1e4fgbOoRZ26CAsPGymPS
	 drZiHcXltOwlQ==
Date: Fri, 27 Jun 2025 12:53:31 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 1/6] ata: libata: Remove ATA_DFLAG_ZAC device flag
Message-ID: <aF54KxNFiBPD_jqS@ryzen>
References: <20250627075207.23969-1-dlemoal@kernel.org>
 <20250627075207.23969-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627075207.23969-2-dlemoal@kernel.org>

On Fri, Jun 27, 2025 at 04:52:02PM +0900, Damien Le Moal wrote:
> The ATA device flag ATA_DFLAG_ZAC is used to indicate if a devie is a
> host managed or host aware zoned device. However, this flag is not used
> in the hot path and only used during device scanning/revalidation and
> for inquiry and sense SCSI command translation.
> 
> Save one bit from struct ata_device flags field by replacing this flag
> with the internal helper function ata_dev_is_zac(). This function
> returns true if the device class is ATA_DEV_ZAC (host managed ZAC device
> case) or if its identify data reports it supports the zoned command set
> (host aware ZAC device case).
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
