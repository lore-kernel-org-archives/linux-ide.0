From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: [PATCH] prevent module unloading for legacy IDE chipset drivers
Date: Thu, 22 Apr 2004 12:33:55 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040422103355.GC15176@harddisk-recovery.com>
References: <200404212219.24622.bzolnier@elka.pw.edu.pl> <20040422004104.GA19969@codepoet.org> <200404220250.15078.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from users.linvision.com ([62.58.92.114]:58326 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S263918AbUDVKd5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Apr 2004 06:33:57 -0400
Content-Disposition: inline
In-Reply-To: <200404220250.15078.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: andersen@codepoet.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 02:50:15AM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 22 of April 2004 02:41, Erik Andersen wrote:
> > Out of curiosity, what would be needed to make it safe to unload
> > all ide modules from a system with a scsi rootfs?
> 
> It doesn't matter - you still may end up unloading modules which are in use.

FWIW, with the old IDE code I've been unloading IDE modules for years
without a single problem.

What makes IDE sufficiently different from SCSI that we can't unload
IDE host drivers?


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
