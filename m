From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] IDE: compile fix for sff_dma_ops
Date: Mon, 25 Aug 2008 20:37:21 +0200
Message-ID: <200808252037.21343.bzolnier@gmail.com>
References: <1219353824-31246-1-git-send-email-khilman@deeprootsystems.com> <48ADFA27.2070002@ru.mvista.com> <87y72q6i88.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:54755 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997AbYHYUcD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Aug 2008 16:32:03 -0400
Received: by yx-out-2324.google.com with SMTP id 8so960515yxm.1
        for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2008 13:32:02 -0700 (PDT)
In-Reply-To: <87y72q6i88.fsf@deeprootsystems.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Friday 22 August 2008, Kevin Hilman wrote:

[...]

> Sigh, OK, here's one that actually applies.  Sorry.
> 
> Kevin
> 
> From c453ee79a240a9104191e245655ff975c175edcd Mon Sep 17 00:00:00 2001
> From: Kevin Hilman <khilman@deeprootsystems.com>
> Date: Thu, 21 Aug 2008 10:31:44 -0700
> Subject: [PATCH] IDE: compile fix for sff_dma_ops
> 
> The sff_dma_ops struct should be wrapped by BLK_DEV_IDEDMA_SFF instead
> of BLK_DEV_IDEDMA_PCI.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

applied
