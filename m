Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9893A1682;
	Mon, 11 May 2026 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503692; cv=none; b=NnfMgeMXiXx8psAYb6IRlwW9GHsaZEumNd3BemEwxOirpwBwKJoHHJZeTejV5zJCUTjWblcQeT5O+E3TYr+XfNrIji8fpKJbegH07S6I8qsjf6B4HQadOfiIDWRl6KYi3K40kbxWGH2I/XH3BSb49TqOY+7j0cvg13WG6Bbso8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503692; c=relaxed/simple;
	bh=2YKqzqRUm9tGipXIKZymSX/iJogufXuFSN5zxK9LSzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCS+qivGhISCTzk/0dzRcJt2qvWP5bTolA9vDDXATTy8XGqgn9ItA7ZvKH67vyNIr+y/zeu9vFkxIVKd9robWms10EDypafCUvI3ZDSPHRpn0k5LozJak3/0VZMQiQzUbdv2UCMs6fKrF2TWlZR+Kp9cmWJhf5cm/MLBFemvhQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqz1kp8h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqz1kp8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D92C2BCB0;
	Mon, 11 May 2026 12:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778503692;
	bh=2YKqzqRUm9tGipXIKZymSX/iJogufXuFSN5zxK9LSzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iqz1kp8hYRSuQYsUC5vArAeY1qDZGnx8oZVPC2jWsKI3IXJ03a9b06UVndDJle+W1
	 Sxkip8E6xYwGW7GzN4D4k3zJmgA2mt2pTFtkkr77eYrlSXfdhIbeT5BIHawEt/qEb6
	 V+ElCndf5/moypqdhT7gAP4uQoBpIZ3Lffl6W6Ajg2Hl5N+4GP6bCL2nuPatfiTINj
	 qnVLYX7kIM/GTFmjERK76gSXvJMhi+dN6IIkU28qQ5lNS+xVbX4Sww55bvh9qtZpCb
	 AY/3+8YY9/Zms7+15LMRbSRRAFdBoTmW0c++8PyxqW+xIvmHx0fbVGuE1cmkQySZnK
	 PaE12PPzL2+Rw==
Date: Mon, 11 May 2026 14:48:07 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [RFC PATCH] ata: libata-scsi: Move long delayed work on
 system_dfl_long_wq
Message-ID: <agHQBzVdIIPSTBah@ryzen>
References: <20260430092947.128647-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430092947.128647-1-marco.crivellari@suse.com>

On Thu, Apr 30, 2026 at 11:29:47AM +0200, Marco Crivellari wrote:
> Currently the code enqueue work items using {queue|mod}_delayed_work(),
> using system_long_wq. This workqueue should be used when long works are
> expected, but it is a per-cpu workqueue.
> 
> This is important because queue_delayed_work() queue the work using:
> 
>    queue_delayed_work_on(WORK_CPU_UNBOUND, ...);
> 
> Note that WORK_CPU_UNBOUND = NR_CPUS.
> 
> This would end up calling __queue_delayed_work() that does:
> 
>     if (housekeeping_enabled(HK_TYPE_TIMER)) {
>     //      [....]
>     } else {
>             if (likely(cpu == WORK_CPU_UNBOUND))
>                     add_timer_global(timer);
>             else
>                     add_timer_on(timer, cpu);
>     }
> 
> So when cpu == WORK_CPU_UNBOUND the timer is global and is
> not using a specific CPU. Later, when __queue_work() is called:
> 
>     if (req_cpu == WORK_CPU_UNBOUND) {
>             if (wq->flags & WQ_UNBOUND)
>                     cpu = wq_select_unbound_cpu(raw_smp_processor_id());
>             else
>                     cpu = raw_smp_processor_id();
>     }
> 
> Because the wq is not unbound, it takes the CPU where the timer
> fired and enqueue the work on that CPU.
> The consequence of all of this is that the work can run anywhere,
> depending on where the timer fired.
> 
> Recently, a new unbound workqueue specific for long running work has
> been added:
> 
>     c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")
> 
> So change system_long_wq with system_dfl_long_wq so that the work may
> benefit from scheduler task placement.
> 
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/ata/libata-scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index f44612e269a4..6733f2b14521 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -4753,7 +4753,7 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
>  			     "WARNING: synchronous SCSI scan failed without making any progress, switching to async\n");
>  	}
>  
> -	queue_delayed_work(system_long_wq, &ap->hotplug_task,
> +	queue_delayed_work(system_dfl_long_wq, &ap->hotplug_task,
>  			   round_jiffies_relative(HZ));
>  }
>  
> -- 
> 2.53.0
> 

Looks good to me.

Any particular reason that you sent this as an RFC?

I can see similar patches queued up in linux-next already.

Do you want us to pick this one up?


Kind regards,
Niklas
