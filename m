From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] libata: only call ->done once all per-tag ressources
 are released
Date: Tue, 6 Oct 2015 13:28:43 -0400
Message-ID: <20151006172843.GB3931@mtj.duckdns.org>
References: <1443892871-10413-1-git-send-email-hch@lst.de>
 <1443892871-10413-2-git-send-email-hch@lst.de>
 <20151004173429.GD19652@htj.duckdns.org>
 <20151005060117.GA2294@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:35713 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbbJFR3A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Oct 2015 13:29:00 -0400
Received: by ioiz6 with SMTP id z6so229486151ioi.2
        for <linux-ide@vger.kernel.org>; Tue, 06 Oct 2015 10:28:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151005060117.GA2294@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org

Hello, Christoph.

On Mon, Oct 05, 2015 at 08:01:17AM +0200, Christoph Hellwig wrote:
> On Sun, Oct 04, 2015 at 01:34:29PM -0400, Tejun Heo wrote:
> > Hmmm... has this actually been observed?  All these are run under ata
> > port lock and so is the command issue path, so even if the tag gets
> > reissued, it will have to wait till the completion path is done.
> 
> No - I stumbled over this while trying to debug
> https://lkml.org/lkml/2015/6/25/620 (which could use some libata experience,
> btw), but it didn't help.  I still would like to see it fixes as similar
> patterns in SCSI drivers have caused crashes.

So, given the locking, the bug doesn't exist.  I don't think switching
to a safer pattern is a bad thing but the patch needs updated
description and comment explanining that it isn't a bug fix and the
specific ordering isn't strictly necessary.

Thanks.

-- 
tejun
