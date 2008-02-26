From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] ide-cd: fix some codestyle and most of the checkpatch.pl issues
Date: Tue, 26 Feb 2008 23:46:53 +0030
Message-ID: <4d8e3fd30802261516g5f4ca763kd4f8405f136b9847@mail.gmail.com>
References: <1204012194-4208-1-git-send-email-petkovbb@gmail.com>
	 <1204012194-4208-3-git-send-email-petkovbb@gmail.com>
	 <200802262337.29873.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:38690 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764198AbYBZXRD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Feb 2008 18:17:03 -0500
Received: by wf-out-1314.google.com with SMTP id 28so1744095wff.4
        for <linux-ide@vger.kernel.org>; Tue, 26 Feb 2008 15:16:54 -0800 (PST)
In-Reply-To: <200802262337.29873.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Borislav Petkov <petkovbb@googlemail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On 2/26/08, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
>
> On Tuesday 26 February 2008, Borislav Petkov wrote:
> > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > ---
> > drivers/ide/ide-cd.c | 634
> +++++++++++++++++++++++++------------------------
> > 1 files changed, 323 insertions(+), 311 deletions(-)
>
> With 300 lines changed this is not trivial to review/apply anymore
> (yeah, I sound like a broken record ;-) and since I've already applied
> Paolo's patch from two days ago this one heavily rejects...
>
> Moreover md5sum is different before/after the patch - I tried really hard
> to figure out why (by reverting some changes) but finally I gave up.

is it because of the changes in the include section?
and was the change suggested by checkpatch.pl?

ciao,
--
Paolo
http://paolo.ciarrocchi.googlepages.com/
