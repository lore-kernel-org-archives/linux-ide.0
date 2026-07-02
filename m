Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACBA353A98
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003701; cv=none; b=VKCDbI6obb+DVWgLR2WeKxXO3UCEzFyyumaaPpiuNwPPYrU5D/JxxfqZBxffckKMPo2tkeGplQpQyK1e07I0MBzqJ/Wd5Cbrr+ozEYVp3Z/M0oSUuZQ20K9+SbfVtSCgbJ4Z1WVWQtO8/6AtWJ3P4a2DFasPOvvPNByavOURfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003701; c=relaxed/simple;
	bh=KNK0cBbeEj0VuDIbUkSesd6XrO5YWIrpDnKuxn6KgLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pxr1PdzvndTcf1Ece3GB/CF4zEt5ezg2ZuLdYfC/e+pe1slHN4Gl01VPXuE8Es3UE2FnJpWfuWFsJ5ipKB15YPo9aG17lRWuMaWmwhhNwsTStO3KRNvqY1SNZG9s5GlocKTkQ61w+d7s33GoMuf3voR6Dom9QZTQf4/vk7x5Zro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 556D168BEB; Thu,  2 Jul 2026 16:48:16 +0200 (CEST)
Date: Thu, 2 Jul 2026 16:48:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/5] ata: libata-scsi: refactor
 ata_scsi_report_supported_opcodes()
Message-ID: <20260702144816.GA25399@lst.de>
References: <20260702063412.1892584-1-dlemoal@kernel.org> <20260702063412.1892584-3-dlemoal@kernel.org> <20260702065321.07EB51F000E9@smtp.kernel.org> <akZmx5L1HLsb7-wk@ryzen> <akZ3gQq8w57IWCIC@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akZ3gQq8w57IWCIC@ryzen>
User-Agent: Mutt/1.5.17 (2007-11-01)

Who still cares about TRIM on ATA these days to bother with any
of this?

