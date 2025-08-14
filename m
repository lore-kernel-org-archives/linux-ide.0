Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188D8280018;
	Thu, 14 Aug 2025 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755164454; cv=none; b=iRjUnljlOcN+6NZmNNZaazlZpUDvuvd7ugWhAivy7u3rVn79s0eLKqbLJIs2/MQcF5tbubSNk4a5IvA1OcTkYtZZ2Br9MkSc5cdzkg36c2TxU0QZKkq3AiAia/yzPi5yo495kbdGCI1qPRmWsezqIXCLFJsmh8hyt9/PxAXvB4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755164454; c=relaxed/simple;
	bh=gDkX0qxA79o3j3rXjdK5coXhRypnjdNu0iwhv+WMTYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHnVZS/z6HG1A/L4fAtWRohfZIGXQ3wPL5sFRXN42Y3yND1H6YCe5IEtvnzS2pNuxxmIN9einDD6tFXKJHJgAA6S3etOG97BdV2XkGNuF+5Uw58uduf4szYSH1zpp84zBle+AZPEc91kuceEqwDcGjX1TXr6zYC42o0cTU8/Ww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxC+UoLK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxC+UoLK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F6FC4CEED;
	Thu, 14 Aug 2025 09:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755164453;
	bh=gDkX0qxA79o3j3rXjdK5coXhRypnjdNu0iwhv+WMTYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QxC+UoLKFRTxiCvHBT4qiRPW/jBbrSbK+2/HQW2Rqy3cvgVOq/pol2pCh1y5aHhmP
	 bw4llWC9kw86fJ8keWORQ982rZQ4wlKdy4J0HWhUHnc77aObKMpVH2A+br+h9Eq5bk
	 spwbBWKN2nlxCIj9w/07EFbkBfKSmI+4BGjJHxMWMQ+juNA6CGUSw8Yydw9IHU5n3q
	 d81CnKKVmjm+KlN+t76H0GRpv4AJin2uCJ7er+60W0fe8IXkoZyzUGA3iKACrYX5br
	 b6RZjY07SPScuGOmL5OS5e42AKymzfHTM7GznVFU5tvgdFprxnIib58VWxT02y1JV4
	 Ve8BV95qWpUFw==
Date: Thu, 14 Aug 2025 11:40:49 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata-scsi: Fix CDL control
Message-ID: <aJ2vIRxStgzJACFQ@ryzen>
References: <20250814022256.1663314-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814022256.1663314-1-ipylypiv@google.com>

On Wed, Aug 13, 2025 at 07:22:56PM -0700, Igor Pylypiv wrote:
> Delete extra checks for the ATA_DFLAG_CDL_ENABLED flag that prevent
> SET FEATURES command from being issued to a drive when NCQ commands
> are active.
> 
> ata_mselect_control_ata_feature() sets / clears the ATA_DFLAG_CDL_ENABLED
> flag during the translation of MODE SELECT to SET FEATURES. If SET FEATURES
> gets deferred due to outstanding NCQ commands, the original MODE SELECT
> command will be re-queued. When the re-queued MODE SELECT goes through
> the ata_mselect_control_ata_feature() translation again, SET FEATURES
> will not be issued because ATA_DFLAG_CDL_ENABLED has been already set or
> cleared by the initial translation of MODE SELECT.
> 
> The ATA_DFLAG_CDL_ENABLED checks in ata_mselect_control_ata_feature()
> are safe to remove because scsi_cdl_enable() implements a similar logic
> that avoids enabling CDL if it has been enabled already.
> 
> Fixes: 17e897a45675 ("ata: libata-scsi: Improve CDL control")
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>

Reviewed-by: Niklas Cassel <cassel@kernel.org>

However, like Damien said, we really need to improve the API so that the
SAT can know if the command was success or failure.

That way we could set the flag only after the command was successful.


Kind regards,
Niklas
