From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: PATCH: Allow per driver taskfile filters
Date: Sat, 6 Nov 2004 01:42:02 +0100
Message-ID: <200411060142.02146.bzolnier@elka.pw.edu.pl>
References: <1099672568.5564.49.camel@localhost.localdomain> <200411052311.45231.bzolnier@elka.pw.edu.pl> <1099697126.5630.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:45285 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261287AbUKFAjY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 19:39:24 -0500
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:42895 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S9749AbUKFAjX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Nov 2004 01:39:23 +0100
Received: from chello062179088136.chello.pl ([62.179.88.136]:65159 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S101137AbUKFAh3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Sat, 6 Nov 2004 01:37:29 +0100
In-Reply-To: <1099697126.5630.71.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Saturday 06 November 2004 00:25, Alan Cox wrote:
> On Gwe, 2004-11-05 at 22:11, Bartlomiej Zolnierkiewicz wrote:
> > This covers ide_raw_taskfile() calls, what with do_rw_taskfile()
> > ones and HDIO_DRIVE_[CMD,TASK,TASKFILE] ioctls?
> 
> do_rw_taskfile could be filtered. I'm not clear if filtering the HDIO
> ones
> is the right thing to do
> 
> > BTW IT8212 is (also) a real hardware RAID and it really deserves
> >     its own driver in the future (can share code with libata).
> > 
> > What is missing in libata to handle it?
> 
> ATAPI, working blacklists, testing, the same as to move every other
> driver over. When the rest move it can.

* ATAPI is done and working (both PIO and DMA)
* half of the blacklists is a crap (but I don't know which half :( )

BTW this is a _new_ driver so it is much easier to move
