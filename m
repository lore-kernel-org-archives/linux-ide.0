Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2528B18BBBF
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682726; cv=none; b=fov/bwf20YLvRb7zrTndEZTMBl/fAhbBJaSFoqGgJZUR6N2lYL+5vAhpIc7jdmXmKt3wPLmo20ugPXZv8X1F+4ocAxe6mb53Q5io8ujHSKIBvualEK7OWO0Gha5yC8d3MmYzlennjMcSc8wNVWJt0PewwWhIXNp1R9jRJ0Wczp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682726; c=relaxed/simple;
	bh=0BkzL/Dwk/xS/8oKZoWIXZxKVnl4y+dIwn5yeiHGL6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqJPgMUa8FZM+ttBZnd8FjLGR08yDU/lAoeABNddAhLlzolEOlDH5nnR5w07mc6MG5iLqAt8ZBjz/aNsndzaxJy5BZX0444/s1xlp+UzM7rlV6uEMH3xMDrhHgr6Ikc+N2xqVdv6U4OC879G8vNNzu8x8e1/ThlR7QYkcA1JXbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJy39sBH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJy39sBH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008B8C52FEE;
	Mon, 26 Aug 2024 14:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724682725;
	bh=0BkzL/Dwk/xS/8oKZoWIXZxKVnl4y+dIwn5yeiHGL6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KJy39sBHnYaT0QA0CJfyCWvwIh0jE6S71cwuyJRLN5HGXVY6ItcNdD0E/fKVibPhm
	 4ZyJVNcilIX171Jhr0I4QCYnNfZTg+8glejorxRN+0rjEh7SbiBrn8oGtrC14vot8U
	 CPVB0oTadX2spyqiEkLnvqRT3fz462CREgqzQTTOgI2djhk/R6hGqfwsaW2pdYNA+g
	 e32j3+chzc7SN+oZ/ncn/eQuI3dkJQaDhJH1o9x1d5EOAWJqgwTkBWWKIyO+5yrEOu
	 4v7lJjzuGTADRxQrAxkhGhwj0R0QxhnbItziNX32ly0JkAuZwQd3cFDooPxdb+0Ysd
	 FsJNVhCcO9YVQ==
Date: Mon, 26 Aug 2024 16:32:01 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 0/7] Code cleanup and CDL memory usage reduction
Message-ID: <ZsyRxce9YCw_FWvP@ryzen.lan>
References: <20240826073106.56918-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826073106.56918-1-dlemoal@kernel.org>

Hello Damien,

On Mon, Aug 26, 2024 at 04:30:59PM +0900, Damien Le Moal wrote:
> This patch series starts by moving code that is SATA specific from
> libata-core.c to libata-sata.c, without any functional change. The
> benefit is a smaller ata code for hosts that do not support SATA. This
> is done in patch 1 to 4.
> 
> The second part of the series (patch 5 to 7) cleanup the CDL support
> code by moving device resources from struct ata_port to struct ata_dev
> and reduce the size of struct ata_dev by allocating buffers needed for
> CDL only for drives that actually support this feature.

I think that you should reword "... by allocating buffers needed for
CDL only for drives that actually support this feature".

When reading this sentence, I read it as a claim that the current code always
allocates buffers needed for CDL, even for drives that do not support CDL.
However, that is not true.

ata_dev_config_cdl() currently allocates ap->ncq_sense_buf, after, and only
after, checking the Command Duration Limit Supported bits. If these bits are
not set, we "goto not_supported;" before ever allocating ap->ncq_sense_buf.
So we are currently not allocating the ncq_sense_buf buffer for drives that
do not support CDL.


Kind regards,
Niklas

> 
> Damien Le Moal (7):
>   ata: libata: Fix ata_tdev_free() kdoc comment
>   ata: libata: Improve __ata_qc_complete()
>   ata: libata: Move sata_down_spd_limit() to libata-sata.c
>   ata: libata: Move sata_std_hardreset() definition to libata-sata.c
>   ata: libata: Rename ata_eh_read_sense_success_ncq_log()
>   ata: libata: Move ncq_sense_buf to struct ata_device
>   ata: libata: Improve CDL resource management
> 
>  drivers/ata/libata-core.c      | 189 +++++++--------------------------
>  drivers/ata/libata-eh.c        |   6 +-
>  drivers/ata/libata-sata.c      | 125 +++++++++++++++++++++-
>  drivers/ata/libata-scsi.c      |   2 +-
>  drivers/ata/libata-transport.c |  11 +-
>  drivers/ata/libata.h           |  23 +++-
>  include/linux/libata.h         |  34 ++++--
>  7 files changed, 217 insertions(+), 173 deletions(-)
> 
> -- 
> 2.46.0
> 
