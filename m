From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 27/32] ide-tape: remove idetape_increase_max_pipeline_stages()
Date: Sun, 3 Feb 2008 01:07:24 +0100
Message-ID: <200802030107.24660.bzolnier@gmail.com>
References: <1201427300-3954-1-git-send-email-petkovbb@gmail.com> <1201427300-3954-22-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:55551 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935724AbYBCAAO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 19:00:14 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1482826fga.17
        for <linux-ide@vger.kernel.org>; Sat, 02 Feb 2008 16:00:12 -0800 (PST)
In-Reply-To: <1201427300-3954-22-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

On Sunday 27 January 2008, Borislav Petkov wrote:
> From: Borislav Petkov <bbpetkov@yahoo.de>
> 
> This function was being used only at one place so fold it in there.
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

This change is fine but depends on previous patches so I can't apply it.

Please move it at the beginning of the series and resubmit.

Thanks,
Bart
