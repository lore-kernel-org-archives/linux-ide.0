Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA36D29992E
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021745; cv=none; b=B4+AcJrMK7dDX1Vo3VK38sqhJjpRD2uL+8kn68JLwqKFqxk7sPaUzd5J9x5ViqYB0GP3wn6cE61HJw4eqinpdjpKw/4KFEwdE/4v3lzJGvONJvWjNGOP9vb2E+b4KEj38vAO3JTgy/cdgtECants3uTv6PF50xyIuXj/rk3QIXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021745; c=relaxed/simple;
	bh=8Z2jD09AGuqkxIyvj+XT5AEqoABRTQSKg0xJ35ErFP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXOUKadFsjiEmuFTaEBmGCT6xC1l+ClxRyJw8s7iTQBrr42UIiHTrQ6lMhuTe5JwgW1QsvCgdcomTYnmwYDxqs/3D3anl3/UKUomNxcnaJhdfm4qggSJ+EOLsGI9qjLKJ2QL80yzvGKbIuZ0o+NSb0IhkkfcN7/nuBtC6qJ5ITs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+W0slNX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+W0slNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9C8C4CEE3;
	Fri, 27 Jun 2025 10:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751021745;
	bh=8Z2jD09AGuqkxIyvj+XT5AEqoABRTQSKg0xJ35ErFP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+W0slNXpij9QYQjw9e0DR73KRovouu+xLw6hL9Jdd0mQdD/wEPXPmH2bGQBJG5hp
	 V+AP4aqO5ls4BZE/b0IC2myPzV1gD3gUTSVXwmDddDMsCeE+9bVQausc5bixj/FJPB
	 gkcfZUbtalWXsw2zr0ZgWAO9JlUzqv1cBZ6luaiSrXCfNks3IdZJmIhgg/p0Zv6JSK
	 92YHFINnXCCa0s6KNV7NUW0c3ZMgONvIxnbVYz3Vf2IGiuxAhvPNuh2bbmf3zQCHjL
	 wBLBi2M2L5uBP9S4BGde+c7i69+h6hPnq9kvLDfu1qPMB77iTOfYR/s7/Zf9zBRJxa
	 3DJIFbb6C3LOA==
Date: Fri, 27 Jun 2025 12:55:42 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 6/6] ata: libata-eh: Move and rename ata_eh_set_lpm()
Message-ID: <aF54rsmrdoIHl14M@ryzen>
References: <20250627075207.23969-1-dlemoal@kernel.org>
 <20250627075207.23969-7-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627075207.23969-7-dlemoal@kernel.org>

On Fri, Jun 27, 2025 at 04:52:07PM +0900, Damien Le Moal wrote:
> Move the definition of the function ata_eh_set_lpm() to avoid its
> unnecessary forward declaration and rename the function to
> ata_eh_link_set_lpm() to clarify that it acts on a link.
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
