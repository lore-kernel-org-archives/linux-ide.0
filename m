From: Wu Zhangjin <wuzhangjin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Bug #13663] suspend to ram regression (IDE related)
Date: Wed, 01 Jul 2009 22:47:41 +0800
Message-ID: <1246459661.9660.40.camel@falcon>
References: <etTXaRqGgAC.A.SaE.6iASKB@chimera>
	 <5Hhc7UkUKEO.A.RvE.BjASKB@chimera> <4A489775.6020102@numericable.fr>
	 <20090629.033730.193709457.davem@davemloft.net>
	 <4A48E307.2010208@numericable.fr>
	 <b6a2187b0906290921w15afd443qccb943ccfd48688b@mail.gmail.com>
	 <b6a2187b0907010731k510150b5u1c7fce8cbed7c33b@mail.gmail.com>
Reply-To: wuzhangjin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b6a2187b0907010731k510150b5u1c7fce8cbed7c33b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeff Chua <jeff.chua.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Etienne Basset <etienne.basset-Bf/eaXMDFuuXqB7oj33eUg@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, rjw-KKrjLPT3xs0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bzolnier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Wed, 2009-07-01 at 22:31 +0800, Jeff Chua wrote:
> On Tue, Jun 30, 2009 at 12:21 AM, Jeff Chua<jeff.chua.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> > I just tried, and it "seems" to work. Will try a few more cycles.
> 
> STD/STR survived quite a few cycles now. Patch seems to be doing the
> right thing.
> 
> On Mon, Jun 29, 2009 at 11:51 PM, Etienne
> Basset<etienne.basset-Bf/eaXMDFuuXqB7oj33eUg@public.gmane.org> wrote:
> 
> > To have STR/resume work with current git, I have to :
> 
> > 1) apply Bart's patch
> 
> This is not yet in Linus's tree. And much needed to really fix the problem.
> 
> > 2) revert this commit : a1317f714af7aed60ddc182d0122477cbe36ee9b
> 

Yes, This commit must be reverted, otherwise, STD/Hibernation will not
work either. I have tested it on two different loongson-based machines:
fuloong2e box and yeeloong2f netbook.(loongson is mips compatiable)

Here is what i have traced:

        hibernate(kernel/power/hibernate.c)
        --> hibernation_snapshot
        --> dpm_resume_end
        --> dpm_resume
        --> device_resume
        --> dev->bus->resume(generic_ide_resume), dev_name(dev) = 0.0
        --> blk_execute_rq
        {
                DECLARE_COMPLETION_ONSTACK(wait);
                ...
                wait_for_completion(&wait);     // stop here
                ...
        }

and I have tried to revert this part of the above patch:

-
-               WARN_ON_ONCE(hwif->rq);
 repeat:
                prev_port = hwif->host->cur_port;
+
+               if (drive->dev_flags & IDE_DFLAG_BLOCKED)
+                       rq = hwif->rq;
+               else
+                       WARN_ON_ONCE(hwif->rq);
+

it works! need more time to test!

thanks!
Wu Zhangjin
