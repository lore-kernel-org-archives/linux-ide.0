Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8E176ABA;
	Fri, 21 Jun 2024 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718970101; cv=none; b=Z4uaD/g3+FacdzICSdiglL2B8JdVlfe0wH5GKfnmTB/rDKEE2CJx/6kyyH1HRiAkM/FjD6dw/dEi94N+DQXn9Zobe5mK4kDXNbosVOkI81NUQ2mqcYkvHos+aouihtHZanUn1lhb4nS9ItTlhZVoaqfoyMxmaAk5OgCCWHSxYH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718970101; c=relaxed/simple;
	bh=EENKriqcUosyBwebOuQyqUuOakrjeRRQo/qqQGWIARY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boupkN1H2vbNejg1q4i5uBDDMzJ7APC2VNgVj4/NLRgo95t6+8RtbwafJKVthQ4DfyVpP+bwgzuU6stxKEAhGd2PDAFf5BbKcOZlC2KiG1hrMzJsECdDAlGhwD+M8cavqWK+ihE5VZZjHu4/p1oQpabM1m+JrrCn1DwykgrsJNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8a6+4ZR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8a6+4ZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7E1C3277B;
	Fri, 21 Jun 2024 11:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718970100;
	bh=EENKriqcUosyBwebOuQyqUuOakrjeRRQo/qqQGWIARY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8a6+4ZRa0avGsf3+QFxZk8VzyAUkhITS3N7a3ISc8lgPPQqeq2mqg66uKa66H3xD
	 vYGhqcOouh5+91oIqmI6wHk+4H6U9wq5fvNw8qYT/jjvfoyOoO9hGhqUivt4ivoxHZ
	 6vFhdeIy5c1k6KOvVzkEMV0qSxY4AXdKE0v9TJfo0OIKnsHMSG97MnsdeVcLlAu2BU
	 2baTvIo57KpAfZflzWedaUhJhzLe0UifOhd0zX7EE0rIiKMUeKSyRxBVz10pCD7hLX
	 A/3/72W6Ks2TwgyErxgGCFqFJFvdFh2m2Ajzvwnk8LiBfGcEBACdNEjUKzV5FTCDHE
	 2LqMuBEDwefTw==
Date: Fri, 21 Jun 2024 13:41:36 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] ata: libata-scsi: Generate ATA PT sense data when
 ATA ERR/DF are set
Message-ID: <ZnVm8Ah2KyvosTs0@ryzen.lan>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-3-ipylypiv@google.com>
 <ZnAeFbdt02zge2my@ryzen.lan>
 <ZnIBdj02yKFz4sK8@google.com>
 <ZnQm3-OL95x_Z_VP@ryzen.lan>
 <e25962a1-cd0c-47c9-9e10-008c475f22cb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e25962a1-cd0c-47c9-9e10-008c475f22cb@kernel.org>

On Fri, Jun 21, 2024 at 09:05:33AM +0900, Damien Le Moal wrote:
> On 6/20/24 21:55, Niklas Cassel wrote:
> > 
> > Perhaps we should modify fill_result_tf() to set ATA_QCFLAG_RTF_FILLED,
> > after it has called ap->ops->qc_fill_rtf(qc);
> 
> Yes, let's do that.
> 
> > Then this code can check if ATA_QCFLAG_RTF_FILLED is set, like you suggested.
> 
> And I wonder if we should not just drop ATA_QCFLAG_RESULT_TF and *always* set
> the result tf for all commands. I fail to see why this is conditional to that flag.

I'm guessing that originally this was just an optimization, that you did
not read the taskfile register for a command that was completed successfully.
(Since they did not see a need for it.)

And a command that failed would have gotten an error IRQ anyway, so the
result TF would be populated for those.

I'm not sure how much time we save by not reading the TF register for non-NCQ
commands... Most likely it would be possible to read the TF register for all
drivers for non-NCQ commands on completion.

E.g. we set the ATA_QCFLAG_RESULT_TF flag for internal commands and for
ATA-passthru commands, however, both of these are non-NCQ commands.



I think it is NCQ commands that are the problem...

For AHCI it is possible to get ATA status and ATA error, for NCQ commands,
if we extract it from the FIS rather than reading the PxTFD register,
and this is what we do in ahci_qc_ncq_fill_rtf().

Probably, most other drivers could also extract this from the FIS,
if we spend the effort on implementing that for every driver.

But if we don't do that, the drivers will read the TF register,
which e.g. for:
https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/ata/sata_nv.c#L1400-L1407
doesn't seem to work for NCQ commands.

So I'm not sure if we can remove ATA_QCFLAG_RESULT_TF, but we could
definitely set it unconditionally for non-NCQ commands if we want.


Kind regards,
Niklas
