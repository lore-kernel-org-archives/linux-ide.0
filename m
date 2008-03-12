From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/4] ide-tape: remove pipeline-specific code from idetape_add_chrdev_write_request
Date: Wed, 12 Mar 2008 14:51:32 +0100
Message-ID: <200803121451.33058.bzolnier@gmail.com>
References: <1205082632-3418-1-git-send-email-petkovbb@gmail.com> <200803110025.19650.bzolnier@gmail.com> <20080312054156.GC4266@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:38555 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbYCLNhi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Mar 2008 09:37:38 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2893765fga.17
        for <linux-ide@vger.kernel.org>; Wed, 12 Mar 2008 06:37:36 -0700 (PDT)
In-Reply-To: <20080312054156.GC4266@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wednesday 12 March 2008, Borislav Petkov wrote:
> On Tue, Mar 11, 2008 at 12:25:19AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 09 March 2008, Borislav Petkov wrote:
> > > Refrain from adding more write requests to the pipeline and queue them
> > > directly on the device's request queue instead. Prior to that flush all
> > > penging stages in the pipeline through idetape_wait_for_pipeline().
> > 
> > I would prefer to keep the original code for now
> > (it has some subtle differences).
> 
> Well, if you mean by this the while-loop below, the original code offloads
> the pipeline gradually, stage-wise, until allocation succeeds, in contrast to
> idetape_wait_for_pipeline() which iterates over all pending stages and flushes
> them all in one go.
> 
> At a certain in point in time, however, the driver might land at the unlikely
> state of still having some stages left in the pipeline while queueing all
> incoming requests on the rq queue. Therefore, i'd prefer to make sure the

This is what could happen with the unmodified driver code also.

[ thus given that pipeline code goes away completely soon there is no point
  in changing the original behavior (unless of course it is buggy and I just
  fail to see it) ]

> pipeline is empty before queueing. What is more, it is flushed only once, if
> ever, so idetape_wait_for_pipeline() simply returns in subsequent calls and no
> considerable performance penalties are imposed here.
