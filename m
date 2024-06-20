Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B519B3E1;
	Thu, 20 Jun 2024 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894404; cv=none; b=fQ2aB6/JXklbssRmNrtx9TMAXEloqO6cOI7LZmfi+iqWWCiuLlEdYYA5+Q8nV7LbpI/gHmqSMNJrnJt0YaxUsJiKAuDgJnraddYhE2mUu7M+JsTebb3iPyOGxm3blLgu3a1jEmP16hQnTLOCq60j0Z2ofe7COOZ7Q7XE/aY4ifg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894404; c=relaxed/simple;
	bh=8A1b5XkjJWS29AcEIsAEpOXHPWFnaAPkhpp6MHywu38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFf6ZxfLUdNV3tlMGYzoi5rZu5c4JEkEK5HQ0gwoh4jn5zHvVab3N7N00TVl9+wDVlq6C7deIXXG+vaZXA90apWUCk3S75PEFLc3ttZ3cWD5PBe101mypF1bC7guB1UapSjZ6v+IAB2vU4UPr1TgRaMIDueurXAn5hWW7j/pqw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkwtjcqy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkwtjcqy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C063C2BD10;
	Thu, 20 Jun 2024 14:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718894404;
	bh=8A1b5XkjJWS29AcEIsAEpOXHPWFnaAPkhpp6MHywu38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jkwtjcqyrKp08hYXVEX/AacCjUT1P+H/azlAYgFSUEK2oaOTidJowCwfBBye7CEKF
	 RYhjXaLby02aTVaIXz1RneMar/Cjg8K08ENkTTYkvc5MoP0BdQkOjqsUR33p/YwbXd
	 qGU2iai9e03Rz0L/XXiJw708gjkUCSmvqaEOF8v09ePxAU9auK8Wv+k6UZnTK84R1b
	 93ASuVyDcID6JjYLRD56cEGv8tt/4H8Yu8lRNv1RMU1sbmO/f/I/WLow/shEH7sfVl
	 CDQPaUZWdxefnw6/qhsOXW/Fl+VLgwrVVazwUIHPUDp5PQvKcxrW9Svi2cjTDjozGq
	 a3V8QJiFBHGrg==
Date: Thu, 20 Jun 2024 16:39:59 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] ata: libata-scsi: Report valid sense data for ATA
 PT if present
Message-ID: <ZnQ_PyYbX3n1XyQN@ryzen.lan>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-4-ipylypiv@google.com>
 <ZnAUy5C-DXEuliSm@ryzen.lan>
 <ZnDHZWZQFtUmwtwE@google.com>
 <ZnQ7i0D4syhhI_hO@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnQ7i0D4syhhI_hO@ryzen.lan>

On Thu, Jun 20, 2024 at 04:24:11PM +0200, Niklas Cassel wrote:
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index bb4d30d377ae..a0687eb28ff7 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1645,9 +1645,17 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>          * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
>          */
>         if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
> -           ((cdb[2] & 0x20) || need_sense))

Hmm... I just noticed that we don't seem to have support for ATA_32 commands.

We should probably add support for that sometime in the future.

(I don't think that it makes sense to do it as part of this series.)


Kind regards,
Niklas
