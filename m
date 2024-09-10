Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE59819EEC8
	for <linux-ide@vger.kernel.org>; Tue, 10 Sep 2024 23:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726009598; cv=none; b=WNuKVgC6Pq/ZxYVOVr39mCpql5pMgYLxfML6agp4odeof8UH1qo8+rRJombE5Gn4pUvDchVqT3uJ9+bI1AGVZciagKj6OiwLSztMfo7etOV9kr9fpvN/FY/W55jeS0c/Vpbp+x40aU6/OnEujDIoRsWoGL2yOnf8Y2Cdh/ZrziE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726009598; c=relaxed/simple;
	bh=vL28SahHB156QS6nlaVC4Nqaos7HBWAVLujMV6jbeSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1CvBcWfDN/0N8FxZiFA10FlcTOVeU9lJoATHJDZ++fIArsSywoQv7+/rRySKluMfqVVrIyFxmhuqm1FLyuN8OL2h83ljrT39x36GG9u2tcrshIzZw1Y6nZVgNsuC9LUMnaG6btYK/tvhZEko2cJPzp7BjnIUXgNx3GF2bP1AnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5g3WELG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5g3WELG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90682C4CEC3;
	Tue, 10 Sep 2024 23:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726009597;
	bh=vL28SahHB156QS6nlaVC4Nqaos7HBWAVLujMV6jbeSs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h5g3WELGgMJ2QFDVcAWeZX3Grv/sol/MPU+jWgYBL2eBmjNeUVAqdJIi3gKFAH+Tp
	 aYp2jZDJzVgpyIJs21K6GUIBK9lCss77Mc+Ic4s43X1Y/+B8K9FYAyYYtpAZKcBuaK
	 LMl46QoeTOAPdgdt7+hPHfvKTsTgW8OanK/wNRDpq5hZd/JHCBkUThSjdd3s2I+09j
	 8YtUpc9SxG0qBVebg5TDoLVe+9q8YgwuL/wZl/K12V4TzXXkJwv458rNlrzFLt9nod
	 7EoQJVK5943QL5QQ5PjUX5EzXaBh/2Q3+IhHEK10U9H41NmHiveAVVXd8QcnmXzUbm
	 eVujRQHM0EBMA==
Message-ID: <361b6d8d-316f-4fa7-b761-1f98e317935a@kernel.org>
Date: Wed, 11 Sep 2024 08:06:35 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: libata: Clear DID_TIME_OUT for ATA PT commands
 with sense data
To: Niklas Cassel <cassel@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel
 <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
References: <20240909154237.3656000-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240909154237.3656000-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/24 00:42, Niklas Cassel wrote:
> When ata_qc_complete() schedules a command for EH using
> ata_qc_schedule_eh(), blk_abort_request() will be called, which leads to
> req->q->mq_ops->timeout() / scsi_timeout() being called.
> 
> scsi_timeout(), if the LLDD has no abort handler (libata has no abort
> handler), will set host byte to DID_TIME_OUT, and then call
> scsi_eh_scmd_add() to add the command to EH.
> 
> Thus, when commands first enter libata's EH strategy_handler, all the
> commands that have been added to EH will have DID_TIME_OUT set.
> 
> libata has its own flag (AC_ERR_TIMEOUT), that it sets for commands that
> have not received a completion at the time of entering EH.
> 
> Thus, libata doesn't really care about DID_TIME_OUT at all, and currently
> clears the host byte at the end of EH, in ata_scsi_qc_complete(), before
> scsi_eh_finish_cmd() is called.
> 
> However, this clearing in ata_scsi_qc_complete() is currently only done
> for commands that are not ATA passthrough commands.
> 
> Since the host byte is visible in the completion that we return to user
> space for ATA passthrough commands, for ATA passthrough commands that got
> completed via EH (commands with sense data), the user will incorrectly see:
> ATA pass-through(16): transport error: Host_status=0x03 [DID_TIME_OUT]
> 
> Fix this by moving the clearing of the host byte (which is currently only
> done for commands that are not ATA passthrough commands) from
> ata_scsi_qc_complete() to the start of EH (regardless if the command is
> ATA passthrough or not).
> 
> While at it, use the proper helper function to clear the host byte, rather
> than open coding the clearing.
> 
> This will make sure that we:
> -Correctly clear DID_TIME_OUT for both ATA passthrough commands and
>  commands that are not ATA passthrough commands.
> -Do not needlessly clear the host byte for commands that did not go via EH.
>  ata_scsi_qc_complete() is called both for commands that are completed
>  normally (without going via EH), and for commands that went via EH,
>  however, only commands that went via EH will have DID_TIME_OUT set.
> 
> Fixes: 24aeebbf8ea9 ("scsi: ata: libata: Change ata_eh_request_sense() to not set CHECK_CONDITION")
> Reported-by: Igor Pylypiv <ipylypiv@google.com>
> Closes: https://lore.kernel.org/linux-ide/ZttIN8He8TOZ7Lct@google.com/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Applied to for-6.12. Thanks !

-- 
Damien Le Moal
Western Digital Research

