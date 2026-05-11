Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7729C43635D;
	Mon, 11 May 2026 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517582; cv=none; b=MQjJJor5XVmb9O9Iv/ME5q0bp2xpeHiXK37YgCYOogXNHUMheyVqbO3r1vfla3azCNQmBI5x+Fn2wux8Btq6XXAQNzyaKCFA49FQnngCJiIAN5nyGFYZSBZy8D4KZmA+TprmlRr1dRpfQMBu7cGFGqsKbLkohmNLz28nGB5NNYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517582; c=relaxed/simple;
	bh=nQtjvADYTuG496DSPN1Rg+1H4SOtD+gch7jsUfgysdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myl2iYP0qeC5ZGc+m0tr5xfI4Vys5Bk65i7bRcd2pQFgrI01h5owLE6dY4WhlU8yEZ1h2Ng3qMj9R+2Ju4Zpm8pI78u/IWs0hjWQgH2HvxCDx3GxYiCw1uvVIoPKWEUJFIjrBNYfoVYOebiZHOOLMXaSWPMBxkPoZqAIXInEv30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BN5Ck/cP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BN5Ck/cP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AEAC2BCB0;
	Mon, 11 May 2026 16:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778517582;
	bh=nQtjvADYTuG496DSPN1Rg+1H4SOtD+gch7jsUfgysdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BN5Ck/cPmBz+HxcLIvHEJAa/HJlpDsAaQ+Fbvp3233MU6Qtr7b54sCC9JPNk6TByL
	 7puMuCnQvQyAaB+3rNhcbuqGMtIaDV+lR8OZuloSkp73sZ6sv5j0+qu6c+0VTMMrFF
	 XGuWL7RY3yVHlGIpBPj35GeNWiqRLwTtJzviq++KKWCm+Us80hOCJ1Ic1DbTgtn9a2
	 wbftwvOo1jFIjZi/x5CMPJTfn2NW+xHW8yLJKWm10e1wBUFR5/b4IJvDlEoRCUWcPk
	 5/poE+fdrgcMwHzlLQvZ/MihgVV1QxGtMtbwJybywm2DKUMI/Lc1MFfPxAz2Yo+urO
	 n9ebKCtLrXDaA==
Date: Mon, 11 May 2026 18:39:37 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [RFC PATCH] ata: libata-scsi: Move long delayed work on
 system_dfl_long_wq
Message-ID: <agIGSYxbK3FX2mXK@ryzen>
References: <20260430092947.128647-1-marco.crivellari@suse.com>
 <agHQBzVdIIPSTBah@ryzen>
 <CAAofZF7NhFUHKhp-HdvSx2doFRc4XFERCL22V+BZXrQVjmxugw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAofZF7NhFUHKhp-HdvSx2doFRc4XFERCL22V+BZXrQVjmxugw@mail.gmail.com>

On Mon, May 11, 2026 at 02:54:26PM +0200, Marco Crivellari wrote:
> On Mon, May 11, 2026 at 2:48 PM Niklas Cassel <cassel@kernel.org> wrote:
> > [...]
> > Looks good to me.
> >
> > Any particular reason that you sent this as an RFC?
> >
> > I can see similar patches queued up in linux-next already.
> 
> I just wanted to be sure I didn't miss any other reason for being
> per-cpu, and in case
> receive comments on it.

Hmm... I can see that:
drivers/ata/libata-eh.c:ata_scsi_port_error_handler()
does:

schedule_delayed_work(&ap->hotplug_task, 0);

schedule_delayed_work() does:
queue_delayed_work(system_percpu_wq, dwork, delay);

So this will schedule the work on a per-cpu workqueue.


It seems that we are already queueing the same work (&ap->hotplug_task)
on different workqueues, so I guess that is fine.

Right now, both workqueues are per-cpu. Is it fine to change one of them
to be not be bound to a specific CPU?

From looking at the work, ata_scsi_hotplug(), I can't think of a reason
why this would have to run on the same CPU as the CPU that queued the
work.



From looking at workqueue.h:

 * system_dfl_wq is unbound workqueue.  Workers are not bound to
 * any specific CPU, not concurrency managed, and all queued works are
 * executed immediately as long as max_active limit is not reached and
 * resources are available.

 [...]

 * system_dfl_long_wq is similar to system_dfl_wq but it may host long running
 * works.

"not concurrency managed"

That sounds like a big change, since the per-cpu workqueues do seem to be
concurrency managed (unlike the _dfl_ ones).

However, considering that the work (&ap->hotplug_task / ata_scsi_hotplug())
does:
mutex_lock(&ap->scsi_scan_mutex);

I also don't see a problem with the workqueue not being concurrency managed,
since the work is taking a mutex anyway.



If anyone sees a problem, please say something, otherwise intend to queue
this up in a few days.


Kind regards,
Niklas
