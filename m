From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 01/10] ide: add ide_drive_t.dma flag
Date: Mon, 15 Sep 2008 19:51:46 +0200
Message-ID: <200809151951.47573.bzolnier@gmail.com>
References: <1221392158-3848-1-git-send-email-petkovbb@gmail.com> <1221392158-3848-2-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:6191 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbYIORwF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Sep 2008 13:52:05 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2255933rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 15 Sep 2008 10:52:04 -0700 (PDT)
In-Reply-To: <1221392158-3848-2-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Sunday 14 September 2008 13:35:49 Borislav Petkov wrote:
> This flag is to accomodate ide-cd functionality into ide atapi.
> 
> There should be no functionality change resulting from this patch.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied
