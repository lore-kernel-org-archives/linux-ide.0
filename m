From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 3/3] pata: "I do not think it means, what you think it means."
Date: Wed, 5 Mar 2008 02:54:57 +0100
Message-ID: <200803050254.57235.bzolnier@gmail.com>
References: <200803042316.m24NGI7k002489@imap1.linux-foundation.org> <200803050234.40594.bzolnier@gmail.com> <20080304173058.7679b7c8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:62264 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbYCEBrL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Mar 2008 20:47:11 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3014222ugc.16
        for <linux-ide@vger.kernel.org>; Tue, 04 Mar 2008 17:47:07 -0800 (PST)
In-Reply-To: <20080304173058.7679b7c8.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, linux-kernel@vger.kernel.org

On Wednesday 05 March 2008, Andrew Morton wrote:
> On Wed, 5 Mar 2008 02:34:40 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > On Wednesday 05 March 2008, akpm@linux-foundation.org wrote:
> > > From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > > 
> > > When masking mask out the modes that are unsupported not the ones that are
> > > supported.  This makes life happier.
> > > 
> > 
> > Jeff,
> > 
> > Could we get this merged ASAP (it was first posted on 26th February)?
> > 
> > This patch fixes data corruption for libata PATA ServerWorks and HPT drivers.
> > 
> > [ IDE users are already leaving happy life since they are not affected
> >   (modes masking has always worked correctly in the original drivers)...
> > 
> >   Can we make life happy also for libata PATA users? :) ]
> > 
> 
> (edited to undo top-posting damage)
> 
> I didn't know any of that.  The changelog might have been kinda fun, but
> given that it failed to tell us that the patch fixes data-corruption
> errors, the changelog was excrutiatingly bad.
> 
> Do we need this fix in 2.6.24.x as well?

Let me quote Alan's opinion on this:

	"I think that would be wise ;)"

nothing needs to be added here ;)
