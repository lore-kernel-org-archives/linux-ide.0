Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD4436E497
	for <linux-ide@vger.kernel.org>; Wed,  8 Jul 2026 22:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783551289; cv=none; b=M1bxkeB8qR7UcgEonHgcXPaWOIuYpWpEmYgtrZJ5wTvdgtanW40xYV5mmGfHeXhebTaShmtI/8pDKgKKVjlv+qvxgPFyWd0+wH0B53qZmkoSej9EBA5eQhKkMZOLq1Q/BH2qg2/j+6UqYvEm67/UD6kjs5NchYzergwU34CxuCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783551289; c=relaxed/simple;
	bh=IN5DvaMS4IhuO5oQ7MccDIsd/xhFUB/k+MlIiFZ69H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8JgiJnSytkf1144iMi+OrSH+8ttsht+FqFaIkcmatiUHUf/cPtsSo2RwsU6MYB9F3+gTwEQn2zvt+9nf4bo82mVrpvbOxzS04IEjyLSRjQoU+67S/sUxoVJHu6v10vpCjpnGrxcnKke9XpLQSDuaD8TDqTCetHoCYJRTZ0SjUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmDqgjil; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmDqgjil"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17601F000E9;
	Wed,  8 Jul 2026 22:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783551288;
	bh=xJ7AZLW3Rpo0o5RJKbokLf1itPfIscMTiOVnjQ5ZZ8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KmDqgjilAIMxd56Em70bx6OTm5DY6XOWSfCtPCeRw0iAdiRAtWcHU3CTwzEZaJkoM
	 GwGzTUD6MW8f87WGV9Isw9h/p5NUQZ2eThRzocwortQ3PK05/s3svYTVB1PmdqGRJ+
	 wVs2XNV7S6hMxSdp6EtewYFe2k9prHOVJK1IyNAfxB48TYn+EWjAUKsc9CA/4PTAyU
	 PaJsmBEPTrazUQ/nbwvH6E3YQly1HOPxZdXOFG4JenMxJvheGP1PRLi+Tzhebex9ym
	 QVTGIqlCi3kmTglCDWePSpc6zUPD+hURohynPJ9KVL4BnQwJGUYHyca0I0Mp8YCoPC
	 RKVPVWih/3J+A==
Message-ID: <47cd5979-0950-4653-99a0-d4fa23bf9fba@kernel.org>
Date: Thu, 9 Jul 2026 07:54:45 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SCSI EH wakeup deadlock from deferred_qc
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20260708193644.671852-1-ipylypiv@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260708193644.671852-1-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/26 04:36, Igor Pylypiv wrote:
> Hi Damien,
> 
> I've stumbled upon an issue where SCSI EH didn't run upon command timeout
> but ran ~10 or so seconds later. It seems like a recent regression from
> the introduction of deffered_qc.
> 
> When an active command times out while a non-NCQ command is waiting in
> deferred_qc, SCSI EH fails to wake up. Recovery stalls until the deferred
> command's own timer expires.
> 
> When an NCQ command times out, scsi_timeout() calls scsi_eh_scmd_add(),
> incrementing shost->host_failed (1). However, when scsi_eh_wakeup() checks
> whether to wake the EH thread, scsi_host_busy(shost) counts 2 active
> commands (1 timed-out + 1 in deferred_qc).
> 
> Because busy (2) != host_failed (1), scsi_eh_wakeup() refuses to wake
> the EH thread, deadlocking error recovery until the deferred command
> times out on its own.

Igor,

Thank you for reporting this. Let me have a look.


-- 
Damien Le Moal
Western Digital Research
