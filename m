From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] ide-scsi: do non-atomic pc->flags testing
Date: Wed, 13 Feb 2008 22:44:50 +0100
Message-ID: <200802132244.50487.bzolnier@gmail.com>
References: <1202923544-19551-1-git-send-email-petkovbb@gmail.com> <1202923544-19551-2-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:17139 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933368AbYBMVu4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 16:50:56 -0500
Received: by nf-out-0910.google.com with SMTP id g13so106705nfb.21
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 13:50:55 -0800 (PST)
In-Reply-To: <1202923544-19551-2-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Wednesday 13 February 2008, Borislav Petkov wrote:
> ...also, convert ide-scsi to using the generic pc->flags defines.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied
