From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Driver retries disk errors.
Date: Tue, 31 Aug 2004 16:13:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1093965233.599.8.camel@localhost.localdomain>
References: <20040830163931.GA4295@bitwizard.nl>
	 <1093952715.32684.12.camel@localhost.localdomain>
	 <20040831135403.GB2854@bitwizard.nl>
	 <1093961570.597.2.camel@localhost.localdomain>
	 <20040831155653.GD17261@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261239AbUHaQQB@vger.kernel.org>
In-Reply-To: <20040831155653.GD17261@harddisk-recovery.com>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Maw, 2004-08-31 at 16:56, Erik Mouw wrote:
> The SCSI disk driver has been doing a single retry for quite some time
> and it hasn't really bitten people. Why would the IDE disk driver be
> different? The only case I can imagine a retry would be OK, is when we
> get an UDMA CRC error (caused by bad cables).

Retries also pop up in other less obvious cases and conveniently paper
over a wide variety of timeouts, power management quirks and drives just
having a random fit. Eight is probably excessive in all cases.

For non hard disk cases many devices do want and need retry.

Alan
