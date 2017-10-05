From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Convert timers to use timer_setup()
Date: Thu, 5 Oct 2017 07:20:07 -0700
Message-ID: <20171005142007.GS3301751@devbig577.frc2.facebook.com>
References: <20171005004842.GA23011@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171005004842.GA23011@beast>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-ide@vger.kernel.org

On Wed, Oct 04, 2017 at 05:48:42PM -0700, Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-ide@vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to route this with other timer changes.

Thanks.

-- 
tejun
