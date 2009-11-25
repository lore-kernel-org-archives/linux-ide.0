From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 45/86] pata_legacy: do not probe extra ports automatically if PCI is not present
Date: Wed, 25 Nov 2009 18:45:52 +0100
Message-ID: <200911251845.52700.bzolnier@gmail.com>
References: <20091125170218.5446.13513.sendpatchset@localhost> <20091125170740.5446.67217.sendpatchset@localhost> <20091125173215.539b5630@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:57215 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933090AbZKYRrD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:47:03 -0500
In-Reply-To: <20091125173215.539b5630@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 25 November 2009 06:32:15 pm Alan Cox wrote:
> On Wed, 25 Nov 2009 18:07:40 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] pata_legacy: do not probe extra ports automatically if PCI is not present
> > 
> > It can be problematic if there are other ISA/VLB devices using
> > those ports.
> 
> NAK. You made a rather peculiar set of changes in the IDE layer but the

Please give commit numbers and describe such 'peculiar set of changes in
the IDE layer' in more details or skip such baseless, unjust and pointless
comments from your mails.

> PCI handling in pata_legacy includes knowledge of the various half-pci
> devices and on a non PCI system 0x1E8/0x168 are reserved for extra IDE.
> 
> We've had no complaints at all, ever about this.

OTOH We had. :)

--
Bartlomiej Zolnierkiewicz
