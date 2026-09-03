Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B12E4B26F5
	for <linux-ide@vger.kernel.org>; Thu,  3 Sep 2026 14:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444872; cv=none; b=l8wCRhDIPzPiRHWo1iPWFOJEX3NuFqbfzAyY2M4mhZh0vqT1qx3TNgcoHaOovMFXWDXA76L/Bt3XUr2drCOEz4Wr01ajzGaS3xOCqrfNvnPiZlu86ik1vY4lpk4UBrQIt6Nr25pTrlFI/ai/wBvwy2EGMyNGICbKy3uzDOC+vZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444872; c=relaxed/simple;
	bh=bKgAP+ciRNoqE8KGNQGrSSlSO8o+yvE0LWtmFSOL3c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkO4a9cMWnA6CnOmY8hBH1SxRAFzPKyTL6uoBoOCP3x49LELXG+I78ogg0a5LiDyUEDINfssnAxw9qeyCivH5rZP22CE7BWmHmizFpHGYfv4fAmiI3JQNjAn+Nyu9SGSsQrK58HXbzwwpBxEmh5XDO0oa2xLTFv8pMasTVAcshA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oogexUYV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oogexUYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B02C1F00AC4;
	Thu,  3 Sep 2026 14:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788444867;
	bh=FX0nnMkRZx5U+wDqJAuG9eJdnIVMYFam888tmm95J+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oogexUYV/J+e/Cah17fiYvLc2OB5nLvXtWmu2hCSlQOpIniQ80blOvGdUKrQy7vS+
	 JEnRMkM41T6OCHqj/sZtQXNTrwI6mm+MAFkR/0PIu8tw9elo3KXrnfDwufloP6Awrk
	 KyoZoyzqVd8PgP/KapJTIrKNmagNIIHKqCQ2u3AfqkaStTcJArZXNF3uqJBil+jcFn
	 m9htvj0WQGhVsJT0slqiZng5ABMOqRqfG25cmkOGE4FAXcLyql5riUR8hJvAe6kkKe
	 XlxFxB5oQIFYTm54fiBQIexWyfObeDCwiQ5VHbanpqvZwAQPk8ejHaVdn6eMZiPoIH
	 YpmNDgrdZ0BxA==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH] ata: libata-scsi: do not raise UA for storage element depopulation and restoration
Date: Thu,  3 Sep 2026 16:14:15 +0200
Message-ID: <178844476378.884761.15363491611365136485.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902020828.1436048-1-dlemoal@kernel.org>
References: <20260902020828.1436048-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=872; i=cassel@kernel.org; h=from:subject:message-id; bh=bKgAP+ciRNoqE8KGNQGrSSlSO8o+yvE0LWtmFSOL3c0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJmNuw4KDtvj+5nyQgr35iPt8uZt7tmTWr0F5wnXvZtW bS66TexjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEykUZPhf+mT2OLEmZIRESWH Lx+6vqxH/49P76MY5arCQ8J53z1S2hgZTiY1OK16rcwhkuvRlnWAd5Lxqg961/nKooP+vvgxMbu JEwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 11:08:28 +0900, Damien Le Moal wrote:
> Currently, the translation of the trnalated ATA commands REMOVE ELEMENT
> AND TRUNCATE and RESTORE ELEMENTS AND REBUILD are completed using the
> function ata_scsi_depop_ua_cap_changed_complete(). This completion
> function raises a UNIT ATTENTION with the additional sense code CAPACITY
> DATA CHANGED. But doing so, the scsi layer seeing the UNIT ATTENTION sense
> key ends up failing the command, even if the command result is in fact OK.
> 
> [...]

I fixed up the commit message as suggested in the thread and also
s/CAPACITY DATA CHANGED/CAPACITY DATA HAS CHANGED/


Applied to libata/linux.git (for-7.3-fixes), thanks!

[1/1] ata: libata-scsi: do not raise UA for storage element depopulation and restoration
      https://git.kernel.org/libata/linux/c/6d81700a

Kind regards,
Niklas
