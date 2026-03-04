Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E10371D02
	for <linux-ide@vger.kernel.org>; Wed,  4 Mar 2026 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772623142; cv=none; b=jEYc64PvWROQ20PKlIZMisEWKPpwNYQauJB8kIMt/DkfqmLH4TJVnaUMvn7jSvcjLbZgbJQHq62n3Viw7Du9DAacsTXOgB6u/fLfv0g0WxL8lRjDqxSxldcMJ+vToOInzJW05jPPyO9sFRPNB8UwGTvDWZxvyFqCq6IwAMIDBrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772623142; c=relaxed/simple;
	bh=QffCwVHkV+g7i14+1rEksriLI12Q0f4YlKct/FLPyYQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k+SKJ3PIIc06WklREDA6ntbB0WlQz1FwV5C5LGCYG8XVKI9QHBJeiv6zibIzBhw/RSkT6VbA7WAEYhUaWnvrlI4xr59++tSe7U4ebCQuiMkCOqIzgvZDsIyLMpN1yH8DMwT9D2ak+nK+6OG+QNDikfWTkGzXu3E8/irPYHjNMNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b32T0zAZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b32T0zAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CEAC19423;
	Wed,  4 Mar 2026 11:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772623141;
	bh=QffCwVHkV+g7i14+1rEksriLI12Q0f4YlKct/FLPyYQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=b32T0zAZboU2caPg5AIBdcjyKFo4ni7B7736mto3jYvsvSvKnqIHWCJp8pAtsq39M
	 39UHj5VQ4xRj9YBGPimSHBWhr505rzT0j8JdYL2xg44zLjJKkmXJsi1dxr/9/2sS0L
	 uS/Qe9Leq9l2c6lLDqHWt8k6G5pFQ2v8vluu/UNKHgSeZ0kciOSDhCjkUYCumHByXC
	 IRy3nH9ZWqQvFeR23coBtswrzIMwJKQHHydsQHyyQ0dVos2F0s1BXAFOcS2SaURcmO
	 TZMT5KgOU7ngJ0we1re+fudh8LYHhbgzrWqWXNx3ShDEwV/HMq53OVHqrfNgG/lQ+i
	 qSFuy0vH/K/OA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Hannes Reinecke <hare@suse.de>, Igor Pylypiv <ipylypiv@google.com>, 
 Niklas Cassel <cassel@kernel.org>
Cc: syzbot+bcaf842a1e8ead8dfb89@syzkaller.appspotmail.com, 
 linux-ide@vger.kernel.org
In-Reply-To: <20260303100341.362978-2-cassel@kernel.org>
References: <20260303100341.362978-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: libata: cancel pending work after clearing
 deferred_qc
Message-Id: <177262314009.540104.3954615162291411892.b4-ty@kernel.org>
Date: Wed, 04 Mar 2026 12:19:00 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 03 Mar 2026 11:03:42 +0100, Niklas Cassel wrote:
> Syzbot reported a WARN_ON() in ata_scsi_deferred_qc_work(), caused by
> ap->ops->qc_defer() returning non-zero before issuing the deferred qc.
> 
> ata_scsi_schedule_deferred_qc() is called during each command completion.
> This function will check if there is a deferred QC, and if
> ap->ops->qc_defer() returns zero, meaning that it is possible to queue the
> deferred qc at this time (without being deferred), then it will queue the
> work which will issue the deferred qc.
> 
> [...]

Applied to libata/linux.git (libata-for-7.0-fixes), thanks!

[1/1] ata: libata: cancel pending work after clearing deferred_qc
      https://git.kernel.org/libata/linux/c/aac9b27f

Kind regards,
Niklas

