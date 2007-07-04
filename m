From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Libata PATA status
Date: 04 Jul 2007 15:00:26 +0200
Message-ID: <p73k5tg2uj9.fsf@bingen.suse.de>
References: <20070703185116.59c8f5f5@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:59313 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761496AbXGDMFI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Jul 2007 08:05:08 -0400
In-Reply-To: <20070703185116.59c8f5f5@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> Post SRST 
What is SRST?

My personal wish list feature would be a little forwarder driver
to forward /dev/hd* to /dev/sd* for this; then old IDE could be
disabled without risking breaking old root file systems.

-Andi
