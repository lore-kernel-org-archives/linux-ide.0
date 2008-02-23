From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [PATCH 08/10] IDE: Coding Style fixes to
	drivers/ide/pci/generic.c
Date: Sat, 23 Feb 2008 17:39:07 +0300
Message-ID: <20080223143907.GE6747@cvg>
References: <20080223150547.5256e734@paolo-desktop> <20080223142909.GD6747@cvg> <4d8e3fd30802230637h3c16e1bm4d99341c9cc8d70c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:12949 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbYBWOjf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Feb 2008 09:39:35 -0500
Received: by py-out-1112.google.com with SMTP id u52so1359203pyb.10
        for <linux-ide@vger.kernel.org>; Sat, 23 Feb 2008 06:39:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4d8e3fd30802230637h3c16e1bm4d99341c9cc8d70c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

[Paolo Ciarrocchi - Sat, Feb 23, 2008 at 06:07:01PM +0330]
| > | -/**
| > | +/*
| > ^^^^^^^
| >
| > Hi Paolo, it seems you just broke kdoc structure
| 
| thank you for your comment, i didn't know that.
| Won't happen in future patches.

no problem ;)

| Bart, can you fix that or do you want me to re-create the series?
| 
| Ciao,
| --
| Paolo
| http://paolo.ciarrocchi.googlepages.com/
| 
		- Cyrill -
