From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/6] ide: fix setting nIEN on idle devices
Date: Tue, 16 Dec 2008 19:57:52 +0100
Message-ID: <200812161957.52419.bzolnier@gmail.com>
References: <20081213233925.4653.58008.sendpatchset@localhost.localdomain> <20081213233932.4653.97088.sendpatchset@localhost.localdomain> <20081214070620.GB31552@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:45973 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbYLPTO7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Dec 2008 14:14:59 -0500
Received: by fk-out-0910.google.com with SMTP id 18so1896155fkq.5
        for <linux-ide@vger.kernel.org>; Tue, 16 Dec 2008 11:14:57 -0800 (PST)
In-Reply-To: <20081214070620.GB31552@1wt.eu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Willy Tarreau <w@1wt.eu>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 14 December 2008, Willy Tarreau wrote:
> Hi Bart,
> 
> On Sun, Dec 14, 2008 at 12:39:32AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] ide: fix setting nIEN on idle devices
> > 
> > Fix do_ide_request() to operate on previous device / port instead of
> > the current one.  The original code was wrong since at least Feb 2002
> > (2.4.0 timeframe).
> 
> What could be the impact of this bug ? Should I backport your fix to 2.4 ?

The fix results in better handling of unexpected IRQs on serialized IDE
ports.  However since unexpected IRQs coming from a device is not something
we should normally see and I don't recall seeing any bugreports that would
be potentially closed by this fix I don't think that there is an urgent need
to backport it (thanks for caring about 2.4.x users anyway!).

Thanks,
Bart
