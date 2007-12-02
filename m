From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 12/12] pata_amd: update mode selection for NV PATAs
Date: Sun, 2 Dec 2007 14:15:21 +0000
Message-ID: <20071202141521.28af79c0@the-village.bc.nu>
References: <11961602293422-git-send-email-htejun@gmail.com>
	<11961602321707-git-send-email-htejun@gmail.com>
	<4751ECC2.2050000@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37266 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752503AbXLBOTg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Dec 2007 09:19:36 -0500
In-Reply-To: <4751ECC2.2050000@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

> > Signed-off-by: Tejun Heo <htejun@gmail.com>
> > Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > ---
> >  drivers/ata/pata_amd.c |  129 ++++++++++++++++++++++++++++++++++-------------
> >  1 files changed, 93 insertions(+), 36 deletions(-)
> 
> Yeah, I think this is a better way to do things long term.  Thanks...

Ditto - and I believe we should make the same change to VIA. A subset of
VIA boards are showing the same troubles.
