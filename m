From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] ahci: Enable SB600 64bit DMA on Asus M3A
Date: Mon, 27 Jun 2011 10:14:01 +0200
Message-ID: <20110627081401.GZ30101@htj.dyndns.org>
References: <BANLkTimcLiba=7E4vp-_VyhNWM8_EGzTFg@mail.gmail.com>
 <BANLkTimMU+t4iFA=w-bbcCjAxTXtHn_n5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36684 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757108Ab1F0IOG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jun 2011 04:14:06 -0400
Received: by bwd5 with SMTP id 5so1042174bwd.19
        for <linux-ide@vger.kernel.org>; Mon, 27 Jun 2011 01:14:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTimMU+t4iFA=w-bbcCjAxTXtHn_n5A@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Nelson <mdnelson8@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Mon, Jun 27, 2011 at 04:33:44PM +1000, Mark Nelson wrote:
> Like e65cc194f7628ecaa02462f22f42fb09b50dcd49 this patch enables 64bit DMA
> for the AHCI SATA controller of a board that has the SB600 southbridge. In
> this case though we're enabling 64bit DMA for the Asus M3A motherboard. It
> is a new enough board that all of the BIOS releases since the initial
> release (0301 from 2007-10-22) work correctly with 64bit DMA enabled.
> 
> Signed-off-by: Mark Nelson <mdnelson8@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thank you very much.

-- 
tejun
