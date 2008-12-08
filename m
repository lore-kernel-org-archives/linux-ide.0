From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/4] ide: remove ide-scsi remnants
Date: Mon, 8 Dec 2008 18:33:00 +0100
Message-ID: <200812081833.00406.bzolnier@gmail.com>
References: <1228670471-3435-1-git-send-email-petkovbb@gmail.com> <20081207184316.GA30260@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:11983 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbYLHReJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Dec 2008 12:34:09 -0500
Received: by yx-out-2324.google.com with SMTP id 8so496028yxm.1
        for <linux-ide@vger.kernel.org>; Mon, 08 Dec 2008 09:34:08 -0800 (PST)
In-Reply-To: <20081207184316.GA30260@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sunday 07 December 2008, Borislav Petkov wrote:
> On Sun, Dec 07, 2008 at 06:21:07PM +0100, Borislav Petkov wrote:
> > Hi Bart,
> > 
> > here are the patches removing bits and pieces belonging to the late ide-scsi :).
> > 
> 
> here's the correct (and not reversed :)) diffstat though:
> 
>  drivers/ide/ide-atapi.c  |   97 +++++++++-------------------------------------
>  drivers/ide/ide-io.c     |    3 -
>  drivers/ide/ide-ioctls.c |    3 +-
>  drivers/ide/ide-probe.c  |    2 -
>  include/linux/ide.h      |   34 ++++++----------
>  5 files changed, 33 insertions(+), 106 deletions(-)

Thanks, applied (though you could have combined all patches into
single one -- it is one logical change after all).

Bart
