From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: support for drives larger than 2TiB
Date: Sat, 24 Jul 2010 20:22:47 -0300
Message-ID: <20100724232247.GA2129@khazad-dum.debian.net>
References: <4C4AB952.9030705@kernel.org>
 <SNT125-W4469FAC3FE110BB4882949C3A40@phx.gbl>
 <AANLkTi=-0Hdp2dfK_RB=w-W8Qm8O42dDM0ybEcRtEMdn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37412 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751408Ab0GXXWv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Jul 2010 19:22:51 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=-0Hdp2dfK_RB=w-W8Qm8O42dDM0ybEcRtEMdn@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Yuhong Bao <yuhongbao_386@hotmail.com>, tj@kernel.org, jeff@garzik.org, ben.collins@ubuntu.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 24 Jul 2010, Greg Freemyer wrote:
> Secondly, if you look at the table on the right of
> http://en.wikipedia.org/wiki/Master_boot_record#Disk_partitioning you
> see that the starting sector of a partition is defined with a 32-bit
> value.
> 
> ie. 2TB with 512 byte sectors.
> 
> The normal solution is to move to a GPT which requires EFI if you want
> to boot from it.

Can't one have a GPT with a guard boot sector which can read the real
partition table?

I think Tejun must mean some big problem at the BIOS APIs required for the
bootloader.  Tejun, what exactly croaks at the 2TB boundary (with 512KiB
sectors)?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
