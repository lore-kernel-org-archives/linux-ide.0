Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC493AFD0D;
	Fri, 10 Jul 2026 06:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783665712; cv=none; b=owkitsUAEDqXSfaPXaOkPmZszw9quQ7U7SBcbDZJmXl3yfUHpflTG2CrfvcMI4Mh9xuE2oRJqaFiPQ85xwVee9kE6NJXQPAx3S35MoOoFRM/+ZuRsZ76KvUJ9eb/ibpqd0VIpu3dpG83BuoPXhhDqPJghbwrjn0D7Cq/Rv9stN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783665712; c=relaxed/simple;
	bh=zA475enP7zeFi4gQv0OdWWwuxy0d1bvwkSpBh1EbMP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eq1yLNf8zRkvreCNRK23d1/a8qEf5I6dcl+GgKJKtn0h6K/c4xwJU+98/7fLhI59MnrepTcxhq3kP8svYqv60depLWqKd95g0pgkgCpdSuUJZJmcnsrUFAHY7g1pt1BwIm2W1kOzcNxWFYQPjm+H415ilP+dvHVtfC9KaKv1Quc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-85-6a50942c145c
Date: Fri, 10 Jul 2026 15:41:43 +0900
From: Byungchul Park <byungchul@sk.com>
To: sashiko-reviews@lists.linux.dev
Cc: ojeda@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Chuck Lever <cel@kernel.org>, dlemoal@kernel.org,
	linux-rt-devel@lists.linux.dev, Jeff Layton <jlayton@kernel.org>,
	tytso@mit.edu, cassel@kernel.org, linux-modules@vger.kernel.org,
	dri-devel@lists.freedesktop.org, kernel_team@skhynix.com
Subject: Re: [PATCH v19 19/40] dept: apply timeout consideration to
 hashed-waitqueue wait
Message-ID: <20260710064143.GH37630@system.software.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-20-byungchul@sk.com>
 <20260707073337.097CA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707073337.097CA1F000E9@smtp.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LhesuzSFdnSkCWwdpHshatO/+zWBybsILZ
	Yt2LI2wWD/bbW1z5+p7N4ueyVewWx3Y8YrK4vGsOm0XD7O+sFpdWX2CxWDl/OaNFw9LbrBat
	PT/ZHXg9Nq3qZPO4332cyePF5pmMHk1njjJ7fN4kF8AaxWWTkpqTWZZapG+XwJVxrLWRqeCj
	eMX/js1MDYy7+bsYOTkkBEwkDh5sYIax3965xAZiswioSlyc/oUVxGYTUJe4ceMnWI2IgLLE
	7B1nmboYuTiYBV4wSSzv6mEBSQgLREscWHwcrIFXwELi/NYudpAiIYFJjBIf+hcwQSQEJU7O
	fALWwCygI7Fz6x2gbRxAtrTE8n8cEGF5ieats8GWcQpYSSzt7QWbKQq0+MC242CLJQSes0k8
	XHCWBeJqSYmDK26wTGAUnIVkxSwkK2YhrJiFZMUCRpZVjEKZeWW5iZk5JnoZlXmZFXrJ+bmb
	GIGRtKz2T/QOxk8Xgg8xCnAwKvHwGtT7ZwmxJpYVV+YeYpTgYFYS4X0gAxTiTUmsrEotyo8v
	Ks1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgmy8TBKdXAqP5ir/W1BJEHahxSd4pDNoS3
	3Ljcb6F1uJv9qtHvMwZ9PBE7l4uFt15u2PYrZUqUqar1pbwvMY3pMhXhTwzX7p9l/iTvz8/l
	Wi+9q61mq77jiBM67lZRJHr/julCh4TNsu3rQo2DF944dT1ibdm2RKsb59u4WT/O2mjL6/aB
	ladS+CDHx/j7SizFGYmGWsxFxYkAECj9TaACAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsXC5WfdrKszJSDL4O0TdovWnf9ZLI5NWMFs
	se7FETaLB/vtLa58fc9m8XPZKnaLw3NPsloc2/GIyeLyrjlsFg2zv7NaXFp9gcVi5fzljBYN
	S2+zWrT2/GR34PPYtKqTzeN+93EmjxebZzJ6NJ05yuyx+MUHJo/Pm+QC2KK4bFJSczLLUov0
	7RK4Mo61NjIVfBSv+N+xmamBcTd/FyMnh4SAicTbO5fYQGwWAVWJi9O/sILYbALqEjdu/GQG
	sUUElCVm7zjL1MXIxcEs8IJJYnlXDwtIQlggWuLA4uNgDbwCFhLnt3axgxQJCUxilPjQv4AJ
	IiEocXLmE7AGZgEdiZ1b7wBt4wCypSWW/+OACMtLNG+dDbaMU8BKYmlvL9hMUaDFB7YdZ5rA
	yDcLyaRZSCbNQpg0C8mkBYwsqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQLjYlntn4k7GL9c
	dj/EKMDBqMTDa1DvnyXEmlhWXJl7iFGCg1lJhPeBDFCINyWxsiq1KD++qDQntfgQozQHi5I4
	r1d4aoKQQHpiSWp2ampBahFMlomDU6qBUT3LynfC0bNdDqdf6Czv2OPXesf9icIS3dsLpJ32
	Ojn9eDkvbIZT8+cdLeuOND/cfvPwli4ehksmen1PVMTn/TrtLvbRW4Bxml2e6qFbl+Ir005d
	9DoTtqlZi+Fa/E2mxpTvMemH/20W2WcUvcIgYNPXTBGjObvX5RrWd/Gu9Fu2oekJR5vmRiWW
	4oxEQy3mouJEACZ4n+WHAgAA
