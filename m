From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/3] Various IDE coding style fixes
Date: Tue, 26 Feb 2008 23:25:06 +0100
Message-ID: <200802262325.06886.bzolnier@gmail.com>
References: <20080224220932.4098443e@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:28276 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764931AbYBZWXm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Feb 2008 17:23:42 -0500
Received: by ug-out-1314.google.com with SMTP id z38so46418ugc.16
        for <linux-ide@vger.kernel.org>; Tue, 26 Feb 2008 14:23:41 -0800 (PST)
In-Reply-To: <20080224220932.4098443e@paolo-desktop>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Borislav Petkov <petkovbb@gmail.com>

On Sunday 24 February 2008, Paolo Ciarrocchi wrote:
> Hi Bart,
> three more patches, all are compile tested and against yesterday linux-next
> 
> "IDE: Replace __FUNCTION__ with __func__" depends 
> on "IDE: Coding Style fixes to drivers/ide/ide-cd.c"
> 
> 
> Paolo Ciarrocchi (3):
>       IDE: Coding Style fixes to drivers/ide/ide-cd.c
>       IDE: Replace __FUNCTION__ with __func__
>       IDE: Coding Style fixes to drivers/ide/pci/cy82c693.c
> 
>  drivers/ide/ide-cd.c       |  259 +++++++++++++++++++++++---------------------
>  drivers/ide/pci/cy82c693.c |   74 +++++++-------
>  2 files changed, 171 insertions(+), 162 deletions(-)

all patches applied (+md5sum checked)
