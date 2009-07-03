From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] pata_amd: add support for CS5535 controllers
Date: Fri, 3 Jul 2009 15:31:10 +0100
Message-ID: <20090703153110.3fa5dfbd@lxorguk.ukuu.org.uk>
References: <1246630963-5831-1-git-send-email-otavio@ossystems.com.br>
	<1246630963-5831-2-git-send-email-otavio@ossystems.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57269 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751952AbZGCO3h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Jul 2009 10:29:37 -0400
In-Reply-To: <1246630963-5831-2-git-send-email-otavio@ossystems.com.br>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Otavio Salvador <otavio@ossystems.com.br>

On Fri,  3 Jul 2009 11:22:43 -0300
Otavio Salvador <otavio@ossystems.com.br> wrote:

We already have a CS5535 driver: drivers/ata/pata_cs5535.c

That drives the hardware via the MSR interface which means it doesn't
rely so much on what firmware and firmware related magic happens to be on
a given system.

Alan

