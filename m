From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] [IDE] Add VIA VX855 PCI Device ID
Date: Fri, 22 May 2009 17:19:48 +0200
Message-ID: <200905221719.48657.bzolnier@gmail.com>
References: <20090517061639.GG4909@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:54259 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757271AbZEVPPK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 May 2009 11:15:10 -0400
Received: by fxm2 with SMTP id 2so1721599fxm.37
        for <linux-ide@vger.kernel.org>; Fri, 22 May 2009 08:15:10 -0700 (PDT)
In-Reply-To: <20090517061639.GG4909@prithivi.gnumonks.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harald Welte <HaraldWelte@viatech.com>
Cc: linux-ide@vger.kernel.org, Joseph Chan <JosephChan@via.com.tw>, Bruce Chang <BruceChang@via.com.tw>

On Sunday 17 May 2009 08:16:39 Harald Welte wrote:
> This patch adds the PCI Device ID 0xc409 to the PCI ID table of via82cxxx.c,
> as well as the 0x8409 south bridge ID.
> 
> This is required to make the IDE driver work on the VX855/VX875 integrated
> chipset.
> 
> Signed-off-by: Harald Welte <HaraldWelte@viatech.com>

applied
