From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 3/3] pata: "I do not think it means, what you think it
 means."
Date: Tue, 4 Mar 2008 17:30:58 -0800
Message-ID: <20080304173058.7679b7c8.akpm@linux-foundation.org>
References: <200803042316.m24NGI7k002489@imap1.linux-foundation.org>
	<200803050234.40594.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37860 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753038AbYCEBcW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Mar 2008 20:32:22 -0500
In-Reply-To: <200803050234.40594.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, linux-kernel@vger.kernel.org

On Wed, 5 Mar 2008 02:34:40 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Wednesday 05 March 2008, akpm@linux-foundation.org wrote:
> > From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > 
> > When masking mask out the modes that are unsupported not the ones that are
> > supported.  This makes life happier.
> > 
> 
> Jeff,
> 
> Could we get this merged ASAP (it was first posted on 26th February)?
> 
> This patch fixes data corruption for libata PATA ServerWorks and HPT drivers.
> 
> [ IDE users are already leaving happy life since they are not affected
>   (modes masking has always worked correctly in the original drivers)...
> 
>   Can we make life happy also for libata PATA users? :) ]
> 

(edited to undo top-posting damage)

I didn't know any of that.  The changelog might have been kinda fun, but
given that it failed to tell us that the patch fixes data-corruption
errors, the changelog was excrutiatingly bad.

Do we need this fix in 2.6.24.x as well?
