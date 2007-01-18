From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE Driver for Delkin/Lexar/etc.. cardbus CF adapter
Date: Thu, 18 Jan 2007 19:56:45 +0100
Message-ID: <58cb370e0701181056v7765f219n7d62a3d28d1310c@mail.gmail.com>
References: <20070112041720.28755.49663.sendpatchset@localhost.localdomain>
	 <200701131125.38882.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932229AbXARS4s@vger.kernel.org>
In-Reply-To: <200701131125.38882.liml@rtr.ca>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 1/13/07, Mark Lord <liml@rtr.ca> wrote:
> On Thursday 11 January 2007 23:17, Bartlomiej Zolnierkiewicz wrote:
> >
> > My working IDE tree (against Linus' tree) now resides here:
> >
> >       http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/patches/
>
> Bart, here's a driver I've been keeping out-of-tree for the past couple of years.
> This is for the Delking/Lexar/ASKA/etc.. 32-bit cardbus IDE CompactFlash adapter card.
>
> It's probably way out of sync with the latest driver model (??), but it still builds/works.
> I'm not interested in doing much of a rewrite, other than for libata someday,
> as I no longer use the card myself.
>
> But lots of other people do seem to use it, so it might be nice to see it "in-tree".
>
> Signed-off-by:  Mark Lord <mlord@pobox.com>

Thanks, I applied it to IDE tree.

[ I must have been really somehow fixated on IDE unregistering/ordering mess
  not to merge it earlier.  Sorry for that. ]
