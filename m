From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: ide-tape redux (was: Re:)
Date: Tue, 5 Feb 2008 02:20:22 +0100
Message-ID: <200802050220.22637.bzolnier@gmail.com>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:51879 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757292AbYBEBPI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 20:15:08 -0500
Received: by nf-out-0910.google.com with SMTP id g13so440459nfb.21
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2008 17:15:06 -0800 (PST)
In-Reply-To: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi Borislav,

On Monday 04 February 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> here are the pending ide-tape patches reworked which incorporate all review
> points raised so far. Several new patches are appended to the original series
> which i thought would be reasonable to sumbit along with the others. Also,
> i've applied "ide-tape: dump gcw fields on error in idetape_identify_device()"
> which is #12 and which you can simply ignore. Furthermore, #32 from the original
> series got split up into the different logical changes it dealt with, as you
> requested.

Thanks!  [ Reviewing was so much easier. ]

>  Documentation/feature-removal-schedule.txt |   14 +-
>  drivers/ide/ide-tape.c                     | 2764 +++++++++++++---------------
>  2 files changed, 1325 insertions(+), 1453 deletions(-)

applied #1-7, #9-10, #13-22 (+queued all of them for 2.6.25)

w.r.t. #8 I'm waiting for Jens to comment on blk_{get,put}_request() approach

w.r.t. #11 ide-tape uses char devices and supports DSC so it is not as obvious
as in ide-floppy case that all atomic bitops can be just removed (extra audit
and some time -mm are required) so please resync/resubmit

#12 is already in Linus' tree

Bart
