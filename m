Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECD725393B;
	Thu, 14 May 2026 06:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778740262; cv=none; b=fPc48XMSMTF85xxtyeLqAi/PIIRDcTvYUO/zXbzazpAvyMQTYNahAX+YK/vfjqD3nozieeAcadaRLrGso/K5x4nZyUWQwFwlHTcwCK8YurgHXFJp2ljrt7LjF2GsmdoY1j26Prhv20Q//EBOQLtfXvBXnHO9Qt8qiTOc4ZrbysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778740262; c=relaxed/simple;
	bh=twV3UxLLW1BtVMIuB0bdbN0P4LiedechzBLKJx7bhKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQh1TgPKiACHLnEAAhlr4XFyKx0jP5+tTiVY3sVq+V1fXmHPo9YKECRwzV1bjbECD1qyBcQYSsMbFic8VvvWN0ZJ8Unxp6+JRhal2MlL63xDy+XqgjfcRc8U9sIXQ4zNs8Usc9zSR4X1WtTgtGO0DP9Kl0/sQJ6m8oi8OSKbzvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMJL+vcR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMJL+vcR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB80C2BCB7;
	Thu, 14 May 2026 06:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778740262;
	bh=twV3UxLLW1BtVMIuB0bdbN0P4LiedechzBLKJx7bhKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kMJL+vcRu61z3T+DBfe1GI7s9ihgZtAkZxeocoI1UnI71+YEEgiHwXLLulZLMp7KO
	 q1LvxeLnjv+FuBmJeJ3L4irGb9omVx7iAdsJPCK3G3fbtPGSlptQ91iqTC5L1dTP4Z
	 uMoBP7wDP+SPemCrGekIGrMwFFEP1DjemYeFJHpymEAU1UQpX06s6O4Sfrx1YTezxB
	 e+Ak02lci1vbt7bkyFgopR1jyo6cFLALy0bNMb6e73WspMUGC/g0yaFAkEFY6D8NCU
	 AzdRelPLS6rqDcn5stxM0XXJiK/3OVd1+hFbKJaB6YK3oeZQZaKyEIIusFKkmGdPh0
	 kG/YRRN0zi9kg==
Date: Thu, 14 May 2026 08:30:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH v4 3/4] ata: libata-scsi: do not use the deferred QC
 feature on PMPs with CBS
Message-ID: <agVsIWEOqJic87dQ@fedora>
References: <20260513151359.1075403-9-cassel@kernel.org>
 <20260514061953.7DEA2C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514061953.7DEA2C2BCB7@smtp.kernel.org>

On Thu, May 14, 2026 at 06:19:52AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The `ATA_DEFER_LINK_EXCL` case incorrectly uses `goto defer_qc;
> ` instead of `goto free_qc;`, causing the command to still be stored in the
> incompatible deferred workqueue.

Thank you Sashiko,

you are absolutely correct.

ATA_DEFER_LINK_PMP_CBS did correctly use "goto free_qc" in V3:
https://lore.kernel.org/linux-ide/20260508195051.188207-5-cassel@kernel.org/

I made a mistake when refactoring it and renaming it to ATA_DEFER_LINK_EXCL
in V4.

Will need to send out a V5.


Kind regards,
Niklas
