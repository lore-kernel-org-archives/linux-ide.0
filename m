From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-cd: prevent null pointer deref via cdrom_newpc_intr
Date: Sat, 20 Jun 2009 12:27:31 +0200
Message-ID: <200906201227.36253.bzolnier@gmail.com>
References: <87zlc58xgd.fsf@fever.mssgmbh.com> <87r5xh8ty7.fsf@fever.mssgmbh.com> <9ea470500906180906o2d558a90hbcba11874ff8917b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:56667 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbZFTLzQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Jun 2009 07:55:16 -0400
In-Reply-To: <9ea470500906180906o2d558a90hbcba11874ff8917b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: Rainer Weikusat <rweikusat@mssgmbh.com>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, bruinjm@xs4all.nl

On Thursday 18 June 2009 18:06:34 Borislav Petkov wrote:
> Hi,
> 
> On Thu, Jun 18, 2009 at 5:04 PM, Rainer Weikusat<rweikusat@mssgmbh.com> wrote:
> > From: Rainer Weikusat <rweikusat@mssgmbh.com>
> >
> > With 2.6.30, the error handling code in cdrom_newpc_intr was changed
> > to deal with partial request failures by normally completing the 'good'
> > parts of a request and only 'error' the last (and presumably,
> > incompletely transferred) bio associated with a particular
> > request. In order to do this, ide_complete_rq is called over
> > ide_cd_error_cmd() to partially complete the rq. The block layer
> > does partial completion only for requests with bio's and if the
> > rq doesn't have one (eg 'GPCMD_READ_DISC_INFO') the request is
> > completed as a whole and the drive->hwif->rq pointer set to NULL
> > afterwards. When calling ide_complete_rq again to report
> > the error, this null pointer is derefenced, resulting in a kernel
> > crash.

Rainer, thanks for fixing this bug (with a lot of extra points for
the detailed explanation).

> @Bart: please apply.

applied [I kept the above patch description]
