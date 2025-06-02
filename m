Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D9720DF4;
	Mon,  2 Jun 2025 03:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748834067; cv=none; b=kBWhutRvhj03MRqIWKMcjvHIoWVpJUvnv6nUCIzFQ9TPqOU8FQBoRmlnC4sqSyhaJs9J0XeX8oniRWBC+Jj4OGclf/WbXW+4Pk7oGVRtXvhZKi9fMkJBGSjPrTm1FQgSXAE3OV8ftBEFBTUILUdYTKGyT5JrlDvp/xUB4Q5bN5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748834067; c=relaxed/simple;
	bh=T/fkZ6GB49Nv2JRnkt9E9Zmi+h2o7KqjYgObf/O4lJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1Gs4pz190SiBnv6hpjnv6qL5dwDDmRUo0pjvU5o7hDyvBxOk5b61ilzr00U555VNiohqhsttcckHbeVoe1U0AupMj98xtrqBNmA2B/HhY+5S1jS1tUY5SxJNPvGye/3O5Vq5e1CPuhYng5LMc8PgJDH2P22TtGhtfEQS+l8Bq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-6b-683d137fccc7
Date: Mon, 2 Jun 2025 11:59:06 +0900
From: Byungchul Park <byungchul@sk.com>
To: Yeo Reum Yun <YeoReum.Yun@arm.com>
Cc: "kernel_team@skhynix.com" <kernel_team@skhynix.com>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"kernel-team@lge.com" <kernel-team@lge.com>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	"harry.yoo@oracle.com" <harry.yoo@oracle.com>,
	"yskelg@gmail.com" <yskelg@gmail.com>,
	"her0gyugyu@gmail.com" <her0gyugyu@gmail.com>,
	"max.byungchul.park@gmail.com" <max.byungchul.park@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC DEPT v16] Question for dept.
Message-ID: <20250602025906.GA67804@system.software.com>
References: <GV1PR08MB10521BCB90DD275E324622DA0FB61A@GV1PR08MB10521.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV1PR08MB10521BCB90DD275E324622DA0FB61A@GV1PR08MB10521.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsXC9ZZnkW69sG2Gweo1ehZz1q9hs7i/7BmL
	xfSXbBYn711jtTi24xGTxeVdc9gs7q35z2pxYWIvq8XcL4YWjfM3sDhweayZt4bRY+esu+we
	mz5NYvfoenuFyePEjN8sHh+f3mLx+LxJLoA9issmJTUnsyy1SN8ugSvj0YLLzAV3ZCte9V9k
	bmDcL97FyMkhIWAi8WDKZDYY+/eOl4wgNouAisSyCU+ZQGw2AXWJGzd+MoPYIgJqEj9XHQOK
	c3EwC/SwSDy5Po8FJCEsoCdx6sx5sEG8AhYSXy8fBhskJBAnMXHzVlaIuKDEyZlPwOqZBbQk
	bvx7CTSIA8iWllj+jwMkzCkQL/FiyjewVlEBZYkD246D7ZIQuMwmsXj3LRaIQyUlDq64wTKB
	UWAWkrGzkIydhTB2ASPzKkahzLyy3MTMHBO9jMq8zAq95PzcTYzAWFhW+yd6B+OnC8GHGAU4
	GJV4eC/42WQIsSaWFVfmHmKU4GBWEuF1NbHKEOJNSaysSi3Kjy8qzUktPsQozcGiJM5r9K08
	RUggPbEkNTs1tSC1CCbLxMEp1cCorJ785brNhvWPevUdV+gGsFlNOZ8q9Jnx37t8k8+vvK2/
	SD+6FXjz1UWFec4cltpRe3yuL7rbukKwYnr37zlb2k5NlDS9y/Jt3QvVo1sm3AzR+VUj4ep0
	a5mmSV23CAN7ZcrX+NDTm7//NAqb2tfM+NCO4X+ZTLn9Xr9XOoHbj299rJAdyyaixFKckWio
	xVxUnAgAhGh7LoECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsXC5WfdrFsvbJthcP+rssWc9WvYLO4ve8Zi
	Mf0lm8XJe9dYLQ7PPclqcWzHIyaLy7vmsFncW/Of1eLCxF5Wi7lfDC0a529gceD2WDNvDaPH
	zll32T02fZrE7tH19gqTx4kZv1k8Pj69xeKx+MUHJo/Pm+QCOKK4bFJSczLLUov07RK4Mh4t
	uMxccEe24lX/ReYGxv3iXYycHBICJhK/d7xkBLFZBFQklk14ygRiswmoS9y48ZMZxBYRUJP4
	ueoYUJyLg1mgh0XiyfV5LCAJYQE9iVNnzrOB2LwCFhJfLx8GGyQkECcxcfNWVoi4oMTJmU/A
	6pkFtCRu/HsJNIgDyJaWWP6PAyTMKRAv8WLKN7BWUQFliQPbjjNNYOSdhaR7FpLuWQjdCxiZ
	VzGKZOaV5SZm5pjqFWdnVOZlVugl5+duYgQG9rLaPxN3MH657H6IUYCDUYmH94KfTYYQa2JZ
	cWXuIUYJDmYlEV5XE6sMId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxe4akJQgLpiSWp2ampBalF
	MFkmDk6pBkbzhRvZZ6bYH/py9FzBbQdVjV/aAb5XAv+0OuRsTyufGfbdan95qexZN8cLotIP
	ej8w/HgnvdW4cHNK8ukTmzYGvvj04pnR37P7vKuCF9oyzNI1YOm6dmyze6CwtWhImadiQaGD
	9Qvdlb8Pf7oZaJDFfeCKHNOFA3++fH3PHBAxvanE3dBwZZ0SS3FGoqEWc1FxIgBXY2luaAIA
	AA==
