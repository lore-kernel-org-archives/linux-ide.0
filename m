From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH 08/10] IDE: Coding Style fixes to drivers/ide/pci/generic.c
Date: Sat, 23 Feb 2008 18:07:01 +0330
Message-ID: <4d8e3fd30802230637h3c16e1bm4d99341c9cc8d70c@mail.gmail.com>
References: <20080223150547.5256e734@paolo-desktop> <20080223142909.GD6747@cvg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.176]:22109 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754300AbYBWOhD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Feb 2008 09:37:03 -0500
Received: by el-out-1112.google.com with SMTP id v27so640325ele.23
        for <linux-ide@vger.kernel.org>; Sat, 23 Feb 2008 06:37:02 -0800 (PST)
In-Reply-To: <20080223142909.GD6747@cvg>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

> | -/**
> | +/*
> ^^^^^^^
>
> Hi Paolo, it seems you just broke kdoc structure

thank you for your comment, i didn't know that.
Won't happen in future patches.
Bart, can you fix that or do you want me to re-create the series?

Ciao,
--
Paolo
http://paolo.ciarrocchi.googlepages.com/
