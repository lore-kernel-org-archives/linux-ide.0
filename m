From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 1/1] ata: remove FIT() macro
Date: Mon, 19 May 2008 17:42:34 -0400
Message-ID: <4831F44A.7090803@garzik.org>
References: <200805142317.m4ENH0fO026450@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38594 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762932AbYESVmg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 May 2008 17:42:36 -0400
In-Reply-To: <200805142317.m4ENH0fO026450@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, harvey.harrison@gmail.com, htejun@gmail.com

akpm@linux-foundation.org wrote:
> From: Harvey Harrison <harvey.harrison@gmail.com>
> 
> Use the kernel-provided clamp_val() macro.
> 
> FIT was always applied to a member of struct ata_timing (unsigned short)
> and two constants.  clamp_val will not cast to short anymore.
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Tejun Heo <htejun@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/pata_ali.c     |   10 +++----
>  drivers/ata/pata_amd.c     |   14 ++++-----
>  drivers/ata/pata_cypress.c |    8 ++---
>  drivers/ata/pata_legacy.c  |   50 +++++++++++++++++------------------
>  drivers/ata/pata_ns87410.c |    6 ++--
>  drivers/ata/pata_ns87415.c |    4 +-
>  drivers/ata/pata_qdi.c     |   16 +++++------
>  drivers/ata/pata_via.c     |   14 ++++-----
>  drivers/ata/pata_winbond.c |    6 ++--
>  include/linux/libata.h     |    2 -
>  10 files changed, 64 insertions(+), 66 deletions(-)

applied


