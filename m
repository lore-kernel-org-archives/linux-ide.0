From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: Convert timers to use timer_setup()
Date: Fri, 6 Oct 2017 06:29:40 -0700
Message-ID: <20171006132940.GW3301751@devbig577.frc2.facebook.com>
References: <20171005005417.GA23922@beast>
 <20171005142124.GT3301751@devbig577.frc2.facebook.com>
 <CAGXu5j+4P5BEpM03keGqsTAJoveesnouUeswNJP-DPoMyiMTWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGXu5j+4P5BEpM03keGqsTAJoveesnouUeswNJP-DPoMyiMTWw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-ide@vger.kernel.org

On Thu, Oct 05, 2017 at 04:37:43PM -0700, Kees Cook wrote:
> On Thu, Oct 5, 2017 at 7:21 AM, Tejun Heo <tj@kernel.org> wrote:
> > On Wed, Oct 04, 2017 at 05:54:17PM -0700, Kees Cook wrote:
> >> In preparation for unconditionally passing the struct timer_list pointer to
> >> all timer callbacks, switch to using the new timer_setup() and from_timer()
> >> to pass the timer pointer explicitly. Adds a pointer back to link
> >> structure.
> >>
> >> Cc: Tejun Heo <tj@kernel.org>
> >> Cc: linux-ide@vger.kernel.org
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Acked-by: Tejun Heo <tj@kernel.org>
> >
> > Please feel free to route together with other timer patches.
> 
> Most of the timer conversions are going via the maintainer trees. Are
> you able to take these? If not, I can ask tglx to take them.

Yeah, please route through timer.

Thanks.

-- 
tejun
