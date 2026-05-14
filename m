Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8338F1ACEDF
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778742602; cv=none; b=sFMe4rDDmBbj+jEAjybk4/m3B9M3ldzVSFws278aI00sDkKbENpBWDnBQ2DuZsXaWfLMXL2F0pt3EvB8yEvXNmhC/W54bsEZqCBvn64zeqjx7NGbF9W+Mpfpq0saMUuIsqHE9OkdHrUuki29urRMhwuWv6pNWybSrp3wqse2J9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778742602; c=relaxed/simple;
	bh=vYufZySQ/LOTbo3lxYSxPyYKBUEDvULXnBFjDfkT8oU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R9fbbQkGoXWUaoagcTcHBuftjNZSbOCo0/wtBsLH836X/RBK8s8u7On0gDFgUbIHq2cX4TfV7F/64Hm8dLhlvtzXt4o0fVJw38HuCnHe83oNECj1z9xonoz23N+gtkVIoPJThuq/lqrZPwKrt6T5BdWf8if55RF4nzWDX+lEfUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwOwl5KZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwOwl5KZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA12C2BCB7;
	Thu, 14 May 2026 07:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778742602;
	bh=vYufZySQ/LOTbo3lxYSxPyYKBUEDvULXnBFjDfkT8oU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bwOwl5KZOntUoDX8K69ggNAPWExMYTn21pXCpDliRKtre7DJz9BTAw2Jovvefwtod
	 fZ2DM9XCRMzJ8RcTu7QOqe9xXj28seNEg4ELoGlxp51nZrxzCO2+xn3mVVg8dqLYkb
	 GoOi1nCzhP7tRb8Lpg6+TO7e+FvugI/D2QAHkYWxo+R/PcCUyPtfHDBzjoScD+dZMX
	 0AAaGaM1omwJKsT/tIWYb02fLgz/oT55lQEA9VcsAQ7ty8ZHvDnaxSRCjybT8yiDO/
	 zR22MJDpCRm3NrlnaGwUPXzp0/hVILTk0ixTQYZxhJCKlcKuGDYIra7em39zGwRC12
	 dpm3N698Amnsw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, 
 Marco Crivellari <marco.crivellari@suse.com>, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, linux-ide@vger.kernel.org
In-Reply-To: <20260513081001.714630-2-cassel@kernel.org>
References: <20260513081001.714630-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: libata-eh: queue hotplug work on the
 system_dfl_long_wq workqueue
Message-Id: <177874260053.1169940.5505533088481611885.b4-ty@b4>
Date: Thu, 14 May 2026 09:10:00 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Wed, 13 May 2026 10:10:01 +0200, Niklas Cassel wrote:
> ata_scsi_port_error_handler() uses schedule_delayed_work() to queue
> the ap->hotplug_task work.
> 
> schedule_delayed_work() always uses the system_percpu_wq per-cpu
> workqueue.
> 
> ata_scsi_scan_host() queues the ap->hotplug_task work on the unbound
> system_dfl_long_wq workqueue.
> 
> [...]

Applied to libata/linux.git (for-next), thanks!

[1/1] ata: libata-eh: queue hotplug work on the system_dfl_long_wq workqueue
      https://git.kernel.org/libata/linux/c/9e5137b9

Kind regards,
Niklas

