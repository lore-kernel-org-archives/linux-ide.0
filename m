From: Eric Mudama <edmudama@gmail.com>
Subject: Re: Silicon Image 3112 h/w docs available
Date: Mon, 25 Oct 2004 11:53:45 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <311601c904102510532a627fbc@mail.gmail.com>
References: <41792BC3.9060304@pobox.com>
	 <20041023191125.GJ9119@mail.petta-tech.com>
Reply-To: Eric Mudama <edmudama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus.kernel.org ([204.152.189.113]:35068 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261216AbUJYRyv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Oct 2004 13:54:51 -0400
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.196])
	by zeus.kernel.org (8.12.11/8.11.6) with ESMTP id i9PHsnjW007130
	for <linux-ide@vger.kernel.org>; Mon, 25 Oct 2004 10:54:50 -0700
Received: by rproxy.gmail.com with SMTP id 77so457089rnk
        for <linux-ide@vger.kernel.org>; Mon, 25 Oct 2004 10:53:46 -0700 (PDT)
In-Reply-To: <20041023191125.GJ9119@mail.petta-tech.com>
List-Id: linux-ide@vger.kernel.org
To: Eric Wong <eric@petta-tech.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

My understanding is that there's nothing to put in a SI3112 spec
regarding this issue.

The card follows the specification correctly.  The issue is some
drives don't handle this "legal but unexpected" behavior.  That issue
(in theory) would be for the drive vendors to document.

--eric

On Sat, 23 Oct 2004 12:11:25 -0700, Eric Wong <eric@petta-tech.com> wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> > In order to better support open source developers, Silicon Image has
> > been kind enough to give me permission to publicly post the hardware
> > documentation for some of their older SATA chipsets on my docs site,
> > namely the 3112 in this case:
> >
> > http://gkernel.sourceforge.net/specs/sii/3112A_SiI-DS-0095-B2.pdf.bz2
> >
> > This documentation will assist developers in maintaining the
> > siimage/sata_sil SATA drivers in the Linux kernel.
> >
> > So now the 311x joins the ranks of "open hardware".  Thanks, SiI!
> 
> Doesn't seem to contain any more info on drives/controllers affected by
> the mod15write quirk.  I'd like to see firmware revisions added to the
> blacklist, and not just model numbers anymore.  I didn't have that
> information when I first implemented the blacklist (model numbers only),
> and it still doesn't seem to be available right now.
> 
> I'm rather disappointed that the drive (ST3160023AS) I use has managed
> to get its way onto the blacklist[1].  I'm using rev 3.05 of that drive
> with a 3112 (rev 02), and have been for nearly a year at full speed and
> have never had problems under heavy read/write usage.  Setups affected
> by an uncorrected mod15write bug are corrupted almost immediately, no?
> 
> --
> Eric Wong -- eric@petta-tech.com -- normalperson@yhbt.net
> 
> 
>
