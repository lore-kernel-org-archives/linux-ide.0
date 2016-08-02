From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0063/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 09:19:37 -0400
Message-ID: <20160802131937.GB11666@home.goodmis.org>
References: <20160802103759.17958-1-baolex.ni@intel.com>
 <5391e340-1285-574d-1979-a19571341eb5@cogentembedded.com>
 <a4bf3836-1ffa-9f83-6e8f-998c99d5b507@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a4bf3836-1ffa-9f83-6e8f-998c99d5b507@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Baole Ni <baolex.ni@intel.com>, b.zolnierkie@samsung.com, tj@kernel.org, lenb@kernel.org, x86@kernel.org, hpa@zytor.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, travis@sgi.com
List-Id: linux-ide@vger.kernel.org

On Tue, Aug 02, 2016 at 03:32:57PM +0300, Sergei Shtylyov wrote:
> > >  static int all;
> > > -module_param(all, int, 0444);
> > > +module_param(all, int, S_IRUSR | S_IRGRP | S_IROTH);
> > 
> >    There's S_IRUGO for this case, no?

Sure, and honestly, I understand what 0444 is better than seeing:

  S_IRUSR | S_IRGRP | SIROTH

Heck, 0444 is more understandable to me than S_IRUGO, because honestly, those
macros are just as cryptic as 0444 is. Working with Unix/Linux systems since
1991, I understand the octo numbers very well. And I'm sure most other people
do to. Any file that I'm Cc'd on here will get an automatic NAK from me.

> 
>    Sending 1285 patches with the same subject also was a bad idea. You need
> a subsystem/driver prefix in order to somehow differ them.

Yes, it's a very good way to be added to everyone's /dev/null folder too. Each
subsystem should have one patch that covers all its files. Not a patch per
file!

What? Is Intel now give extra bonuses for commit numbers?

Sorry, but I'm a little grumpy when my phone starts popping like a popcorn
machine while I'm having my breakfast because of these silly emails.

-- Steve
