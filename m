From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 24/32] ide-tape: remove unreachable code chunk
Date: Sun, 27 Jan 2008 20:41:52 +0100
Message-ID: <200801272041.52818.bzolnier@gmail.com>
References: <1201427300-3954-1-git-send-email-petkovbb@gmail.com> <1201427300-3954-19-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:9447 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756311AbYA0TcZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 14:32:25 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1431435fga.17
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 11:32:24 -0800 (PST)
In-Reply-To: <1201427300-3954-19-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

On Sunday 27 January 2008, Borislav Petkov wrote:
> From: Borislav Petkov <bbpetkov@yahoo.de>
> 
> tape->speed_ctl is set to 1 in idetape_setup(), but, in calculate_speeds() its
> value is tested for being 0, 1, or 2. Remove the if-branches where
> tape->speed_ctl != 1 since they are never executed.
> 
> Also, rename calculate_speeds() by adding driver's prefix as is with the other
> function names.
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

This change is fine but it seems to depend on "ghost" patch #23. ;)

Please move it near the beginning of the series when resubmitting.

Thanks,
Bart
