From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] libata: add CFA specific identify data words
Date: Mon, 13 Apr 2009 23:32:10 +0200
Message-ID: <200904132332.10246.bzolnier@gmail.com>
References: <200903032029.29073.sshtylyov@ru.mvista.com> <200904132142.49279.bzolnier@gmail.com> <49E3A061.7070400@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:47441 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbZDMViG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Apr 2009 17:38:06 -0400
Received: by fxm2 with SMTP id 2so2167135fxm.37
        for <linux-ide@vger.kernel.org>; Mon, 13 Apr 2009 14:38:03 -0700 (PDT)
In-Reply-To: <49E3A061.7070400@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Monday 13 April 2009 22:28:17 Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > As I see it, there was absolutely no need to rush things -- I simply didn't
> > get to processing newer submissions yet and I would just push Sergei's patch
> > in the next IDE pull request (which happened on March 13th).
> 
> That is an IDE-centric perspective.  It was a cross-tree depedency, and 
> _I_ should not need to wait for you, particularly when you are 
> constantly complaining about lacking time for IDE maintenance.

The patch had _zero_ IDE specific changes, you didn't have to wait for me.

You could have simply pushed the whole Sergei's patch yourself and indeed
this will make things more efficient for everybody.

> > Simple reminder/query about the patch status would be more than enough but
> > instead you wasted time for everybody by splitting libata part from Sergei's
> > patch (without updating patch summary+description which I had to fix) and
> > later forgotting about it.  Moreover instead of simply pushing forgotten
> > part yourself you requested Sergei to resubmit it and at the same time you
> > tried to put the blame about the whole situation on me.
> 
> The onus is always on the submittor to monitor their patches, resubmit, 
> etc.  It is simply not scalable to constantly ping submittors, keep 
> track of their individual development schedules, etc.

In the end it is your responsibility as the Maintainer to get their patches
merged (== keep the project flourishing).  Plus keeping in touch with people
submitting you patches and knowing (more-or-less) their individual schedules
is a key into properly planning merges or large scale changes.  Though YMMV
as there is no one perfect way of doing things befitting all people.

Thanks,
Bart
