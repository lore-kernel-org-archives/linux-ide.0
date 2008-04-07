From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/6] ide-tape: refit tape data buffer bits/kill pipelining-v2
Date: Mon, 7 Apr 2008 23:11:12 +0200
Message-ID: <200804072311.12947.bzolnier@gmail.com>
References: <1207543504-27888-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:33406 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbYDGU4Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Apr 2008 16:56:16 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2217967fkr.5
        for <linux-ide@vger.kernel.org>; Mon, 07 Apr 2008 13:56:14 -0700 (PDT)
In-Reply-To: <1207543504-27888-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>


Hi,

On Monday 07 April 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> here's another patchset that contains some other fixes along with the changes
> you suggested. We have now a tape->merge_bh buffer which is a singly linked list
> of bh's and tape->bh is a pointer within that list. The remaining pipelining
> functions have been readjusted to handle the merge buffer. I guess, that was it,
> pipelining is gone.
> 
>  drivers/ide/ide-tape.c |  215 ++++++++++++++++++++++--------------------------
>  1 files changed, 99 insertions(+), 116 deletions(-)

I applied all 6 patches, thanks!

Bart
