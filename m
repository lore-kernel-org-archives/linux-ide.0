From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/2] ide: clear bmdma status in ide_intr for Intel controllers
 (revised #4)
Date: Fri, 02 Feb 2007 22:14:56 +0100
Message-ID: <45C3A9D0.80805@gmail.com>
References: <45AF57BE.7060505@tw.ibm.com> <45B7596F.6080504@ru.mvista.com>	 <45B878F0.7060707@tw.ibm.com> <45B8CA02.4050701@ru.mvista.com>	 <45B8DD84.3090700@ru.mvista.com> <45BEB242.7070506@tw.ibm.com>	 <45BEB52B.4070307@tw.ibm.com>	 <58cb370e0701301117n316a9efax1e0b6299a8f8594a@mail.gmail.com>	 <45BFA8B6.9010902@gmail.com> <45C02DD1.7040907@tw.ibm.com> <58cb370e0702021307i3d275e84qbeb3b44f58ad6b51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:53735 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946080AbXBBVKK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 16:10:10 -0500
Received: by ug-out-1314.google.com with SMTP id 44so872008uga
        for <linux-ide@vger.kernel.org>; Fri, 02 Feb 2007 13:10:07 -0800 (PST)
In-Reply-To: <58cb370e0702021307i3d275e84qbeb3b44f58ad6b51@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, "Adam W. Hawks" <awhawks@us.ibm.com>


Albert Lee wrote:
> patch 1/2: clear bmdma status in ide_intr() and add a new hwif->ide_dma_clear_irq for piix.c to use.
> patch 2/2: remove clearing bmdma status from cdrom_decode_status() since ATA devices might need it as well.

applied both patches, thanks


