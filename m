From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 08/10] IDE: Coding Style fixes to drivers/ide/pci/generic.c
Date: Tue, 26 Feb 2008 22:22:44 +0100
Message-ID: <200802262222.44162.bzolnier@gmail.com>
References: <20080223150547.5256e734@paolo-desktop> <20080223142909.GD6747@cvg> <4d8e3fd30802230637h3c16e1bm4d99341c9cc8d70c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:27382 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764662AbYBZWXh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Feb 2008 17:23:37 -0500
Received: by ug-out-1314.google.com with SMTP id z38so46399ugc.16
        for <linux-ide@vger.kernel.org>; Tue, 26 Feb 2008 14:23:37 -0800 (PST)
In-Reply-To: <4d8e3fd30802230637h3c16e1bm4d99341c9cc8d70c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

On Saturday 23 February 2008, Paolo Ciarrocchi wrote:
> > | -/**
> > | +/*
> > ^^^^^^^
> >
> > Hi Paolo, it seems you just broke kdoc structure
> 
> thank you for your comment, i didn't know that.
> Won't happen in future patches.
> Bart, can you fix that or do you want me to re-create the series?

I fixed this issue in all patches while merging them.

Thanks,
Bart
