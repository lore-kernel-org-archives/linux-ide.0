Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EF83EFD25
	for <linux-ide@vger.kernel.org>; Mon, 18 May 2026 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779100626; cv=none; b=VE361wGK3BP3uudMT2Xss6NgbQWOBnKzoyWcipWAmf1ekrYNZxI6+VZ+B+kr9QUyGRlElYPklkovp9k2LIhBeZAMqzP0arBKOxixFsU0KQc1xnVY78EEaon8Z+sw6UnPIjS2ZzZ0/hxEqWCKQUY2MzYteSTTxNb2kgqNGhA5csc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779100626; c=relaxed/simple;
	bh=kz8YfP5J+en9b+BmFFVVrz/4T0u+fCW6vCD96hE5b/I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qe9pL3gf0GuYCVpdDuAg19GF1x4FPNLDCyMCG5VyZr2+9IOuM+/omYvhVsP5zQO7bO2BZgA5jskTLpitSGfYDmvm2ulI99tokzi6crILDfwh68aptDeztVDb4hbd29WX3PA+iEMN6ZRInDdrXdFNfsQPZtioQjblJK6d3TWaJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhYqE7An; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhYqE7An"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F93CC2BCC6;
	Mon, 18 May 2026 10:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779100625;
	bh=kz8YfP5J+en9b+BmFFVVrz/4T0u+fCW6vCD96hE5b/I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dhYqE7AnGLwAFBmkumKvaKgBOaT/wJmWFenVmh3vR36knz+TwW+tCmOWyrQ+BENP8
	 KhsxrlHj1l7cjWAl+fexw2bz99tzpM+SC5E5SbuBdNKcn6Id2xIBNaL0EFAJKblijW
	 NdcT/cdL2kdgfYexV5UriW7SDdRIhpFaZ6/xukLZu6uwYmv/HL37qT0A8MYj8hw3ff
	 t2JlH07uwX/z+1N7hiU+Alg6i9tgqO9w5O62DO0Z0RngPfNOL3UcqOCmteTrIR6SUT
	 cnz1Ywjt1s1dVmrGVkU5zvV7TXuGwaVCb5KQCR9D56qhi46CdoDrprDqbYBbauxtAP
	 s43fgYaAAz1pA==
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>, Damien Le Moal <dlemoal@kernel.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 John Garry <john.g.garry@oracle.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
In-Reply-To: <20260514073858.1175072-6-cassel@kernel.org>
References: <20260514073858.1175072-6-cassel@kernel.org>
Subject: Re: [PATCH v5 0/4] ata: fix deferred QC handling for port
 multipliers
Message-Id: <177910062425.1864447.6530208133656638274.b4-ty@b4>
Date: Mon, 18 May 2026 12:37:04 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 14 May 2026 09:38:58 +0200, Niklas Cassel wrote:
> Tommy Kelly reported a regression with PMP that use CBS:
> https://lore.kernel.org/linux-ide/ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly/
> 
> It turns out that the ap->excl_link logic used for PMP that use CBS is
> incompatible with the deferred qc issuing via a workqueue.
> This is fixed in patch 3/4.
> 
> [...]

Applied to libata/linux.git (for-7.1-fixes), thanks!

[1/4] ata: libata-scsi: improve readability of ata_scsi_qc_issue()
      https://git.kernel.org/libata/linux/c/360190bd
[2/4] ata: libata-scsi: do not use the deferred QC feature for ATA_DEFER_PORT
      https://git.kernel.org/libata/linux/c/ce454880
[3/4] ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
      https://git.kernel.org/libata/linux/c/f233124f
[4/4] ata: libata-scsi: do not needlessly defer commands when using PMP with FBS
      https://git.kernel.org/libata/linux/c/759e8756

Kind regards,
Niklas

