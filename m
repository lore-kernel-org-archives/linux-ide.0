From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] libata: New driver for OCTEON SOC Compact Flash
 interface (v2).
Date: Tue, 25 Nov 2008 17:34:01 +0000
Message-ID: <20081125173401.44c28e17@lxorguk.ukuu.org.uk>
References: <492B56B0.9030409@caviumnetworks.com>
	<1227577181-30206-2-git-send-email-ddaney@caviumnetworks.com>
	<492C2EE2.3090702@garzik.org>
	<492C3509.8010408@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44668 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752220AbYKYReR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Nov 2008 12:34:17 -0500
In-Reply-To: <492C3509.8010408@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-mips@linux-mips.org

> system.  The only recourse is to cycle power to the board.  By allowing 
> DMA to be disabled, we eliminate this problem.

You can already do this via the existing libata option functions that
Tejun added a while back, or there is libata.dma=0 which is applied to
all interfaces.
