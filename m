From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 0/7] ide: locking improvements
Date: Sat, 11 Oct 2008 19:06:10 +0200
Message-ID: <20081011170610.GA7574@gollum.tnic>
References: <fa.Ke90oacfRjgiI4x5LejzjssRBEg@ifi.uio.no> <200810111645.27847.bzolnier@gmail.com> <20081011150532.GU19428@kernel.dk> <200810111756.37278.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:3243 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759383AbYJKRGO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Oct 2008 13:06:14 -0400
Received: by fg-out-1718.google.com with SMTP id 19so677935fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 11 Oct 2008 10:06:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200810111756.37278.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jens Axboe <jens.axboe@oracle.com>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Oct 11, 2008 at 05:56:37PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Saturday 11 October 2008, Jens Axboe wrote:
> > On Sat, Oct 11 2008, Bartlomiej Zolnierkiewicz wrote:
> > > On Saturday 11 October 2008, Jens Axboe wrote:
> > > > On Sat, Oct 11 2008, Borislav Petkov wrote:

[... ]

Don't you just love it when all gets resolved peacefully and everything is fine
and dandy afterwards. I'm so happy we've straightened that one out. Just a final
quick note which by no means is targetting to resparkle the discussion: I have
another bug report, hm, well :), but still, the machine is a 8-core AMD Dell box
(with the option of upgrading to 16 cores) which _is_ using ide-cd so, there are
some people using that code, after all :). I'm sure those people will be happier
when it scales to that many cores.

http://bugzilla.kernel.org/show_bug.cgi?id=11498.

-- 
Regards/Gruss,
    Boris.
