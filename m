From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: IDE Hotswap
Date: Tue, 28 Sep 2004 23:38:10 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200409282338.10456.bzolnier@elka.pw.edu.pl>
References: <8CCBDD5583C50E4196F012E79439B45C069657DB@atl-ms1.megatrends.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:7902 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268024AbUI1ViK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Sep 2004 17:38:10 -0400
In-Reply-To: <8CCBDD5583C50E4196F012E79439B45C069657DB@atl-ms1.megatrends.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Suresh Grandhi <Sureshg@ami.com>
Cc: "'linux-ide@vger.kernel.org'" <linux-ide@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>


On Tuesday 28 September 2004 20:49, Suresh Grandhi wrote:
> Hi,
> My hardware has IDE hotswap support. I like to implement the hotswap driver
> over 2.6.8 kernel.
> Right now I am able to register and unregister the IDE devices successfully
> if they are not part of any raid or LVM.
> If I/O operation is going on the disk, then IDE unregister fails generating
> lot of I/O error messages.
> In this case, I want to make a work-around. 
> Instead of unregistering the IDE device, is there a way to re-register the
> IDE device with the already existing ports and irq when the disk is
> inserted?

No and such workaround won't work anyway because
re-register operation is nothing else but unregister+register.

hotswap is currently unsupported, some TODO items:
- convert IDE driver to use dynamic objects instead of static ones
- add needed refcounting and locking
- convert IDE driver to new driver-model
- add full sysfs support
- add hotswap

Any help/support is appreciated.

Regards,
Bartlomiej
