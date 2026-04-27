Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D3035CB7F
	for <linux-ide@vger.kernel.org>; Mon, 27 Apr 2026 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277620; cv=none; b=kZBa5chbCo8PN/O2O8mIlz0ireiFOT3MThJxsc1hvJKZ8TTNfkI4bQwsyfFbmMZm7AGbHesrcClQldinG1MC99HlOdI3RKgmgr+MCbqlPq8YZZqtmtDmg2MruQC2nf6YfrdjQ1QeAYM8XI7noojxGsQ31fFgNi1a2OrbgBK2+N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277620; c=relaxed/simple;
	bh=V3whfHzDuysVxrDsVwHIlPRCEULDBJtpDQ38OQBf4us=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ldB2WF6NL/yDCN47Ku6ExzlytMpBtMW6O1lnACspZ3wkEXSkkJ2yRqoOxoiigi91fUbnWPX4JEM73tFknAwzXIBJbIPf72dCmGuSTOw2yumX6ZCJhlYO/JphvYq1KMPsljkMBnfnkctRWH7M3ttqmBifRZU28sPnQeok4A8OxYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFab7RMc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFab7RMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B34C2BCB4;
	Mon, 27 Apr 2026 08:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777277619;
	bh=V3whfHzDuysVxrDsVwHIlPRCEULDBJtpDQ38OQBf4us=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AFab7RMc6dmfJBrsG80i51oqe01TxYV6AZgiyHR/Y/O6tH7AajFqDOKMedp3Rn0Fc
	 qinMyQgZbbqrGYMvLAiGydpm0sRmO+QOBztdTWLS+Ni84kuT9UrhnzoUFa7AA7hAE6
	 Be0y/eW0KirxrD0SnU1h/EIVZC7goIW3eVmzpB2uWeM949gxKa7zlnmVZ6vWnBKpPp
	 onxxAh1XTtCy24MRx/w0tWO7+eebCc8k9HO6SW+FxCtummQLYMy23oGCkvEgaBjxFA
	 l/UOZ+bW//Afeq0ZDQoR8az89KZxoZB85K0qpUNn/+aQ4/bj4P4lstVpJM3qFiZNBS
	 GGk3BWRhxlnNg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
In-Reply-To: <20260423164329.1541337-2-cassel@kernel.org>
References: <20260423164329.1541337-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: libahci: use ahci_nr_ports() helper
Message-Id: <177727761862.2004851.14870180918570569037.b4-ty@b4>
Date: Mon, 27 Apr 2026 10:13:38 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 23 Apr 2026 18:43:30 +0200, Niklas Cassel wrote:
> Use ahci_nr_ports() helper instead of open coding the same.
> 
> No functional change.

Applied to libata/linux.git (for-7.2), thanks!

[1/1] ata: libahci: use ahci_nr_ports() helper
      https://git.kernel.org/libata/linux/c/d02c6e08

Kind regards,
Niklas

