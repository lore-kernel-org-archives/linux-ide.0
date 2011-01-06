From: Ben Dooks <ben@trinity.fluff.org>
Subject: Re: [PATCH v3 2/2] ahci_platform: add support for CNS3xxx SoC
	devices
Date: Thu, 6 Jan 2011 18:09:48 +0000
Message-ID: <20110106180948.GX27131@trinity.fluff.org>
References: <1294336393-920-1-git-send-email-mkl0301@gmail.com> <1294336393-920-3-git-send-email-mkl0301@gmail.com> <AANLkTinO-feQkpfoZhmOV7VyPbyL=f8KV1_Qysps04ve@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:48710 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368Ab1AFSJ6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Jan 2011 13:09:58 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinO-feQkpfoZhmOV7VyPbyL=f8KV1_Qysps04ve@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Mac <mkl0301@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, cbouatmailru@gmail.com, htejun@gmail.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

On Fri, Jan 07, 2011 at 02:04:33AM +0800, Lin Mac wrote:
> Hi Jeff,
> 
> 2011/1/7  <mkl0301@gmail.com>:
> > From: Mac Lin <mkl0301@gmail.com>
> >
> > CNS3xxx override the softreset function of ahci_platform ahci_softreset by
> > cns3xxx_ahci_softreset, which would retry ahci_do_softreset again with pmp=0 if
> > pmp=15 failed, for the controller has problem receiving D2H Reg FIS of the
> > different PMP setting of the previous sent H2D Reg FIS.
> >
> > Following describe the isssue with original ahci_platform driver on
> > linux-2.6.37-rc3, arm/cns3xxx.
> >
> > If CONFIG_SATA_PMP is enabled, while not using multiplier and connect the disks
> > directly to the board, the disk cannot be found due to software reset always

> complicated if more SoC-specific code added.
> I really prefer the original way.

Is there a reference to the original?

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.

