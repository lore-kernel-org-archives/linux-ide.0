From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] ide-tape: move all struct and other defs at the top
Date: Mon, 11 Feb 2008 23:12:53 +0100
Message-ID: <200802112312.53174.bzolnier@gmail.com>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com> <200802091725.29207.bzolnier@gmail.com> <20080209194247.GE23177@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:44876 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbYBLAM7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 19:12:59 -0500
Received: by fk-out-0910.google.com with SMTP id z23so4714640fkz.5
        for <linux-ide@vger.kernel.org>; Mon, 11 Feb 2008 16:12:57 -0800 (PST)
In-Reply-To: <20080209194247.GE23177@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


On Saturday 09 February 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> thanks for the update earlier. I'll look into blk_{get,put}_request later and
> try it on idefloppy. In the meantime, here are the patches as requested:

Thanks.

> ---
> From 0d91862fc802d6f5aa79947b2685de6c209236f2 Mon Sep 17 00:00:00 2001
> From: Borislav Petkov <petkovbb@gmail.com>
> Date: Sat, 9 Feb 2008 19:48:13 +0100
> Subject: [PATCH 1/2] ide-tape: move all struct and other defs at the top
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied

> ---
>  drivers/ide/ide-tape.c |  107 ++++++++++++++++++++++++-----------------------
>  1 files changed, 55 insertions(+), 52 deletions(-)

since there is no need to move defines for tape flags around (as they are
completely rewritten by the next patch) I removed this change from this patch
making it a bit simpler/smaller:

 drivers/ide/ide-tape.c |   74 ++++++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)
