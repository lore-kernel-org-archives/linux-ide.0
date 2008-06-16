From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] palm_bk3710: fix resource management
Date: Mon, 16 Jun 2008 21:34:10 +0200
Message-ID: <200806162134.10579.bzolnier@gmail.com>
References: <200806162220.35499.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:55735 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbYFPTck (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jun 2008 15:32:40 -0400
Received: by yw-out-2324.google.com with SMTP id 9so3199482ywe.1
        for <linux-ide@vger.kernel.org>; Mon, 16 Jun 2008 12:32:35 -0700 (PDT)
In-Reply-To: <200806162220.35499.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Monday 16 June 2008, Sergei Shtylyov wrote:
> The driver expected a *virtual* address in the IDE platform device's memory
> resource and didn't request the memory region for the register block. Fix this
> taking into account the fact that DaVinci SoC devices are fixed-mapped to the
> virtual memory early and we can get their virtual addresses using IO_ADDRESS()
> macro, not having to call ioremap()...
> 
> While at it, also do some cosmetic changes...
> 
> ---
> The patch is against the recent Linus' tree.

looks OK but please S-o-b it
