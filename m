From: Erik Andersen <andersen@codepoet.org>
Subject: Re: [PATCH] prevent module unloading for legacy IDE chipset drivers
Date: Wed, 21 Apr 2004 18:41:04 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040422004104.GA19969@codepoet.org>
References: <200404212219.24622.bzolnier@elka.pw.edu.pl>
Reply-To: andersen@codepoet.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from codepoet.org ([166.70.99.138]:27060 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S263752AbUDVAlE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Apr 2004 20:41:04 -0400
Content-Disposition: inline
In-Reply-To: <200404212219.24622.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed Apr 21, 2004 at 10:19:24PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> It is unsafe thing to do (no locking, no reference counting etc).
> Just remove module_exit() as it was done for IDE PCI drivers.

Out of curiosity, what would be needed to make it safe to unload
all ide modules from a system with a scsi rootfs?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
