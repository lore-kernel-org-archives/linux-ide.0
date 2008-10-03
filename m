From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide-dma: fix ide_build_dmatable() for TRM290
Date: Fri, 3 Oct 2008 18:50:28 +0200
Message-ID: <200810031850.28945.bzolnier@gmail.com>
References: <200809282241.26289.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.191]:31658 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213AbYJCRnb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Oct 2008 13:43:31 -0400
Received: by gv-out-0910.google.com with SMTP id e6so296255gvc.37
        for <linux-ide@vger.kernel.org>; Fri, 03 Oct 2008 10:43:31 -0700 (PDT)
In-Reply-To: <200809282241.26289.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Sunday 28 September 2008, Sergei Shtylylov wrote:
> Apparently, 'xcount' being 0 does not mean 0 bytes for TRM290; it means 4 bytes,
> judging from the code immediately preceding this check.  So, we must never try
> to "split" the PRD for TRM290.
> 
> This is probably never hit anyway -- with the DMA buffers aligned to at least
> 512 bytes and ATAPI DMA not being used for non block I/O commands...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied, thanks
