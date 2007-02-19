From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_amd dropping to PIO on resume
Date: Mon, 19 Feb 2007 22:08:12 +0000
Message-ID: <20070219220812.11c3baba@localhost.localdomain>
References: <fa.q7ZuddHInqn2dVlS+EWjXjPvFC8@ifi.uio.no>
	<45D63BCE.2080700@shaw.ca>
	<45D6436C.4060209@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58451 "EHLO
	localhost.localdomain" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932672AbXBSVFU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Feb 2007 16:05:20 -0500
In-Reply-To: <45D6436C.4060209@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Robert Hancock <hancockr@shaw.ca>, Tobias Diedrich <ranma+kernel@tdiedrich.de>, Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

> Deleting the ata_pci_clear_simplex() call, then adding 
> ATA_FLAG_IGN_SIMPLEX to the ata_port_info info[] array, is also worth 
> trying.

I think I know what is going on here. Firstly the simplex bits
need re-clearing on a resume. On my todo list now I'm back
