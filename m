From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 13/18] ide-floppy: replace pc->c with rq->cmd
Date: Sun, 15 Jun 2008 16:57:49 +0200
Message-ID: <200806151657.49843.bzolnier@gmail.com>
References: <1213252870-20474-1-git-send-email-petkovbb@gmail.com> <200806141940.22838.bzolnier@gmail.com> <20080615102124.GB7622@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:32734 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758142AbYFOO5T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Jun 2008 10:57:19 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2910188ywe.1
        for <linux-ide@vger.kernel.org>; Sun, 15 Jun 2008 07:57:14 -0700 (PDT)
In-Reply-To: <20080615102124.GB7622@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sunday 15 June 2008, Borislav Petkov wrote:
> On Sat, Jun 14, 2008 at 07:40:22PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Thursday 12 June 2008, Borislav Petkov wrote:
> > > This is the first one in the series attempting to phase out ide_atapi_pc and use
> > > block request structs. Also, the pc request type is now REQ_TYPE_BLOCK_PC. As a result,
> > > idefloppy_blockpc_cmd becomes unused and can go.
> > 
> > Do not attack too many dragons at once or they will slay you... ;)
> > 
> > IOW this patch mixes too many changes (some _really_ non-trivial)
> > in one go which results in rather bad outcome...
> 
> yeah, this was more of a RFC patch for me not intended in any way for submission
> but instead to get your comments on it. Atapi-land is full of surprises and you
> have to be _really_ careful when changing stuff around. I got bitten by that
> couple times when preparing those patches. Anyways, don't take those seriously,
> they were simply a warmup :).

I'm not worried at all - I'm sure that if you keep fighting these dragons
one by one they won't stand a chance... :)
