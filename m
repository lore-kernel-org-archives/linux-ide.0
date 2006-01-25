From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: PATCH convert libata-core to the new debugging scheme
Date: Wed, 25 Jan 2006 16:04:04 +0100
Message-ID: <58cb370e0601250704v4aa89fc2n5f7194bbacd4a278@mail.gmail.com>
References: <20060124194343.GB25402@gollum.tnic>
	 <20060124194741.GG23269@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.196]:4898 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751190AbWAYPEK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Jan 2006 10:04:10 -0500
Received: by uproxy.gmail.com with SMTP id s2so202638uge
        for <linux-ide@vger.kernel.org>; Wed, 25 Jan 2006 07:04:06 -0800 (PST)
In-Reply-To: <20060124194741.GG23269@havoc.gtf.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Borislav Petkov <bbpetkov@yahoo.de>, linux-ide@vger.kernel.org, htejun@gmail.com, randy_d_dunlap@linux.intel.com

On 1/24/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> On Tue, Jan 24, 2006 at 08:43:43PM +0100, Borislav Petkov wrote:
> > for the debugging macros which to me _is_ kinda too much. In addition, the
> > ata_msg_xxx() macros are going to be pretty useless if we wrap them one more
> > time into other macros but this is only my opinion.
>
> Yes, I like the current stuff, and am not really interested in further
> macros.

What about using Randy's suggestion the other way around:
embedding printk-s into ata_msg_* macros?

This way we would get rid of all these if-s in the code
without adding more macros.

i.e. we would have

+       ata_msg_ctl(ap, "ata%u: cmd 0x%X\n", ap->id, tf->command);

instead of

+       if (ata_msg_ctl(ap))
+                       printk(KERN_DEBUG "%s: ata%u: cmd 0x%X\n",
+                               __FUNCTION__, ap->id, tf->command);

Bartlomiej
