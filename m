From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Driver retries disk errors.
Date: Tue, 31 Aug 2004 12:45:15 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1093952715.32684.12.camel@localhost.localdomain>
References: <20040830163931.GA4295@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from the-village.bc.nu ([81.2.110.252]:10119 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268215AbUHaMrS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Aug 2004 08:47:18 -0400
In-Reply-To: <20040830163931.GA4295@bitwizard.nl>
List-Id: linux-ide@vger.kernel.org
To: Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Llu, 2004-08-30 at 17:39, Rogier Wolff wrote:
> We encounter "bad" drives with quite a lot more regularity than other
> people (look at the Email address). We're however, wondering why the
> IDE code still retries a bad block 8 times? By the time the drive
> reports "bad block" it has already tried it several times, including a
> bunch of "recalibrates" etc etc. For comparison, the Scsi-disk driver
> doesn't do any retrying.

It helps for some things like magneto-opticals. For generic hard drives
its only relevant for older devices.

> (*) Note: Tested last month: The driver still works for MFM
> drives. However, the initialization apparently is not enough
> anymore. The drive did not work when the BIOS didn't think there was a
> drive.

Please file a bug report if 2.6 also shows that problem.

