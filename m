From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] Add support for Designware SATA controller driver
Date: Fri, 01 May 2009 10:07:07 -0400
Message-ID: <49FB020B.8000505@garzik.org>
References: <1241042419-19774-1-git-send-email-fkan@amcc.com>	 <49FAA434.9040106@garzik.org> <1241167748.1781.3.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59032 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752667AbZEAOHL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 May 2009 10:07:11 -0400
In-Reply-To: <1241167748.1781.3.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Feng Kan <fkan@amcc.com>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

Benjamin Herrenschmidt wrote:
> Patch 2/2 is just adding the device-tree bits to the platform for
> this driver to match against, so it's no big deal. However, Feng,
> we already mentioned that you do a lot of unrelated changes to the
> Kconfig file that shouldn't be part of this patch, just add the
> entry for this chip, don't move stuff around in Kconfig, unless I
> missed a good reason why this is done that way.


Quite correct -- those drivers/ata/Kconfig changes are bogus.

	Jeff



