From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH v2 2/3] lib: glob.c: Add CONFIG_GLOB_SELFTEST
Date: 11 Jun 2014 21:38:08 -0400
Message-ID: <20140612013808.20579.qmail@ns.horizon.com>
References: <20140611160452.7715d3c4a0cb584e8b507da7@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140611160452.7715d3c4a0cb584e8b507da7@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, linux@horizon.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, rdunlap@infradead.org, tj@kernel.org
List-Id: linux-ide@vger.kernel.org

>> Persuading GCC to throw away *all* the self-test data after running
>> it was surprisingly annoying.
>
> Yeah.  Props for making the attempt.

*Whew*.  I was worried I'd get upbraided for overoptimziation.

>> The one thing I'm not really sure about is what to do if the self-test
>> fails.  For now, I make the module_init function fail too.  Opinions?
>
> The printk should suffice - someone will notice it eventually.
> 
> Using KERN_ERR to report a failure might help draw attention to it.

I'm not sure what you mean by "might"; I already *do* report it as KERN_ERR.

If you think failing the module load is a bad idea, feel free to
modify the patch.
