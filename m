From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 10/12] ide-floppy: remove atomic test_*bit macros
Date: Wed, 16 Jan 2008 23:08:14 +0100
Message-ID: <200801162308.15217.bzolnier@gmail.com>
References: <1200255505-31418-1-git-send-email-bbpetkov@yahoo.de> <200801142332.58341.bzolnier@gmail.com> <20080115200921.GA5699@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:31868 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbYAPWjN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2008 17:39:13 -0500
Received: by ug-out-1314.google.com with SMTP id z38so272674ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2008 14:39:11 -0800 (PST)
In-Reply-To: <20080115200921.GA5699@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bbpetkov@yahoo.de
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tuesday 15 January 2008, Borislav Petkov wrote:
> On Mon, Jan 14, 2008 at 11:32:58PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On Monday 14 January 2008, Bartlomiej Zolnierkiewicz wrote:
> > > On Sunday 13 January 2008, Borislav Petkov wrote:
> > > > ..and replace them with flag enums.
> > > > 
> > > > Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> > 
> > small update:
> > 
> > PC_ABORT is never set and may as well be removed in a pre-patch
> 
> Here you go, the one below should be pushed first...
> 
> --
> From: Borislav Petkov <bbpetkov@yahoo.de>
> Date: Tue, 15 Jan 2008 20:34:50 +0100
> Subject: ide-floppy: remove unused flag PC_ABORT
> 
> This flag was never being set in the code so remove it. By the way, the
> code in the second patch was being executed unconditionally, i.e. in case
> pc->retries > IDEFLOPPY_MAX_PC_RETRIES is true (actually that is the only case
> when the outer if-test passed), !test_bit(PC_ABORT, &pc->flags)
> was always true so the comment is now incorrect and has to go.
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

thanks, applied
