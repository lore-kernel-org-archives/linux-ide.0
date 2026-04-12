Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D812DC332;
	Sun, 12 Apr 2026 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776017497; cv=none; b=eKKuW9Ga+i6kDcMwCfY6TVS4wv6LcqoVcs5/qS0Bwk9UMWGHS+/v647jgMOOIJt34fYvZIV3dtcyogsarLIPbVZqBc5S51TXHSCckKNWxTLbA1s1Ir3/gX+nlPFgZjTDXX2XS/UVp/FjBsSkKYjv0xvwb9PICo31WVgCZq/JErw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776017497; c=relaxed/simple;
	bh=Ju/fJaO2pcbpcQjv6kJ9VPfdZqlRPZmb3O6vkUO04AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEBvDLJBKfmvQ62IAJ2aQxuEfaXmH3bJDoOFjRXrqzBvmbgwW2xqJhpVnuHcsJt8p2Y9iy5ngJ9RBmlbKvuPvtBOU+tQiHC8d1CtZurcBL83+qvyMB41dF48ApY924k1Tbaci+ugrWaSfETQ1tddRXry47zkD9z4YU9E0ewQ3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfRM66Io; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfRM66Io"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9882CC19424;
	Sun, 12 Apr 2026 18:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776017497;
	bh=Ju/fJaO2pcbpcQjv6kJ9VPfdZqlRPZmb3O6vkUO04AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MfRM66IoZq1R/p8UUwRKHFdLLMpKFmW0ooy/RqqBFk0KWEx7AHR+AFgo/qoS0f7cM
	 Z+kFnpWp3YQNE7rtVQM+LloPbl1nHMUG9iLrTZFeePy3QF9ah9cO5M6xNdda5bPSUs
	 A85I5FkM3L+Khi14PDSpusmui/rOIqYXLXCbpvOHOWx8uSF6268eTqlisSGgEAsJf1
	 ZrWyEnl5VR5dD51leMRarYa0dkEcQOHdF9+7z+lCZ3Wln3RqdrW5aE2WL3dsmeu1ta
	 vZd1UBuvByniTkvP1kiiTnjfgVTJZGZuaFFR+49+FqbdlIe1kDNOgJ4tUmG/ze2Y7O
	 YU3MQWy99ZCuQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Igor Pylypiv <ipylypiv@google.com>,
	linux-kernel@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Xingui Yang <yangxingui@huawei.com>,
	linux-ide@vger.kernel.org,
	Sergey Shtylyov <sergei.shtylyov@gmail.com>
Subject: Re: [PATCH v=2] ata: libata-scsi: fix requeue of deferred ATA PASS-THROUGH commands
Date: Sun, 12 Apr 2026 20:11:19 +0200
Message-ID: <177601670536.2584527.11395508886922734288.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412153637.475606-1-ipylypiv@google.com>
References: <20260412153637.475606-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=cassel@kernel.org; h=from:subject:message-id; bh=Ju/fJaO2pcbpcQjv6kJ9VPfdZqlRPZmb3O6vkUO04AQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJvP3DbvEZHVD0/MWhJyTWTr4px6dc9q9T39CbPt255b W5SV9nZUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgIk8rWb4X8Q754nEaZaFDw7z CVWt2vIm0Hm66qW9eqaxc5X3nf9fnMXI8MxKh41nZekkqXc2If+Xqn66dNveSZelrFz6+a5VfbP deQE=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

On Sun, 12 Apr 2026 08:36:37 -0700, Igor Pylypiv wrote:
> Commit 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> introduced ata_scsi_requeue_deferred_qc() to handle commands deferred
> during resets or NCQ failures. This deferral logic completed commands
> with DID_SOFT_ERROR to trigger a retry in the SCSI mid-layer.
> 
> However, DID_SOFT_ERROR is subject to scsi_cmd_retry_allowed() checks.
> ATA PASS-THROUGH commands sent via SG_IO ioctl have scmd->allowed set
> to zero. This causes the mid-layer to fail the command immediately
> instead of retrying, even though the command was never actually issued
> to the hardware.
> 
> [...]

Hello Igor,

Considering that Linus is expected for release 7.0 any minute now (it is
already Sunday afternoon), it seems too late to send this as a PR for 7.0.

The fix will have to be backported to v7.0 stable instead.

Therefore, I rebased your patch on libata/for-next
(without any parens - the comment from Sergey).


Applied to libata/linux.git (for-7.1), thanks!

[1/1] ata: libata-scsi: fix requeue of deferred ATA PASS-THROUGH commands
      https://git.kernel.org/libata/linux/c/8ebf408e

Kind regards,
Niklas
