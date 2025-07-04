Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3FF224244
	for <linux-ide@vger.kernel.org>; Fri,  4 Jul 2025 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751628633; cv=none; b=oiskM6wEKXvwFwjL3PWNrHQNFT1Q//DQATsWfXSDObZaD6R9iuEgYwvgyynhAbaTe6zF65cyz/DK9eoiiwdISx1ifnjS0P973SzkYu26bIrNK903m6KOduC4eguRGWJlFh+fX5TJ64rYqRYQtKOFqcPyW5D3phBCuNOu98k8zEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751628633; c=relaxed/simple;
	bh=z37MTaQSTfqSryIRqzj1wMSjwy60VuWL15AJjjqR9w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBJkqsQ67PPLnbRNChnF1hVEy8MuxrOlRW8Np8Q/IPMne9VGIhuZ+J8s6LjD+3Lghmh21KRvoG4fWsG5QPiPNUfkld4mAUJOY1/Jci7XKmKE8e3TGGs2mZo3TqjKE69JpBDu8GNLgx8zGJ/zak2nrpAo5JnITsFapaS9vJ9vWNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxMeaW64; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxMeaW64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B4AC4CEE3;
	Fri,  4 Jul 2025 11:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751628632;
	bh=z37MTaQSTfqSryIRqzj1wMSjwy60VuWL15AJjjqR9w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FxMeaW64EsNuVYChDHHTZ+4HlxVIKaZco8TXwyhJ3EcT0qWQLJG6Fma0I/SHrA+Ie
	 VN+/qplmjpX+5IJ/n58el4GV5uvRnY19Jrm12R8aTVdD4uD5+fH6Km0i+AFSLoV1Sm
	 TuhDPfO2eViUGDSy19r7dhOB+Gb8dnzJI1gw3+gk6ZAqYSsJScwoEDcpSl328kjhwQ
	 UMOvW53q+19lqfVMI8j0A+73nloqj5bmbepL81NWMfE27UziJiDnFZ4y2WuVr0v8of
	 BDh51PBoKiPG/To0vO41IWY/Dt19CVcDs5U5BD0C6wlglbev4/5XfIHYnfXcRhkbnp
	 V9HEE+USudJkw==
Date: Fri, 4 Jul 2025 13:30:29 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata: Introduce ata_port_eh_scheduled()
Message-ID: <aGe7VSGhI1GTYNDA@ryzen>
References: <20250704104601.310643-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704104601.310643-1-dlemoal@kernel.org>

On Fri, Jul 04, 2025 at 07:46:00PM +0900, Damien Le Moal wrote:
> Introduce the inline helper function ata_port_eh_scheduled() to test if
> EH is pending (ATA_PFLAG_EH_PENDING port flag is set) or running
> (ATA_PFLAG_EH_IN_PROGRESS port flag is set) for a port. Use this helper
> in ata_port_wait_eh() and __ata_scsi_queuecmd() to replace the hardcoded
> port flag tests.
> 
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
