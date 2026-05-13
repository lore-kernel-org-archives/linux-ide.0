Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFD23D5258;
	Wed, 13 May 2026 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658186; cv=none; b=O/l0xFP4iU2Y4UAQzSzz1O4oiGeZVri4fMM2rSLgDouSfSErlMBV0X+fZ95WzDjTbF9mriHLg/hiRq0b5VeH8f+iqewjx0RoEpyHG4rGw8v3/vaMMrfwFbSQgHD+C5r/8g3fwSN7lgqp31DcUFk6MI6ctR4ClFsOJzixroUJPVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658186; c=relaxed/simple;
	bh=nyYSr1NSQmHg/Qas0D9ocjX288HuS7GJLW22dd7ygAA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e6LdFoQTJD7zMx/CmTbjZ2gqNNOe3LapPETA6ubVRvSu0XmpS+ac3G1GsqI5MqGyiM4LJh1lh+73LHIgWSt8ePmkXwTmMP94jGuYet8TIyNAeO+obgH9j/d0N9fQ/zPX7BuTT/YJSDtWHBAr0nmm7YeZ5hW0KUQMjqroyM/4oO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBbQhG7A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBbQhG7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51142C2BCB7;
	Wed, 13 May 2026 07:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778658186;
	bh=nyYSr1NSQmHg/Qas0D9ocjX288HuS7GJLW22dd7ygAA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vBbQhG7ADXvZZOhDMeat690cbnaFihQU3JGoXSCnbVN/TiVbA4t+fOtPyAVx2TFNX
	 7F3MZU3eRhJ9+EjWxoseLGxYrsJHQ08q40vryFaqwCTKsNt2K4lNFVThSSL+nylx22
	 MO0UdFuOr42/Me8sEaWLip5abLEJvZPV+szpUZb6J4KQiF+RaYbK3Br5UnlRdtMZ/N
	 g7Ptkbb7uWK6CVZnmeh1b+mBI2qkCapZkiz5So4nNDyEyAhX1KNMMYKFvSG4MAGWoM
	 UxXA43clIycsb2PFG0KdU+5kn79i9PipSDQxjhsc2mw58mkOsNFDOeLor7szNE28Qd
	 /eD08LgUenIOQ==
From: Niklas Cassel <cassel@kernel.org>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
 Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20260430092947.128647-1-marco.crivellari@suse.com>
References: <20260430092947.128647-1-marco.crivellari@suse.com>
Subject: Re: [RFC PATCH] ata: libata-scsi: Move long delayed work on
 system_dfl_long_wq
Message-Id: <177865818406.650802.13202534059090445731.b4-ty@b4>
Date: Wed, 13 May 2026 09:43:04 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 30 Apr 2026 11:29:47 +0200, Marco Crivellari wrote:
> Currently the code enqueue work items using {queue|mod}_delayed_work(),
> using system_long_wq. This workqueue should be used when long works are
> expected, but it is a per-cpu workqueue.
> 
> This is important because queue_delayed_work() queue the work using:
> 
>    queue_delayed_work_on(WORK_CPU_UNBOUND, ...);
> 
> [...]

Applied to libata/linux.git (for-7.2), thanks!

[1/1] ata: libata-scsi: Move long delayed work on system_dfl_long_wq
      https://git.kernel.org/libata/linux/c/79b6e4dd

Kind regards,
Niklas

