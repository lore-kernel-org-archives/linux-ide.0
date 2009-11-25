From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 45/86] pata_legacy: do not probe extra ports
 automatically if PCI is not present
Date: Wed, 25 Nov 2009 17:32:15 +0000
Message-ID: <20091125173215.539b5630@lxorguk.ukuu.org.uk>
References: <20091125170218.5446.13513.sendpatchset@localhost>
	<20091125170740.5446.67217.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41298 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754522AbZKYRaJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:30:09 -0500
In-Reply-To: <20091125170740.5446.67217.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

On Wed, 25 Nov 2009 18:07:40 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_legacy: do not probe extra ports automatically if PCI is not present
> 
> It can be problematic if there are other ISA/VLB devices using
> those ports.

NAK. You made a rather peculiar set of changes in the IDE layer but the
PCI handling in pata_legacy includes knowledge of the various half-pci
devices and on a non PCI system 0x1E8/0x168 are reserved for extra IDE.

We've had no complaints at all, ever about this.

> This is a forward port of bugfix from IDE ide-generic host driver.

Of a bug.

Alan
