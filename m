From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Deal with ATA8-ACS proposed Trusted/Treacherous
 Computing features
Date: Thu, 25 Oct 2007 05:00:54 -0400
Message-ID: <47205B46.2010706@garzik.org>
References: <20071012173918.3f6d2760@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48753 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415AbXJYJAz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 05:00:55 -0400
In-Reply-To: <20071012173918.3f6d2760@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> - Make dword_io check the ATA version

speaking of dword_io, it would be nice to add 32-bit functions for I/O 
rather than hand-rolling like pdc_data_xfer_vlb() does.

	Jeff


