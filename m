From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 01/20] ata_piix: SITRE handling fix
Date: Tue, 8 Feb 2011 13:04:16 +0000
Message-ID: <20110208130416.675181fe@lxorguk.ukuu.org.uk>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
	<20110208122337.19110.8889.sendpatchset@linux-mhg7.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51428 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753572Ab1BHNAm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2011 08:00:42 -0500
In-Reply-To: <20110208122337.19110.8889.sendpatchset@linux-mhg7.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 08 Feb 2011 13:23:37 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> >From 7b6d27a9d65fef8795fdeee3733316450f840aa6 Mon Sep 17 00:00:00 2001
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Tue, 8 Feb 2011 12:39:24 +0100
> Subject: [PATCH 01/20] ata_piix: SITRE handling fix
> 
> Set SITRE bit also in master-only configurations.

Why ?
