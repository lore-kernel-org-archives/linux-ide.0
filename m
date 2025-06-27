Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C17C29A32A
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021625; cv=none; b=L8TUeysKwOnuL0mIgCOdhHWocCFKlRHfhg7cvBcDYU8rCKGIfcAa4UHYUq1x4kooEa+nOES+93SHFJtVbD+TA3MpQ8Tva7xjwUtwBmFiOGn/ZGUD7zsbe8Z20eu8Pa0U0KSrosKMAXhcRSQpMNIuNnMhpERvpBJu8wFasiMh8O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021625; c=relaxed/simple;
	bh=Daw3aa2GkbDE+Tr0Jel0uGTE+bVV5YI7YYu1Ff5sAfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+iQyrM8YHQ0jUYtjaUCgamgZuet+EbPW3TKM0Y4Frr3kJRJ+D+/rZpph454txMt7wk/Hk0Mm/E/AyFU1e6t9aS2xXDvGh+RTYoolQCaefQ8fIj8uon8laQwYUOb5GMvKJyFNj+jzRy4RRgo1N6gu7sKhDcd3uyW2hrBngUTX+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByFZrxZo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByFZrxZo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F920C4CEE3;
	Fri, 27 Jun 2025 10:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751021625;
	bh=Daw3aa2GkbDE+Tr0Jel0uGTE+bVV5YI7YYu1Ff5sAfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ByFZrxZoN9lWguneh5rI1p2Xn4asSDZutgAubg7HdFHtlKKuEa5UE/2R5REhKzk9T
	 sNoTigncWBtf8Vz0SRHkFXteIfOnlK0fcC68TUYZVPL3X6MYDw0RE+dGwL9TJtLBcb
	 4eOtcTIGfHyoRT20ULhF86Cy3jF6cRKTZZiYEbd4s3ak2JONvqIaEVNdfjFFDtbBjQ
	 rlkjDHhsBN2QvF4bE2hspYO1J0y9hhww+Hm/TJtTzTVQ+18gNKnW4DZM0/eJOfwQFa
	 07n61jY40I6K+TYsQlSPNiZNuOT65iVp3d+GBo3RydFRPdsOUkTvXvtoxnsQ2qL1ix
	 7QaspCLh3Dp+g==
Date: Fri, 27 Jun 2025 12:53:41 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 2/6] ata: libata-scsi: Cleanup ata_scsi_offline_dev()
Message-ID: <aF54NSFRkq89UtU5@ryzen>
References: <20250627075207.23969-1-dlemoal@kernel.org>
 <20250627075207.23969-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627075207.23969-3-dlemoal@kernel.org>

On Fri, Jun 27, 2025 at 04:52:03PM +0900, Damien Le Moal wrote:
> Change the function ata_scsi_offline_dev() to return a bool and change
> this function kdoc comment to have the correct mention of its call site.
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
