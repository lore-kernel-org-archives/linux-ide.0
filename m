From: Mark Lord <liml@rtr.ca>
Subject: Re: regarding conversion to new EH
Date: Mon, 19 Jun 2006 18:45:03 -0400
Message-ID: <449728EF.3000004@rtr.ca>
References: <20060617113104.GC11755@htj.dyndns.org> <4493EF61.9060103@pobox.com> <449412FD.8030102@pobox.com> <4494BB5F.6030108@gmail.com> <44971421.1070206@pobox.com> <449715CA.1030902@pobox.com> <44972018.4040901@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:36256 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964962AbWFSWpF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jun 2006 18:45:05 -0400
In-Reply-To: <44972018.4040901@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>

Mark Lord wrote:
>
> The pdc_adma driver works fine in all versions including 2.6.17 on my P4 
> box.
> I wonder why it's fussy on the AMD64 machine.. ?
> 
> Sigh.. yet another time sink to play with.  ;)

Mmmmmm.. something strange there.  It fails with both 64-bit and 32-bit kernels.
Its twin sister, the sata_qstor driver, works just fine.

Oh well.

Maybe it's a VIA chipset IRQ routing issue or something.

Cheers
