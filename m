From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 5/6] ide-cd: move cdrom_timer_expiry to ide-atapi.c
Date: Sun, 7 Dec 2008 14:56:39 +0100
Message-ID: <200812071456.39288.bzolnier@gmail.com>
References: <1228373010-20249-1-git-send-email-petkovbb@gmail.com> <200812061551.24745.bzolnier@gmail.com> <20081206200316.GB13838@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:61584 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939AbYLGOBE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Dec 2008 09:01:04 -0500
Received: by mu-out-0910.google.com with SMTP id g7so726283muf.1
        for <linux-ide@vger.kernel.org>; Sun, 07 Dec 2008 06:01:02 -0800 (PST)
In-Reply-To: <20081206200316.GB13838@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

On Saturday 06 December 2008, Borislav Petkov wrote:

> here is a v2:
> ---
> From: Borislav Petkov <petkovbb@gmail.com>
> Date: Sat, 6 Dec 2008 20:08:35 +0100
> Subject: [PATCH] ide-cd: move cdrom_timer_expiry to ide-atapi.c
> 
> - cdrom_timer_expiry -> ide_cd_expiry
> - remove expiry-arg to ide_issue_pc as it is redundant now
> - ide_debug_log -> debug_log
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied, thanks
