From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Marvell 88SE6121 PATA in 2.6.25 (ahci)
Date: Thu, 15 May 2008 14:07:45 +0100
Message-ID: <20080515140745.52941036@core>
References: <20080505045537.GA24381@gozer.dminteractive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37560 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751407AbYEONSl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 May 2008 09:18:41 -0400
In-Reply-To: <20080505045537.GA24381@gozer.dminteractive.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Hokenson <kernel+marvell@gozer.org>
Cc: linux-ide@vger.kernel.org

On Sun, 4 May 2008 23:55:37 -0500
Mike Hokenson <kernel+marvell@gozer.org> wrote:

> Hi list,
> 
> I just noticed my Marvell 88SE6121 PATA controller isn't working in
> 2.6.25. pata_marvell.c is more or less untouched (removal of a return
> in a void), but drivers/ata/ahci.c had some changes:

Known bug: Jeff added AHCI support for the SATA side before it was ready,
which broke all the PATA support. 

Just reverse the patch.

Alan
