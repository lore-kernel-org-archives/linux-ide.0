From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 13/18] ide-floppy: replace pc->c with rq->cmd
Date: Sun, 15 Jun 2008 12:21:24 +0200
Message-ID: <20080615102124.GB7622@gollum.tnic>
References: <1213252870-20474-1-git-send-email-petkovbb@gmail.com> <1213252870-20474-14-git-send-email-petkovbb@gmail.com> <200806141940.22838.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:40806 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757013AbYFOKVd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Jun 2008 06:21:33 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2824423fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 15 Jun 2008 03:21:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200806141940.22838.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sat, Jun 14, 2008 at 07:40:22PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 12 June 2008, Borislav Petkov wrote:
> > This is the first one in the series attempting to phase out ide_atapi_pc and use
> > block request structs. Also, the pc request type is now REQ_TYPE_BLOCK_PC. As a result,
> > idefloppy_blockpc_cmd becomes unused and can go.
> 
> Do not attack too many dragons at once or they will slay you... ;)
> 
> IOW this patch mixes too many changes (some _really_ non-trivial)
> in one go which results in rather bad outcome...

yeah, this was more of a RFC patch for me not intended in any way for submission
but instead to get your comments on it. Atapi-land is full of surprises and you
have to be _really_ careful when changing stuff around. I got bitten by that
couple times when preparing those patches. Anyways, don't take those seriously,
they were simply a warmup :).

Thanks,
Boris.
