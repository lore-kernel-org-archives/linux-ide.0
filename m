From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] scc_pata.c: do setup itself instead of ide_setup_pci_device ()
Date: Tue, 15 Apr 2008 22:39:17 +0200
Message-ID: <200804152239.17249.bzolnier@gmail.com>
References: <200804150314.m3F3EDv9026609@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:30258 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761539AbYDOVTs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2008 17:19:48 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2140239fgb.17
        for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2008 14:19:47 -0700 (PDT)
In-Reply-To: <200804150314.m3F3EDv9026609@toshiba.co.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: sshtylyov@ru.mvista.com, kou.ishizaki@toshiba.co.jp, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On Tuesday 15 April 2008, Akira Iguchi wrote:
> scc_pata has the different BAR configuration and using ide_setup_pci_device()
> is inappropriate. 
> (ide_setup_pci_device() expects a normal PCI IDE controller with
> BAR0..BAR3 either non-existant or being primary/secondary port bases
> in I/O space.)
> 
> This patch do all needed setup itself instead of calling ide_setup_pci_device().
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>

Thanks for quickly handling it, applied.
