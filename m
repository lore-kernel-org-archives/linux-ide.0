From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add support for Designware SATA controller driver
Date: Fri, 01 May 2009 18:49:08 +1000
Message-ID: <1241167748.1781.3.camel@pasglop>
References: <1241042419-19774-1-git-send-email-fkan@amcc.com>
	 <49FAA434.9040106@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:37576 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099AbZEAIuR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 May 2009 04:50:17 -0400
In-Reply-To: <49FAA434.9040106@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Feng Kan <fkan@amcc.com>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

On Fri, 2009-05-01 at 03:26 -0400, Jeff Garzik wrote:
> Feng Kan wrote:
> > Signed-off-by: Feng Kan <fkan@amcc.com>
> > ---
> >  drivers/ata/Kconfig    |   76 +-
> >  drivers/ata/Makefile   |    1 +
> >  drivers/ata/sata_dwc.c | 2047 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 2091 insertions(+), 33 deletions(-)
> >  create mode 100644 drivers/ata/sata_dwc.c
> 
> I don't see a patch 2/2 ?

Patch 2/2 is just adding the device-tree bits to the platform for
this driver to match against, so it's no big deal. However, Feng,
we already mentioned that you do a lot of unrelated changes to the
Kconfig file that shouldn't be part of this patch, just add the
entry for this chip, don't move stuff around in Kconfig, unless I
missed a good reason why this is done that way.

Cheers,
Ben.


