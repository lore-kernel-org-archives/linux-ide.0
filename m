From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/4] ide-tape: remove pipeline-specific code from idetape_add_chrdev_write_request
Date: Wed, 12 Mar 2008 15:31:58 +0100
Message-ID: <200803121531.58649.bzolnier@gmail.com>
References: <1205082632-3418-1-git-send-email-petkovbb@gmail.com> <200803110025.19650.bzolnier@gmail.com> <20080312054156.GC4266@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:63571 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbYCLOR7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Mar 2008 10:17:59 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2906124fga.17
        for <linux-ide@vger.kernel.org>; Wed, 12 Mar 2008 07:17:57 -0700 (PDT)
In-Reply-To: <20080312054156.GC4266@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 12 March 2008, Borislav Petkov wrote:

> > > The remaining pipeline stage allocation code is used for the next current
> > > pipeline stage (tape->merge_stage) and data buffer for an upcoming
> > > request. The so allocated pipeline stage is rewired into the tape struct
> > > thru idetape_switch_buffers() and used during the next request for
> > > copying user data into it (see e.g. idetape_chrdev_write()). In case the
> > > allocation fails, the current request is still attempted prior to failing.
> > 
> > Is this really needed now that we've removed pipeline operation for write
> > requests?
> 
> I did this simply to keep behavior changes at minimum - after removing the
> pipeline code completely this'll be simplified too.

BTW I see now how poorly I explained things the last time. :(

[ Sorry for that! ]

Our goal is not "pure" minimal behavior changes but minimal "behavior + code"
changes - IOW we are searching for the best balance for keeping both the old
behavior and code changes (and thus patch _complexity_) at the minimal level.

