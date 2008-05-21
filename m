From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-sff: Fix oops reported in kerneloops.org for pnp
 devices with no ctl
Date: Wed, 21 May 2008 13:23:26 +0900
Message-ID: <4833A3BE.2070107@gmail.com>
References: <20080520145031.13437.90254.stgit@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:21420 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbYEUEXc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 May 2008 00:23:32 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2384904rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 20 May 2008 21:23:32 -0700 (PDT)
In-Reply-To: <20080520145031.13437.90254.stgit@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, akpm@osdl.org

Alan Cox wrote:
> This fixes most common oops #5 on Arjan's kerneloops.org site
> 
> Not all controllers have ctl/altstatus. In particular many ISAPnP controllers
> omit them. While libata should handle this it generally only got the ctl port
> (the write side) correct.
> 
> Functions
> - ata_sff_maybe_altstatus - this uses the status if altstatus is not available.
>   In the longer term I believe each use of it is in fact removable but don't
>   want to perturb anything during the -rc releases
> - ata_sff_pause - don't use altstatus I/O for fencing if we don't have one
> - ata_sff_sync - add a fencing call so we can distinguish fencing from real
> 		 altstatus usage. All non ctl/altstatus controllers are PIO
> 		 so do not need a fence
> 
> Code wise we then use maybe_altstatus in the IRQ path (where we should only
> check status and the current code is actually I think buggy), and for DMA
> completion (no non ctl/altstatus controller does DMA but need to finish
> verifying the calling cases).
> 
> This has been tested with ctl/altstatus faked to be unavailable on controllers
> I have and works. You get some spew about failed identify but that is another
> issue that can be fixed later and it does all work. Also the spew only occurs
> on controllers that currently just go wrong.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
