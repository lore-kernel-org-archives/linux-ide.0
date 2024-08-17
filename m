Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09EAB657;
	Sat, 17 Aug 2024 03:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723865568; cv=none; b=nO+hsoT0aznmGfe8Of60PyU/LRK4FdCM4+2k+SGLoahXrhPJtsPzS3qYEnT3baiam0UpJ/x9YPJdy3docOcrLsVeSrp8o/l0v1AwrHpmE20RLmuOKRa5uK9S4oD22gCsiaPZwz7r9BJb6xPu7FC7L+pRbQbQdwQ/t7vqYKHZBOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723865568; c=relaxed/simple;
	bh=nSE4dL834icS6K3nNDujrW02xUkUt3UKWZcZ5UWfLv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfi4TGzOqNgLwa7R0PtCTg6eW/fcbRDcLaUEUqU5MGOhEfwqEdC8qH1YHo+CulojgFNdY8SmQYtUPm3bx7c9SqYDEwp0vTE+jwYD+fzDJsQEDBSVirAJARi9SX8BGbAfIBxjLI+s5fQRmu2BCYEv3MA6K+pTn6hqmyKzk1Z0WEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2521D68AA6; Sat, 17 Aug 2024 05:32:36 +0200 (CEST)
Date: Sat, 17 Aug 2024 05:32:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Niklas Cassel <cassel@kernel.org>,
	=?iso-8859-1?Q?Kolbj=F8rn?= Barmen <linux-ppc@kolla.no>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	=?utf-8?B?Sm9uw6HFoQ==?= Vidra <vidra@ufal.mff.cuni.cz>,
	Christoph Hellwig <hch@lst.de>, linux@roeck-us.net
Subject: Re: Since 6.10 - kernel oops/panics on G4 macmini due to change in
 drivers/ata/pata_macio.c
Message-ID: <20240817033235.GA28774@lst.de>
References: <62d248bb-e97a-25d2-bcf2-9160c518cae5@kolla.no> <3b6441b8-06e6-45da-9e55-f92f2c86933e@ufal.mff.cuni.cz> <Zrstcei9WN9sRfdX@x1-carbon.wireless.wdc> <87sev81u3f.fsf@mail.lhotse> <Zrt028rSVT5hVPbU@ryzen.lan> <87jzgj1ejc.fsf@mail.lhotse> <Zry58qB80V80uS38@ryzen.lan> <87jzgg2fqg.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzgg2fqg.fsf@mail.lhotse>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Aug 17, 2024 at 09:46:31AM +1000, Michael Ellerman wrote:
> Same behaviour on a kernel with PAGE_SIZE = 4KB.
> 
> I don't know why max_sectors_kb starts out with a different value on my
> system, but anyway the bug is lurking there, even if it doesn't trip by
> default in some configurations.

Various distributions use udev rules to increase it.

