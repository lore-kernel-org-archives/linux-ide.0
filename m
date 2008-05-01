From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata sata_via unusual behaviour
Date: Thu, 1 May 2008 19:58:23 +0100
Message-ID: <20080501195823.79786815@core>
References: <3bbeafe90805011018o28f46794h369242ccb02b7ced@mail.gmail.com>
	<3bbeafe90805011158n5b45283awd43a7a534ba11456@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50507 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1764345AbYEATGu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 May 2008 15:06:50 -0400
In-Reply-To: <3bbeafe90805011158n5b45283awd43a7a534ba11456@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paolo <paoletto@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Thu, 1 May 2008 20:58:37 +0200
Paolo <paoletto@gmail.com> wrote:

> Hello!
> 
>  It seems that me and many others are experiencing poor sata performances
>  in the last months, probably with 2.6.20+ kernels.
> 
>  an example of these problems is here:
> 
>  http://ubuntuforums.org/showthread.php?p=4845777
> 
>  unfortunately it seems that sata subsystem on linux is little to none
>  tweakable

It doesn't normally need tweaking, and the hdparm numbers show that it is
working correctly in the example you give. There may be problems higher
up the stack but the ATA layer appears to be doing just fine.

Perhaps the Ubuntu engineers could be persuaded to profile their problem
systems and identify what is causing the slow down - LVM certain has been
problematic for some setups if LVM is in use.

Alan