X-CFilter-Loop: Reflected

On Tue, Jul 07, 2026 at 07:33:36AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Missing `sdt_might_sleep_end()` cleanup in the error path of wait macros (e.g., `___wait_var_event`, `___wait_event`, `___swait_event`) bypasses `dept_clean_stage()`, leaking the staged wait event state and corrupting DEPT tracking.
> --
> 
> commit cf04720896ab037609320947c88e8faa57dbddd7
> Author: Byungchul Park <byungchul@sk.com>
> 
> dept: apply timeout consideration to hashed-waitqueue wait
> 
> Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
> consideration to hashed-waitqueue wait, assuming an input 'ret' in
> ___wait_var_event() macro is used as a timeout value.
> 
> > diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
> > index 179a616ad245a..9885ac4e1ded5 100644
> > --- a/include/linux/wait_bit.h
> > +++ b/include/linux/wait_bit.h
> > @@ -258,7 +258,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
> >       struct wait_bit_queue_entry __wbq_entry;                        \
> >       long __ret = ret; /* explicit shadow */                         \
> >                                                                       \
> > -     sdt_might_sleep_start(NULL);                                    \
> > +     sdt_might_sleep_start_timeout(NULL, __ret);                     \
> 
> [Severity: High]
> Does this error path properly clean up the dept wait state?
> 
> Lower in the ___wait_var_event() macro, if a signal is received it jumps to
> __out:
> 
>                 if (___wait_is_interruptible(state) && __int) {         \
>                         __ret = __int;                                  \
>                         goto __out;                                     \
>                 }                                                       \
> 
>                 ...
> 
>         sdt_might_sleep_end();                                          \
> __out:  __ret;                                                          \
> 
> Because the goto __out branch skips sdt_might_sleep_end(), does it leave a
> dangling stage context in the dept subsystem's tracking graph?
> 
> If the stage context remains populated, could a subsequent wait on the same
> task be incorrectly seen as a nested stage, potentially corrupting dept
> tracking or leading to false deadlock reports?

I will fix it.

> (Note: A similar goto __out pattern skipping sdt_might_sleep_end() also
> exists in ___wait_event() in include/linux/wait.h and ___swait_event() in
> include/linux/swait.h).

I will fix it.

	Byungchul

> 
> >       init_wait_var_entry(&__wbq_entry, var,                          \
> >                           exclusive ? WQ_FLAG_EXCLUSIVE : 0);         \
> >       for (;;) {                                                      \
> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706061928.66713-1-byungchul@sk.com?part=19
