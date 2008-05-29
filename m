From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 14/40] ide-floppy: merge idefloppy_transfer_pc() and idefloppy_transfer_pc1()
Date: Fri, 30 May 2008 01:01:13 +0200
Message-ID: <200805300101.14495.bzolnier@gmail.com>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain> <200805272057.42444.bzolnier@gmail.com> <20080527053737.GA19760@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:16263 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbYE2XVN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 May 2008 19:21:13 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2805824mue.1
        for <linux-ide@vger.kernel.org>; Thu, 29 May 2008 16:21:11 -0700 (PDT)
In-Reply-To: <20080527053737.GA19760@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 27 May 2008, Borislav Petkov wrote:
> On Tue, May 27, 2008 at 08:57:42PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Wednesday 21 May 2008, Borislav Petkov wrote:
> > > On Sun, May 18, 2008 at 08:56:33PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > * Check IDEFLOPPY_FLAG_ZIP_DRIVE flag in idefloppy_transfer_pc1()
> > > >   and skip idefloppy_transfer_pc2()-phase if the flag is not set.
> > > > 
> > > > * Always use idefloppy_transfer_pc1() in idefloppy_issue_pc()
> > > >   and remove no longer needed idefloppy_transfer_pc().
> > > 
> > > ... and also probably mv idefloppy_transfer_pc1() to something like
> > > idefloppy_start_transfer_pc() and rename idefloppy_transfer_pc2() to something
> > > more appropriate like e.g. idefloppy_do_transfer_pc() or similar and do away
> > > with those misleading names and probably even the comments are superfluous then.
> > 
> > Probably the most intuitive would be to do:
> > 
> > 	idefloppy_transfer_pc1() -> idefloppy_transfer_pc()
> > 
> > and
> > 
> > 	idefloppy_transfer_pc2() -> idefloppy_do_transfer_pc()
> > 
> > but I don't feel too strong about it and welcome other ideas
> > (preferably in form of patches :).
> 
> ^Hint^! :) Sure, what about the following:
> --
> 
> From: Borislav Petkov <petkovbb@gmail.com>
> Date: Tue, 27 May 2008 07:31:37 +0200
> Subject: [PATCH] ide-floppy: fix unfortunate function naming
> 
> mv idefloppy_transfer_pc1 idefloppy_start_pc_transfer
> mv idefloppy_transfer_pc2 idefloppy_transfer_pc
> 
> which describes their functionality and disambiguates them. There should be no
> functionality change introduced by this patch.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied, thanks
