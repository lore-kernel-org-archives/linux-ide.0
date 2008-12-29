From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] tx493[89]ide: Fix length for __ide_flush_dcache_range
Date: Mon, 29 Dec 2008 19:38:54 +0100
Message-ID: <200812291938.54435.bzolnier@gmail.com>
References: <1230215558-9197-2-git-send-email-anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:11785 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbYL2TCO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Dec 2008 14:02:14 -0500
Received: by mu-out-0910.google.com with SMTP id g7so1957285muf.1
        for <linux-ide@vger.kernel.org>; Mon, 29 Dec 2008 11:02:10 -0800 (PST)
In-Reply-To: <1230215558-9197-2-git-send-email-anemo@mba.ocn.ne.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-ide@vger.kernel.org, sshtylyov@ru.mvista.com, linux-mips@linux-mips.org, stable <stable@kernel.org>

On Thursday 25 December 2008, Atsushi Nemoto wrote:
> This fixes data corruption on PIO mode.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Cc: stable <stable@kernel.org>

applied
