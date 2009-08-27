From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 2/3] slow-work: add support for cancellation of slow
	work
Date: Thu, 27 Aug 2009 11:14:10 +0200
Message-ID: <20090827091409.GF12579@kernel.dk>
References: <1251364122-9592-1-git-send-email-jens.axboe@oracle.com> <1251364122-9592-2-git-send-email-jens.axboe@oracle.com> <1251364122-9592-3-git-send-email-jens.axboe@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752062AbZH0JOK@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1251364122-9592-3-git-send-email-jens.axboe@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: tj@kernel.org, alan@lxorguk.ukuu.org.uk, jeff@garzik.org, dhowells@redhat.com
List-Id: linux-ide@vger.kernel.org

On Thu, Aug 27 2009, Jens Axboe wrote:
> @@ -194,12 +194,21 @@ static bool slow_work_execute(void)
>  	if (!test_and_clear_bit(SLOW_WORK_PENDING, &work->flags))
>  		BUG();
>  
> -	work->ops->execute(work);
> +	/*
> +	 * Don't execute if the work was cancelled after being added
> +	 */
> +	if (!test_bit(SLOW_WORK_CANCEL, &work->flags))
> +		work->ops->execute(work);
>  
>  	if (very_slow)
>  		atomic_dec(&vslow_work_executing_count);
>  	clear_bit_unlock(SLOW_WORK_EXECUTING, &work->flags);
>  
> +	/*
> +	 * Wake anyone waiting for this work to be done
> +	 */
> +	wake_up_bit(&work->flags, SLOW_WORK_EXECUTING);
> +
>  	/* if someone tried to enqueue the item whilst we were executing it,
>  	 * then it'll be left unenqueued to avoid multiple threads trying to
>  	 * execute it simultaneously

> +void cancel_slow_work(struct slow_work *work)
> +{
> +	set_bit(SLOW_WORK_CANCEL, &work->flags);
> +	wait_on_bit(&work->flags, SLOW_WORK_EXECUTING, slow_work_wait,
> +				TASK_UNINTERRUPTIBLE);
> +	clear_bit(SLOW_WORK_CANCEL, &work->flags);
> +}
> +EXPORT_SYMBOL(cancel_slow_work);

We want to use SLOW_WORK_PENDING for this logic, not SLOW_WORK_EXECUTING.
I'll update it.

-- 
Jens Axboe
