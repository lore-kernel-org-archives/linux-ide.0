Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC21E19D07E;
	Fri,  7 Nov 2025 06:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762497093; cv=none; b=hGHvcvzAuavqr2p8EHYNDIvrcEEzOPoyXyQHNWESDRKAq0WV4GDKD2OxsTfa8gwgkTvZtWiQCudoRXXRPQHIx43NRE9uu/Tp6BmVhNwCnRVqx7INMK1CY88hBRe2/VlbjbA+MwF/d17j5NCBYIwRaDZfTNZdQmJ8wyOy++yXAIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762497093; c=relaxed/simple;
	bh=tWqJwrnLRVcq+6RB8rh8ggdt2e72tZUFXvUfF2fTSp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMofvaC9FrOJegozd3TLz88oqsr786mRFHJDWXj8TEg64xQLhXpzoY0EZLxYxoyJCbEectG8UbE/g9gtdKFq3uwq5ctMZpOlPwkGsQlQeEKslB38v4Y7o9qwWv1F1QjwL3I7sHDEAG91QppCrWx40+DzY+TiRfF/FV7TdQQvqFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+jS6qYV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+jS6qYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFC2C116B1;
	Fri,  7 Nov 2025 06:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762497093;
	bh=tWqJwrnLRVcq+6RB8rh8ggdt2e72tZUFXvUfF2fTSp0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z+jS6qYVAT+aDnQYeO9tmL6RJMLaAbNDotWLT5vRDDz5cWQdjCobBAyyUVzZ2LZtd
	 AuQBUd6O7yEt5NxYEzECpnupNx8JzFs9lqIp8O5cEJ8wG84uJdmxPEepjpOU3U9bOU
	 mAwNTUurrEqe8++ywAasVsEJpBb/9uG1Zbet0oaPOpjeLHByx9ION+ce3EZ0rUwsLp
	 nRpH+ctKAqnIWc5ZFPz94EiqfQ1fwEomNaYFY51pRfKqRTQjfvGk3iYKTO2u9XgdFu
	 1Hf6nMVnD6MSsmsxrJVo6l09GlYxmI5AlKHs1XKYvsmWH538g3T7EM3ZEztL/UfSoU
	 svssNVoheB9Xg==
Message-ID: <87fab1cc-6478-482c-af9d-d90229976a64@kernel.org>
Date: Fri, 7 Nov 2025 15:31:30 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-sff: add WQ_PERCPU to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Niklas Cassel <cassel@kernel.org>
References: <20251106160813.314932-1-marco.crivellari@suse.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251106160813.314932-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/7/25 01:08, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
> 
> alloc_workqueue() treats all queues as per-CPU by default, while unbound
> workqueues must opt-in via WQ_UNBOUND.
> 
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they’re needed and
> reducing noise when CPUs are isolated.
> 
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
> 
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> This change adds a new WQ_PERCPU flag to explicitly request
> alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.
> 
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
> must now use WQ_PERCPU.
> 
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
