Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A21A8405
	for <linux-ide@vger.kernel.org>; Thu, 12 Jun 2025 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737360; cv=none; b=b2M9lew7Iaj78bBYAp8YxcGSiXw2E57D7pRfLRSnKGZNrXzaGuP4WKKiKEyvkhqaOqBk0GnhYojOsQiohLM09Q7zHQ6A6LPmWuPjpZLzzqClxa7aX0XjlqzLQ4hOG8obgQ6L2p0oZOVKm/etxyL0xrlIRTOLyGiR3VeKrggRtEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737360; c=relaxed/simple;
	bh=9V0In3nijsMzAu37UB88LTns/cIdJ0ZmnA69tRKlmkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBaWyooHsxBRCku4sAy+SLl4rUUJuWNDJ5OAPbBXXjrBCEHBnWA8qLgOMNo6NBu3ZnNQ2z6NgNLVWwzDIYZwc7nbJFRa8QmcWMOffTp1+IKKgfmE5PLKGfGs9kSVd0Bj4GNZQIEcDdcH6ZEJXv5oM0iv7J4Y/U1J4wz/XnOeKOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBMS64yo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBMS64yo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59BDC4CEEA;
	Thu, 12 Jun 2025 14:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749737357;
	bh=9V0In3nijsMzAu37UB88LTns/cIdJ0ZmnA69tRKlmkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OBMS64yoIZW5Xw5zMy7ncDak6wp3wnGmwdpYbE/WjGEs3SVcR6dDULrf6o4CLmnv8
	 ReFs3DL5Lt14MqI9mDGrhgPUiAXJkMALv4JVaMDn/AuTL2V/PhcFh2US50c3eoNmwd
	 /z745vyWdk2In8U+IDAX4Glu+f2bNw2etsQtkpRCjoPrJ8cdZeX3F4Hvsb2VsYwbuN
	 NJx9a1SaxuRR7rkmrzVOKM3G4cWBjNsXmkiv8INaAIu9YrAWWqkQHqXSHw9zsDk/mS
	 2qyaSBNySMWHrIM/WCf8LbLCQXphdt+a7h7oHLq5ZOywOBSg9bZVRCWQ33p4nycxZc
	 QrIGkuU/cQl2g==
Date: Thu, 12 Jun 2025 16:09:13 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: kernel-dev@rsta79.anonaddy.me, Hans de Goede <hansg@kernel.org>,
	Andy Yang <andyybtc79@gmail.com>,
	Mikko Juhani Korhonen <mjkorhon@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 0/3] Cleanup ahci_broken_lpm()
Message-ID: <aErfiWakE9xrEUaR@ryzen>
References: <20250610110757.1318959-5-cassel@kernel.org>
 <174963787767.1635114.11613333221647910549.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174963787767.1635114.11613333221647910549.b4-ty@kernel.org>

On Wed, Jun 11, 2025 at 12:31:17PM +0200, Niklas Cassel wrote:
> On Tue, 10 Jun 2025 13:07:58 +0200, Niklas Cassel wrote:
> > This series cleans up ahci_broken_lpm(), and adds ASUSPRO-D840SA to the
> > table of boards with broken LPM.
> > 
> > 
> > Kind regards,
> > Niklas
> > 
> > [...]
> 
> Applied to libata/linux.git (for-6.16-fixes), thanks!
> 
> [1/3] ata: ahci: Use correct BIOS build date for ThinkPad W541 quirk
>       https://git.kernel.org/libata/linux/c/6f29d393
> [2/3] ata: ahci: Refactor ahci_broken_lpm()
>       https://git.kernel.org/libata/linux/c/e3ea4ae4
> [3/3] ata: ahci: Disallow LPM for ASUSPRO-D840SA motherboard
>       https://git.kernel.org/libata/linux/c/4b151c71

Patch [2/3] and [3/3] have been dropped from for-6.16-fixes, will rework
these as Mikko pointed out that the solution is not really future proof.

Patch [1/3] is kept.


Kind regards,
Niklas
