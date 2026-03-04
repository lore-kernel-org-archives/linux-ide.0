Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B463372672;
	Wed,  4 Mar 2026 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772626119; cv=none; b=uL63O7YfjjkHcDdVHeMHhH6bNN5h06odNHJR7UNahAmynF3gMTqVnzEz1Haunc1zsLBjg7MBM6pGlaJRD53X0Q6QRMWWOnoj6QH64YgNElP4x0JmQyPXuUGQ/aUL7Lmg757pF/EpFmTSWrWAyTbKq27VPnZsyy/jTaNq99VcKU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772626119; c=relaxed/simple;
	bh=5ZfuA/EH8yUb+g43W1Why+xjnCotqjTVWLOn3Gig+Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8od8dmA+mM/JEyHDUZqIEhdjb2iB/DufY569mhnFtVyco8u/q/HqI4O4p62tHCqTex+jqbmG8PR+rE2WFvE5yRXzccK9F2zwOq1HuqjODwcaqNu11lb6OendUG7c6cX0TpyPJMHIc1Vu6lANIjbhqkWAAblJbVD5n+ck8fg7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZULyTEXL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZULyTEXL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F66BC19423;
	Wed,  4 Mar 2026 12:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772626119;
	bh=5ZfuA/EH8yUb+g43W1Why+xjnCotqjTVWLOn3Gig+Vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZULyTEXLhw2YfI+odO5ovM5idFdJ6DY2dRPWsh+/OT+0SspalBiZgQZ0U44kGrsNH
	 UhNyefnaWJb3XEigBWZKGP84K0FMN8thT4bv0MAdq5dvgf9rx16vZ3PIEIP4ZEZOde
	 DL1oFwAqy3LIzyZYOeQZsI1lg9V9ZNEKIqtKyyh2VllrmKWDpjELY1oT1uVQ2LPRhd
	 7ACZgRaYRryJmVva97tL6p2ZQ040sktOs7tFNXSifah7nLcGlutnNbk6oQbJWvVdpc
	 VkltUrafq3QYzbV9uiEKHl+hPn+4B3ul17vQ0yUPASwgyz+yy3LCq91WP5ok+yCS39
	 A0rSnapk1+YTA==
Date: Wed, 4 Mar 2026 13:08:35 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Add BRIDGE_OK quirk for QEMU drives
Message-ID: <aaggw9ezzeY2_aEO@ryzen>
References: <20260303183337.1013474-1-pfalcato@suse.de>
 <aaf5f1_131S1aVnm@ryzen>
 <azwfeaf5hdn5g2vutuhzkjl42ld52vyjs4go2coer3yuagiep2@r5hejnknuwj2>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <azwfeaf5hdn5g2vutuhzkjl42ld52vyjs4go2coer3yuagiep2@r5hejnknuwj2>

Hello Pedro,

On Wed, Mar 04, 2026 at 11:23:01AM +0000, Pedro Falcato wrote:

(snip)

> So, does this look better?
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index d61846f03edc..c57e35ccc092 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4231,6 +4231,7 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>         /* Devices that do not need bridging limits applied */
>         { "MTRON MSP-SATA*",            NULL,   ATA_QUIRK_BRIDGE_OK },
>         { "BUFFALO HD-QSU2/R5",         NULL,   ATA_QUIRK_BRIDGE_OK },
> +       { "QEMU HARDDISK",              "2.5+", ATA_QUIRK_BRIDGE_OK },

Yes, I would prefer that.

When booting a device that has quirks applied, we will get prints in dmesg
showing which quirks were applied.

It would be nice if we could avoid applying quirks for QEMU when (sometime
in the future) a newer version of QEMU is available that does the right
thing.


Kind regards,
Niklas
