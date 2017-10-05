From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] ahci: Convert timers to use timer_setup()
Date: Thu, 5 Oct 2017 16:37:43 -0700
Message-ID: <CAGXu5j+4P5BEpM03keGqsTAJoveesnouUeswNJP-DPoMyiMTWw@mail.gmail.com>
References: <20171005005417.GA23922@beast> <20171005142124.GT3301751@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171005142124.GT3301751@devbig577.frc2.facebook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-ide@vger.kernel.org

On Thu, Oct 5, 2017 at 7:21 AM, Tejun Heo <tj@kernel.org> wrote:
> On Wed, Oct 04, 2017 at 05:54:17PM -0700, Kees Cook wrote:
>> In preparation for unconditionally passing the struct timer_list pointer to
>> all timer callbacks, switch to using the new timer_setup() and from_timer()
>> to pass the timer pointer explicitly. Adds a pointer back to link
>> structure.
>>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: linux-ide@vger.kernel.org
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Acked-by: Tejun Heo <tj@kernel.org>
>
> Please feel free to route together with other timer patches.

Most of the timer conversions are going via the maintainer trees. Are
you able to take these? If not, I can ask tglx to take them.

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
