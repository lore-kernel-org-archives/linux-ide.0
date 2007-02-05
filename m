From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH libata-dev#upstream 2/2] pata_amd: don't configure udma
 mode faster than BIOS did
Date: Mon, 5 Feb 2007 11:25:33 +0000
Message-ID: <20070205112533.611558c2@localhost.localdomain>
References: <20070205080518.GI1625@htj.dyndns.org>
	<20070205080801.GJ1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33323 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752289AbXBELMm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 06:12:42 -0500
In-Reply-To: <20070205080801.GJ1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> This patch implements mode_filter for pata_amd which makes it avoid
> configuring udma mode higher than BIOS did.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

NAK, wrong for the same reason as it is wrong on the IDE one, and even
more so as we will support hotplug and the like in time too.

