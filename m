Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B0D15884F
	for <linux-ide@vger.kernel.org>; Wed, 15 May 2024 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715795283; cv=none; b=Pb+nwfe+ZDQphTOHLOlQZrgmW4lHSi3IpT2NNJQE2uDFhe6zAIwddfbmCmIL7aA4EVaElbEywi1M21QAIYFxQg0rc9LNg6GZS6dh2JNp24w1EgQapdnxMBq4ts1zYaDIuwwHcXDFDRcxsS5b4RiL5QDYjzXhXLKiEvm47VNH4zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715795283; c=relaxed/simple;
	bh=yxfgK/5NMRvE2DrDwacqK9XPWhDBhvIz2rSM9v0Px0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2i7/G3IrBtciRZxdS/qb3Bq6XO0opcUiLbFq6rsOPLln451uh7jwFmqTpHYudGcSMsI5Bce31DVo1t9jp122G+HLgLFAj3dV8xorpnAeJGyotm/TFu8sEzxJsfxFaxriV+M+UW2EUjxkUSVU/zSRn7jJjb+APenUO47ppOSLfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqGqNKA5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqGqNKA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B861C2BD11;
	Wed, 15 May 2024 17:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715795282;
	bh=yxfgK/5NMRvE2DrDwacqK9XPWhDBhvIz2rSM9v0Px0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QqGqNKA5zOSLUPmYcvTaaZ0PuBQwQN9bGoH0Xal/zS1EZwzCPavmSxqzA1gW3gcgK
	 18FqvDF1ZtAn2LpTk/M587ZIE3fABldcsTu29RcZUNq6qCFbkTqOfMELh1i4UGsrB7
	 3VzjFRSvlK4pIyOrW1Fv6XB7/U+9gokaFftENEf7T2YFa/Or3AyaLwIpStosYKCJp3
	 5Kr7FcgmWG5pUluOvwABEEo5habmH2OrQ3Yawqv/XWlNizXaQUZIss9H1bo+JoCcce
	 HDNkUZOK5w+tNWRJu6VlzGmYgHfBo3/do/REHCZYgKTo7jny6Sp83EDvGqiR7e4Kax
	 PTzguc1/w+8Ig==
Date: Wed, 15 May 2024 19:47:58 +0200
From: Niklas Cassel <cassel@kernel.org>
To: dev@kayoway.com
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/1] ata: ahci: Revert "ata: ahci: Add Intel Alder Lake-P
 AHCI controller to  low power chipsets list"
Message-ID: <ZkT1TmxGDQ_hKcaj@ryzen.lan>
References: <20240513135302.1869084-1-dev@kayoway.com>
 <20240513135302.1869084-2-dev@kayoway.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513135302.1869084-2-dev@kayoway.com>

On Mon, May 13, 2024 at 10:53:02PM +0900, dev@kayoway.com wrote:
> From: Jason Nader <dev@kayoway.com>
> 
> Commit b8b8b4e0c052b2c06e1c4820a8001f4e0f77900f ("ata: ahci: Add Intel
> Alder Lake-P AHCI controller to low power chipsets list") enabled low
> power mode for Alder Lake-P AHCI adaptors in order to reduce idle power
> consumption, however this introduced a regression on at least one system.
> Revert the patch until a better solution is found.

The patch itself looks fine to me, but the commit message needs to be
rewritten.

Right now, we will enable LPM if the controller supports it
(unless the port is hot plug capable or external),
so we no longer have the "low power" board type.

Thus, it does not make sense to say that LPM is what introduced the
regression.

If v6.9 does not work, and v6.9 + this patch works, then the proper
commit message should be something like:


Commit b8b8b4e0c052 ("ata: ahci: Add Intel Alder Lake-P AHCI controller
to low power chipsets list") added Intel Alder Lake to the ahci_pci_tbl.

Because of the way that the Intel PCS quirk was implemented, having
an explicit entry in the ahci_pci_tbl caused the Intel PCS quirk to
be applied. (The quirk was not being applied if there was no explict
entry.)

Thus, entries that were added to the ahci_pci_tbl also got the Intel
PCS quirk applied.

The quirk was cleaned up in commit 7edbb6059274 ("ahci: clean up
intel_pcs_quirk"), such that it is clear which entries that actually
applies the Intel PCS quirk.

Newer Intel AHCI controllers do not need the Intel PCS quirk,
and applying it when not needed actually breaks some platforms.

Do not apply the Intel PCS quirk for Intel Alder Lake.
This is in line with how things worked before commit b8b8b4e0c052 ("ata:
ahci: Add Intel Alder Lake-P AHCI controller to low power chipsets list"),
such that certain platforms using Intel Alder Lake will work once again.


Kind regards,
Niklas
