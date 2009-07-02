From: Jeff Chua <jeff.chua.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Bug #13663] suspend to ram regression (IDE related)
Date: Thu, 2 Jul 2009 10:09:53 +0800
Message-ID: <b6a2187b0907011909l41b513fen3252ce00f7e4c9c9@mail.gmail.com>
References: <etTXaRqGgAC.A.SaE.6iASKB@chimera>
	 <1246459661.9660.40.camel@falcon>
	 <200907011821.26091.bzolnier@gmail.com>
	 <200907011829.16850.bzolnier@gmail.com>
	 <1246499203.9660.52.camel@falcon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1246499203.9660.52.camel@falcon>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wuzhangjin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Etienne Basset <etienne.basset-Bf/eaXMDFuuXqB7oj33eUg@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, rjw-KKrjLPT3xs0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Thu, Jul 2, 2009 at 9:46 AM, Wu Zhangjin<wuzhangjin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> it this too old? should i merge another git repository?
> I have tried to apply it manually, but unfortunately, also not work. any
> other patch needed?

You need to be undo those two patches below ...

> On Mon, Jun 29, 2009 at 11:51 PM, Etienne Basset<etienne.basset-Bf/eaXMDFuuXqB7oj33eUg@public.gmane.org>
> To have STR/resume work with current git, I have to :
> 1) apply Bart's patch
> 2) revert this commit : a1317f714af7aed60ddc182d0122477cbe36ee9b

or try to pull from Linus's tree and try again. Latest is now ...

commit d960eea974f5e500c0dcb95a934239cc1f481cfd
Author: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Date:   Mon Jun 29 14:54:11 2009 -0700

    kernel-doc: move ignoring kmemcheck



Jeff.