X-CFilter-Loop: Reflected

On Fri, May 30, 2025 at 11:27:48AM +0000, Yeo Reum Yun wrote:
> Hi Byungchul,
> 
> Thanks for your great work for the latest dept patch.
> 
> But I have a some quetions with the below dept log supplied from 
> Yunseong Kim<yskelg@gmail.com>
> 
> ...
> [13304.604203] context A
> [13304.604209]    [S] lock(&uprobe->register_rwsem:0)
> [13304.604217]    [W] __wait_rcu_gp(<sched>:0)
> [13304.604226]    [E] unlock(&uprobe->register_rwsem:0)
> [13304.604234]
> [13304.604239] context B 
> [13304.604244]    [S] lock(event_mutex:0)
> [13304.604252]    [W] lock(&uprobe->register_rwsem:0)
> [13304.604261]    [E] unlock(event_mutex:0)
> [13304.604269]
> [13304.604274] context C
> [13304.604279]    [S] lock(&ctx->mutex:0)
> [13304.604287]    [W] lock(event_mutex:0)
> [13304.604295]    [E] unlock(&ctx->mutex:0)
> [13304.604303]
> [13304.604308] context D
> [13304.604313]    [S] lock(&sig->exec_update_lock:0)
> [13304.604322]    [W] lock(&ctx->mutex:0)
> [13304.604330]    [E] unlock(&sig->exec_update_lock:0)
> [13304.604338]
> [13304.604343] context E
> [13304.604348]    [S] lock(&f->f_pos_lock:0)
> [13304.604356]    [W] lock(&sig->exec_update_lock:0)
> [13304.604365]    [E] unlock(&f->f_pos_lock:0)
> [13304.604373]
> [13304.604378] context F
> [13304.604383]    [S] (unknown)(<sched>:0)
> [13304.604391]    [W] lock(&f->f_pos_lock:0)
> [13304.604399]    [E] try_to_wake_up(<sched>:0)
> [13304.604408]
> [13304.604413] context G
> [13304.604418]    [S] lock(btrfs_trans_num_writers:0)
> [13304.604427]    [W] btrfs_commit_transaction(<sched>:0)
> [13304.604436]    [E] unlock(btrfs_trans_num_writers:0)
> [13304.604445]
> [13304.604449] context H
> [13304.604455]    [S] (unknown)(<sched>:0)
> [13304.604463]    [W] lock(btrfs_trans_num_writers:0)
> [13304.604471]    [E] try_to_wake_up(<sched>:0)
> [13304.604484] context I
> [13304.604490]    [S] (unknown)(<sched>:0)
> [13304.604498]    [W] synchronize_rcu_expedited_wait_once(<sched>:0)
> [13304.604507]    --------------- >8 timeout ---------------
> [13304.604527] context J
> [13304.604533]    [S] (unknown)(<sched>:0)
> [13304.604541]    [W] synchronize_rcu_expedited(<sched>:0)
> [13304.604549]    [E] try_to_wake_up(<sched>:0)

What a long circle!  Dept is working great!

However, this is a false positive that comes from rcu waits that haven't
been classified properly yet, the fix of which is in progress by
Yunseong Kim.  We should wait for him to complete the fix :(

> [end of circular]
> ...
> 
> 1. I wonder how context A could be printed with 
>     [13304.604217]    [W] __wait_rcu_gp(<sched>:0) 
>     since, the completion's dept map will be initailized with 
>        sdt_might_sleep_start_timeout((x)->dmap, -1L);
>    
>     I think last dept_task's stage_sched_map affects this wrong print.

No.  It's working as it should.  Since (x)->dmap is NULL in this case,
it's supposed to print <sched>.

>     Should this be fixed with:
> 
>  @@ -2713,6 +2713,7 @@ void dept_stage_wait(struct dept_map *m, struct dept_key *k,
>         if (m) {
>                 dt->stage_m = *m;
>                 dt->stage_real_m = m;
> +               dt->stage_sched_map = false;

It should already be false since sdt_might_sleep_end() reset this value
to false.  DEPT_WARN_ON(dt->stage_sched_map) in here might make more
sense.

>                 /*
>                  * Ensure dt->stage_m.keys != NULL and it works with the
>     
> 2. Whenever prints the dependency which initalized with sdt_might_sleep_start_timeout() currently it prints
>    (unknown)(<sched>:0) only.
>    Would it much better to print task information? (pid, comm and other).    

Thanks for such a valuable feedback.  I will add it to to-do.

	Byungchul
> 
> Thanks.
