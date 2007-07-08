From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.22-rc7-git1] sis5513: adding  PCI-ID
Date: Sun, 8 Jul 2007 15:03:22 +0200
Message-ID: <200707081503.22684.bzolnier@gmail.com>
References: <200707042245.35118.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:45141 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756938AbXGHN7v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Jul 2007 09:59:51 -0400
Received: by nf-out-0910.google.com with SMTP id g13so50892nfb
        for <linux-ide@vger.kernel.org>; Sun, 08 Jul 2007 06:59:49 -0700 (PDT)
In-Reply-To: <200707042245.35118.uwe.koziolek@gmx.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe koziolek <uwe.koziolek@gmx.net>
Cc: linux-ide@vger.kernel.org

On Wednesday 04 July 2007, Uwe koziolek wrote:
> The SiS966 has one additional PCI-ID 1180.
> If the chipset is using this PCI-ID, the primary channel is connected to the first
> PATA-port. The secondary channel is connected to SATA-ports in IDE emulation mode.
> The legacy IO-ports are used.
> 
> the including of the PCI-ID into pata_sis is not sufficient, because the legacy driver
> in drivers/ide is initialized before pata_sis.
> 
> Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>

applied, thanks
