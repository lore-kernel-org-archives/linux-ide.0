From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] prevent module unloading for legacy IDE chipset drivers
Date: Thu, 22 Apr 2004 02:50:15 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404220250.15078.bzolnier@elka.pw.edu.pl>
References: <200404212219.24622.bzolnier@elka.pw.edu.pl> <20040422004104.GA19969@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:15540 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263429AbUDVAuu
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Apr 2004 20:50:50 -0400
In-Reply-To: <20040422004104.GA19969@codepoet.org>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: andersen@codepoet.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 22 of April 2004 02:41, Erik Andersen wrote:
> On Wed Apr 21, 2004 at 10:19:24PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > It is unsafe thing to do (no locking, no reference counting etc).
> > Just remove module_exit() as it was done for IDE PCI drivers.
>
> Out of curiosity, what would be needed to make it safe to unload
> all ide modules from a system with a scsi rootfs?

It doesn't matter - you still may end up unloading modules which are in use.
Plus unregistering IDE interfaces leave mess in _static_ ide_hwifs[] table.

