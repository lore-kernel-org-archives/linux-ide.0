Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CDC18A94C
	for <linux-ide@vger.kernel.org>; Fri, 25 Oct 2024 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844106; cv=none; b=nsw2Rvy0NNe6dDIa0XbinZVhvlHS6o+TUC8YHuoX0Uofgg7GcbDln7ErT9PZcl7hu1hFxl8lQxb2imZxLiKPRyq0Loq1I4hnnOozzaMRZEVB831xIF3Xaow3zZc5BICk8rJs+NtcPxGgecE//FnAgvvsu/svBwmorThgH6x+bSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844106; c=relaxed/simple;
	bh=WolqRln6HOgOQh+1kafBCgWkLPta6LJD2Il4PnCXzJM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aFXRB3qi09zxpTKR8f3FRS4Jvc+DiO1cuf/mCrNUXKZ9cw2XNNpIXgwdesFi6GZNKnlBK6h8kz21CxHDdXtjxuhTQcERVy2MjZON3+IAYV9yOkc9lxjkgtTnKaZ4VLbpUi+9wfW3twtP52vJTxyJKsp8oqN6nQmwrm24KhZOdIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/1zNg+Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/1zNg+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D776C4CEC3;
	Fri, 25 Oct 2024 08:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729844106;
	bh=WolqRln6HOgOQh+1kafBCgWkLPta6LJD2Il4PnCXzJM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=q/1zNg+ZhwOGSQd1EJR6OkiB8klCp4ZKilWqHI8PVkRZV/mAySpegwtbOSGyVXp1j
	 wSNzDOT31LbavZFMVkcu6LWHiB5qssUcg5G83sC7V3PwKxFZQYtTTN+V7YVvRIR/Jh
	 zDDg/pdcm8ZxyY3Qb6g1bWxuZFz174f2MvWoyjCNTkPWg138VX/kg657EHmt1pfc1a
	 p8tPcv1eGuxOHERpdKc6JG/k/T8C1R7byxFbszgM/a4i/9oMduvjWml5AIAnpkXcqQ
	 Y+O+QhDaAag+r5Zorbpg8MmTM1GgbFudBQb0TZtKbsF8Kp0vtsI+VKJDnW+tVRFKxR
	 PixXBmXqYBaaw==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20241022024537.251905-1-dlemoal@kernel.org>
References: <20241022024537.251905-1-dlemoal@kernel.org>
Subject: Re: [PATCH 0/6] Cleanup and improve libata-scsi command emulation
Message-Id: <172984410533.3954535.14529122270469558816.b4-ty@kernel.org>
Date: Fri, 25 Oct 2024 10:15:05 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 22 Oct 2024 11:45:31 +0900, Damien Le Moal wrote:
> The first 5 patches of this series refactor and cleanup the libata-scsi
> code handling command emulation. There are no functional changes
> introduced by these patches.
> 
> The last patch of the series (patch 6) improves the command emulation
> by accurately handling the scsi command residual and transferring back
> to the requester only the relevant data of a command reply.
> 
> [...]

Applied to libata/linux.git (for-6.13), thanks!

[1/6] ata: libata-scsi: Refactor ata_scsi_simulate()
      https://git.kernel.org/libata/linux/c/b055e3be
[2/6] ata: libata-scsi: Refactor ata_scsiop_read_cap()
      https://git.kernel.org/libata/linux/c/44bdde15
[3/6] ata: libata-scsi: Refactor ata_scsiop_maint_in()
      https://git.kernel.org/libata/linux/c/4ab7bb97
[4/6] ata: libata-scsi: Document all VPD page inquiry actors
      https://git.kernel.org/libata/linux/c/47000e84
[5/6] ata: libata-scsi: Remove struct ata_scsi_args
      https://git.kernel.org/libata/linux/c/2365278e
[6/6] ata: libata-scsi: Return residual for emulated SCSI commands
      https://git.kernel.org/libata/linux/c/5251ae22

Kind regards,
Niklas

