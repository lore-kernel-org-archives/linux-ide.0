From: "Martin K. Petersen" <mkp@mkp.net>
Subject: Re: pata_cs5536: ATA driver for Geode companion chip
Date: Thu, 04 Oct 2007 13:00:47 -0400
Message-ID: <yq13awqak74.fsf@sermon.lab.mkp.net>
References: <20071003233012.GA8721@cosmic.amd.com>
	<yq1przva76x.fsf@sermon.lab.mkp.net>
	<20071004165819.003b86c6@the-village.bc.nu>
	<20071004160834.GA28667@cosmic.amd.com>
	<20071004172231.17665123@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jaguar.mkp.net ([192.139.46.146]:45169 "EHLO jaguar.mkp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755730AbXJDRAs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Oct 2007 13:00:48 -0400
In-Reply-To: <20071004172231.17665123@the-village.bc.nu> (Alan Cox's message of "Thu\, 4 Oct 2007 17\:22\:31 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jordan Crouse <jordan.crouse@amd.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

Alan> Even if we use PCI accesses and keep them dword along with the
Alan> right timing it makes sense to have a 5536 driver for this.

Yeah.  Let me polish the PCI version and send that out...

-- 
Martin K. Petersen      http://mkp.net/
