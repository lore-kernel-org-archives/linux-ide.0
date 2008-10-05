From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-cd: Optiarc DVD RW AD-7200A does play audio
Date: Sun, 5 Oct 2008 18:04:27 +0200
Message-ID: <200810051804.28970.bzolnier@gmail.com>
References: <bjbMi-2A6-1@gated-at.bofh.it> <alpine.LSU.0.999.0810041617310.6007@be1.lrz> <20081004145708.GA21152@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:11645 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757578AbYJEQli (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Oct 2008 12:41:38 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1869930fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 05 Oct 2008 09:41:36 -0700 (PDT)
In-Reply-To: <20081004145708.GA21152@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Bodo Eggert <7eggert@gmx.de>, Nick Warne <nick@ukfsn.org>, linux-ide@vger.kernel.org

On Saturday 04 October 2008, Borislav Petkov wrote:
> On Sat, Oct 04, 2008 at 04:27:25PM +0200, Bodo Eggert wrote:
> > The Optiarc DVD RW AD-7200A can play audio, but tells it could not.
> > 
> > Signed-Off-By: Bodo Eggert <7eggert@gmx.de>
> > Test-by: Nick Warne <nick@ukfsn.org>
> > X-Kernel-Version: 2.6.26
> 
> This one doesn't apply cleanly since it is against 2.6.26. Here's a current
> version ontop of pata-tree:
> 
> --
> From: Bodo Eggert <7eggert@gmx.de>
> Subject: [PATCH] ide-cd: Optiarc DVD RW AD-7200A does play audio
> 
> The Optiarc DVD RW AD-7200A can play audio, but tells it could not.
> 
> Signed-Off-By: Bodo Eggert <7eggert@gmx.de>
> Tested-by: Nick Warne <nick@ukfsn.org>

thanks, applied

> ---
>  drivers/ide/ide-cd.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index 63eada0..db87fab 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -1965,6 +1965,7 @@ static const struct cd_list_entry ide_cd_quirks_list[] = {
>  	{ "MATSHITADVD-ROM SR-8174", NULL,   IDE_AFLAG_PLAY_AUDIO_OK	     },
>  	{ "Optiarc DVD RW AD-5200A", NULL,   IDE_AFLAG_PLAY_AUDIO_OK	     },
>  	{ "Optiarc DVD RW AD-7543A", NULL,   IDE_AFLAG_NO_AUTOCLOSE	     },
> +	{ "Optiarc DVD RW AD-7200A", NULL,   IDE_AFLAG_PLAY_AUDIO_OK	     },

I moved this one line up to keep "audio" quirks together.
