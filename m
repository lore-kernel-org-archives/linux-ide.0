Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5237E4D9909;
	Tue, 12 May 2026 12:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589091; cv=none; b=qLcC/Fg3QVVP95u6JT952Imkxjr3L1mYu9/SpSfOpAEJfFkvE/VW6ckMKR/tf42Uhl73AOonZSxVfBOtCA7/ZZlWaw1Hey5pCDh31PTxYzbewk3z0AArfD2cZbLhKkM82bBSvpJpNbPd86wbm1ZZUVvA4/mIgmVf1aBqa7rgMQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589091; c=relaxed/simple;
	bh=W98F7KTZKUZ6W2N2kn1s2TDbEMTKnaWQLHSmKOx+qg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQYNJazoaaUv9gk4bvByTqRjYYROGZMv3QSNjlnSf+XWn3IIQvYo306WGV1EyQWwbjky8kV0Iq1U1CNZ5k7EGRANTu+1FR1l3T0w7pKg8VAGE9W1HmKrrCTjmhJYAfnwPn2NAiA3AW9fjFBGn0upLCvnwQCDV+0nNaS0owdPBlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AErKxdEn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AErKxdEn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1DDC2BCFA;
	Tue, 12 May 2026 12:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778589089;
	bh=W98F7KTZKUZ6W2N2kn1s2TDbEMTKnaWQLHSmKOx+qg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AErKxdEnWaHlCiDPFAjnW80rqMVTfqwRuF0ynrrlKjZklu9P5OYJz8RDF9tF8EXcW
	 oeAIXVPIa6N0SVWWKoZZDFYa0hOMW+1DccVNew5IEcafbFyynHT6ocO5legaaSxb/0
	 LjIQm3zkifUqf2A1jJDi4liUhXZrf0Qvbk7yK7XW+zKI5wrZqkmNkTsAX1tpjhaRHL
	 muY3OdYHGGvG8F6KsAcAnscgcJfYF6uufI2Cv34UAgzcOgUmyitu8MdXRu4pTuhKYa
	 ScPW1dgpyz41I7XntEcsPaz0OPfig0goXZCctsNWO6K36DE9OxK/Ym/gubsZNsuIsz
	 PE3FUICzV4A3w==
Date: Tue, 12 May 2026 14:31:26 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Marco Crivellari <marco.crivellari@suse.com>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [RFC PATCH] ata: libata-scsi: Move long delayed work on
 system_dfl_long_wq
Message-ID: <agMdnnbD6Oep-iKR@localhost.localdomain>
References: <20260430092947.128647-1-marco.crivellari@suse.com>
 <agHQBzVdIIPSTBah@ryzen>
 <CAAofZF7NhFUHKhp-HdvSx2doFRc4XFERCL22V+BZXrQVjmxugw@mail.gmail.com>
 <agIGSYxbK3FX2mXK@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agIGSYxbK3FX2mXK@ryzen>

Le Mon, May 11, 2026 at 06:39:37PM +0200, Niklas Cassel a écrit :
> On Mon, May 11, 2026 at 02:54:26PM +0200, Marco Crivellari wrote:
> > On Mon, May 11, 2026 at 2:48 PM Niklas Cassel <cassel@kernel.org> wrote:
> > > [...]
> > > Looks good to me.
> > >
> > > Any particular reason that you sent this as an RFC?
> > >
> > > I can see similar patches queued up in linux-next already.
> > 
> > I just wanted to be sure I didn't miss any other reason for being
> > per-cpu, and in case
> > receive comments on it.
> 
> Hmm... I can see that:
> drivers/ata/libata-eh.c:ata_scsi_port_error_handler()
> does:
> 
> schedule_delayed_work(&ap->hotplug_task, 0);
> 
> schedule_delayed_work() does:
> queue_delayed_work(system_percpu_wq, dwork, delay);
> 
> So this will schedule the work on a per-cpu workqueue.

Hmm, yes by accident because the delay is 0 so it will queue
to the current CPU.

 
> It seems that we are already queueing the same work (&ap->hotplug_task)
> on different workqueues, so I guess that is fine.
> 
> Right now, both workqueues are per-cpu. Is it fine to change one of them
> to be not be bound to a specific CPU?

Well, is there a reason why it is scheduled to the long work pool on one
hand and to the default pool on the other end? Should the behaviour be
consolidated to always use the unbound long work pool?

> From looking at the work, ata_scsi_hotplug(), I can't think of a reason
> why this would have to run on the same CPU as the CPU that queued the
> work.
> 
> From looking at workqueue.h:
> 
>  * system_dfl_wq is unbound workqueue.  Workers are not bound to
>  * any specific CPU, not concurrency managed, and all queued works are
>  * executed immediately as long as max_active limit is not reached and
>  * resources are available.
> 
>  [...]
> 
>  * system_dfl_long_wq is similar to system_dfl_wq but it may host long running
>  * works.
> 
> "not concurrency managed"
> 
> That sounds like a big change, since the per-cpu workqueues do seem to be
> concurrency managed (unlike the _dfl_ ones).
> 
> However, considering that the work (&ap->hotplug_task / ata_scsi_hotplug())
> does:
> mutex_lock(&ap->scsi_scan_mutex);
> 
> I also don't see a problem with the workqueue not being concurrency managed,
> since the work is taking a mutex anyway.
> 
> 
> 
> If anyone sees a problem, please say something, otherwise intend to queue
> this up in a few days.

Thanks!

-- 
Frederic Weisbecker
SUSE Labs
