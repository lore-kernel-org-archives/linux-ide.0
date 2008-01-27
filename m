From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 25/32] ide-tape: simplify code branching in the interrupt handler
Date: Sun, 27 Jan 2008 20:42:11 +0100
Message-ID: <200801272042.12112.bzolnier@gmail.com>
References: <1201427300-3954-1-git-send-email-petkovbb@gmail.com> <1201427300-3954-20-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:9355 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756462AbYA0Tc0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 14:32:26 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1431369fga.17
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 11:32:26 -0800 (PST)
In-Reply-To: <1201427300-3954-20-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

On Sunday 27 January 2008, Borislav Petkov wrote:
> From: Borislav Petkov <bbpetkov@yahoo.de>
> 
> ... by adding a new typedef function pointer idetape_io_buf in order to call
> the proper buffer i/o handler depending on the data direction.
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> ---
>  drivers/ide/ide-tape.c |   54 +++++++++++++++++++++++++----------------------
>  1 files changed, 29 insertions(+), 25 deletions(-)

[...]

> +typedef void idetape_io_buf(ide_drive_t *, idetape_pc_t *, uint);

'uint' -> 'unsigned int'

[...]

Otherwise this patch is fine but depends on other patches needing rework
(please move it near the beginning of the series).

Thanks,
Bart
