Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826611F03D7
	for <linux-ide@vger.kernel.org>; Tue, 24 Feb 2026 00:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771894097; cv=none; b=kvHbOADDMUzLcS237a05xrs5v5f8ers+Yf8/A59E8Aj4y22jJ6W30eCZ/biMLvPYu6J40yUYibDlQGPrxb5gLzj1Jc+14UYAUidNifd3+0TyQgojQuNfQ0C/j9gpgkHOIkxETz+MBf/vbiCopGz96YBtXkY58g1cNET9eU2ShXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771894097; c=relaxed/simple;
	bh=GfS4SkeaBSzdcvmwwegU2lim/gFvZs6IlKz/zGh5Q9s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ecnTidcQhOfgqnmtjS83ceXd0W6xdr+q65sW5lujaOjbaKlW0dlLYBWeXwB7QmPfPkjxMqlL94Q7p7Axdoecge/RZ0d21TCoP/Hle9hVGmBANf347Ln2+3rw4TF+5I1kS8iaq2I59dl8FFIQGA0pHgQhYZlf1TE/ki8KqK99+i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzoPRmaS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzoPRmaS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDBFC116C6;
	Tue, 24 Feb 2026 00:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771894097;
	bh=GfS4SkeaBSzdcvmwwegU2lim/gFvZs6IlKz/zGh5Q9s=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=qzoPRmaSDLa2xm8tRMPjSUSAFqdApf/kmBh0TXvUieHhskNkTVC2x6g8zrY3dADdc
	 RoNB8SYDyWIOeKuoaM2EKgTGl8aqScqpVB+Iu3S6G5HmaZvev9BwUfPA6eIEQbMKe7
	 DESq7eVg47sIMJoWEg8p39DmLP2YeJITbjSAhuPuu6cXJltolh8VhSqf8Orh5Q6jYF
	 rWwMDnzZFEuVdVSk9cZ7GrPmaXkWUNhzKSInzZ0WsLq4mmRg5JoyF7qFw/eOqPL90Y
	 q/CKCk56UTmSDYSdvY5FAmoA/5Towoz19s2+Okhvt9S4W+uZHCqDh/Wqp7xQg1foTO
	 c9nd9NXmtnesg==
Message-ID: <9e33f859-8222-498f-a609-c4971ad7c97c@kernel.org>
Date: Tue, 24 Feb 2026 09:43:00 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] libata cleanups
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
References: <20260219062312.1030867-1-dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260219062312.1030867-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/19/26 3:23 PM, Damien Le Moal wrote:
> Here is a set of patches to cleanup a little libata code. Except for
> patch 1, there are no functional changes.
> 
> Damien Le Moal (5):
>   ata: libata-core: improve tag checks in ata_qc_issue()
>   ata: libata-sata: simplify ata_sas_queuecmd()
>   ata: libata-scsi: simplify ata_scsi_schedule_deferred_qc()
>   ata: libata-scsi: make ata_scsi_simulate() static
>   ata: libata-scsi: rename and improve ata_qc_done()
> 
>  drivers/ata/libata-core.c |   9 +-
>  drivers/ata/libata-sata.c |  14 ++-
>  drivers/ata/libata-scsi.c | 174 +++++++++++++++++++-------------------
>  include/linux/libata.h    |   1 -
>  4 files changed, 98 insertions(+), 100 deletions(-)

Applied to for-7.1.


-- 
Damien Le Moal
Western Digital Research
