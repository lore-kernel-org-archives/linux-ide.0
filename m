From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] tx4939ide: typo fix and minor cleanup
Date: Sat, 24 Jan 2009 15:10:01 +0100
Message-ID: <200901241510.01660.bzolnier@gmail.com>
References: <1232374225-5325-1-git-send-email-anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:60525 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbZAXOVR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Jan 2009 09:21:17 -0500
Received: by fxm13 with SMTP id 13so1252668fxm.13
        for <linux-ide@vger.kernel.org>; Sat, 24 Jan 2009 06:21:14 -0800 (PST)
In-Reply-To: <1232374225-5325-1-git-send-email-anemo@mba.ocn.ne.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-ide@vger.kernel.org, sshtylyov@ru.mvista.com, linux-mips@linux-mips.org

On Monday 19 January 2009, Atsushi Nemoto wrote:
> The bcount is greater than 0 and less than or equal to 0x10000.
> Thus '(bcount & 0xffff) == 0x0000' can be simplified as 'bcount == 0x10000'.
> 
> Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

applied
