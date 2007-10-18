From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] ide: Fix siimage driver accessing beyond array boundary
Date: Thu, 18 Oct 2007 23:30:42 +0200
Message-ID: <200710182330.43052.bzolnier@gmail.com>
References: <20071018005623.153C7DDEBD@ozlabs.org> <47174B4A.3000006@ru.mvista.com> <1192709764.12879.66.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:5727 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761909AbXJRWua (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Oct 2007 18:50:30 -0400
Received: by nf-out-0910.google.com with SMTP id g13so285703nfb
        for <linux-ide@vger.kernel.org>; Thu, 18 Oct 2007 15:50:29 -0700 (PDT)
In-Reply-To: <1192709764.12879.66.camel@pasglop>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Linux IDE <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>

On Thursday 18 October 2007, Benjamin Herrenschmidt wrote:
> 
> On Thu, 2007-10-18 at 16:02 +0400, Sergei Shtylyov wrote:
> > Benjamin Herrenschmidt wrote:
> > 
> > > The siimage use an incorrect construct to access the other drive
> > > of a pair, causing it to access beyond an array boundary on non-0
> > > interfaces. This fixes it by using the new ide_get_paired_drive()
> > > hepler instead.
> > 
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> >     Please update the driver version in the driver's heading comment. Otherwise
> > 
> > Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> I don't believe much in driver versions in tree... the kernel version is
> what matter... Bart, what's your stance there ?

Similar opinion here but sometimes driver versions are useful, i.e.:

* during development or while debugging regressions to distinguish
  real changes (which have to update driver version) from the core
  changes and trivial cleanups (which don't do this)

* bugreports with partial dmesg info (hmm, doesn't matter for IDE
  currently since we don't print this info - patches are welcomed)

* maybe some other that I forgot :)

I updated siimage driver version in separate commit
(no need to do it for cs5535 since it lacks driver version).

Thanks,
Bart
