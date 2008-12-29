From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] tx4939ide: Do not use zero count PRD entry
Date: Mon, 29 Dec 2008 19:38:14 +0100
Message-ID: <200812291938.14580.bzolnier@gmail.com>
References: <1230215558-9197-1-git-send-email-anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:42379 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbYL2TCI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Dec 2008 14:02:08 -0500
Received: by fxm13 with SMTP id 13so1033316fxm.13
        for <linux-ide@vger.kernel.org>; Mon, 29 Dec 2008 11:02:06 -0800 (PST)
In-Reply-To: <1230215558-9197-1-git-send-email-anemo@mba.ocn.ne.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-ide@vger.kernel.org, sshtylyov@ru.mvista.com, linux-mips@linux-mips.org, stable <stable@kernel.org>

On Thursday 25 December 2008, Atsushi Nemoto wrote:
> This fixes data corruption on some heavy load.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Cc: stable <stable@kernel.org>

applied
