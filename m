Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3954F136649;
	Wed,  3 Jul 2024 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998178; cv=none; b=S1vVfqXJFAaxU+2fzN6et5m+3swudZETCzPjp+xfzYMdr3xA0YIfPMq/1K2KyZT7k8dRmHGICYcmuSvXQXy7GOVBw1Exeib84lcPiLwViAVHVaSHosfXcwkYqs6FFfiLqHrana0q6d5YjNOd2CI50WQKviq1gHd3HUZV9+pjxr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998178; c=relaxed/simple;
	bh=Rsk2YNt6qAdwIuk7dXHXs96DGt86NUkOvdgZvAVkZic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=opdeZ9GV4NcEEhngSEy6m1SLybOSlCg7hefq3jnoMVBvLM83uww3OI0m7/6S3OjtbeYBaTKjvPXURh4KC1spdHEc2gJApF6bmK+4Etcu8H6ltgDZVFi2f+h7yd5qlpuMDuuM7YlQ5k9AiJYNUa380Zlyb5a3GBJ6vqUE5jP6pIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/ZDpT0Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/ZDpT0Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C56BC2BD10;
	Wed,  3 Jul 2024 09:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719998177;
	bh=Rsk2YNt6qAdwIuk7dXHXs96DGt86NUkOvdgZvAVkZic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=u/ZDpT0QH7F5UUoXMiVNRRSe/OcGGCeA7bvh+h6cMfCtiYKpjxhpqOrW94T37j/Di
	 Bv7Ilqj2vL+sUxXcM9oWKexhmP0uvHu3inyTrtHHsSfqCslmXsmnbGUIX+Fd9/FuEK
	 vGxeglVxHhrO16h/B+n5v9Osm/Ir9wPzzn9ONROwB78qfoTMKzHsXpe61uFli9HiWU
	 awkm7R/SvmeoIbzbxzslSxTPrHIpu6z/OXmI+1rGdCuf49Z87qwebIQJY/8O9teZ3v
	 Mlk6Sn6WNoZfHz93+WOILuq4lQ60LpV+jhzZnw3K0Q/SrmYP0iceMmApfQVbk2IlLc
	 hLQArT1uBg3ng==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Igor Pylypiv <ipylypiv@google.com>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, 
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240702024735.1152293-1-ipylypiv@google.com>
References: <20240702024735.1152293-1-ipylypiv@google.com>
Subject: Re: [PATCH v5 0/7] ATA PASS-THROUGH sense data fixes
Message-Id: <171999817621.664489.10486098477695023316.b4-ty@kernel.org>
Date: Wed, 03 Jul 2024 11:16:16 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 02 Jul 2024 02:47:28 +0000, Igor Pylypiv wrote:
> This patch series is fixing a few ATA PASS-THROUGH issues:
> 1. Not reporting "ATA Status Return sense data descriptor" / "Fixed format
>    sense data" when ATA_QCFLAG_SENSE_VALID is set.
> 2. Generating "fake" sk/asc/ascq based on ATA status/error registers when
>    ATA_QCFLAG_SENSE_VALID is set and CK_COND=1.
> 3. Fixed format sense data was using incorrect field offsets for ATA
>    PASS-THROUGH commands.
> 4. Using qc->result_tf in ATA sense data generation functions without
>    checking if qc->result_tf contains a valid data.
> 
> [...]

Applied to libata/linux.git (for-6.11), thanks!

[1/7] ata: libata-scsi: Fix offsets for the fixed format sense data
      https://git.kernel.org/libata/linux/c/38dab832
[2/7] ata: libata-scsi: Do not overwrite valid sense data when CK_COND=1
      https://git.kernel.org/libata/linux/c/97981926
[3/7] ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error
      https://git.kernel.org/libata/linux/c/28ab9769
[4/7] ata: libata-scsi: Remove redundant sense_buffer memsets
      https://git.kernel.org/libata/linux/c/3f6d903b
[5/7] ata: libata-scsi: Do not pass ATA device id to ata_to_sense_error()
      https://git.kernel.org/libata/linux/c/ea3b26a9
[6/7] ata: libata-core: Set ATA_QCFLAG_RTF_FILLED in fill_result_tf()
      https://git.kernel.org/libata/linux/c/18676c6a
[7/7] ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before using result_tf
      https://git.kernel.org/libata/linux/c/816be86c

Kind regards,
Niklas

