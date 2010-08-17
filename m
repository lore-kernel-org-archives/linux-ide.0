From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Tue, 17 Aug 2010 17:42:57 +0100
Message-ID: <20100817174257.3691ed68@lxorguk.ukuu.org.uk>
References: <20100810155559.7620.79711.stgit@localhost.localdomain>
	<4C6AB68D.8000102@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45788 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757490Ab0HQQ1p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2010 12:27:45 -0400
In-Reply-To: <4C6AB68D.8000102@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, jeff@garzik.org

> This looks scary to me.  Is this something documented somewhere?  It's
> not like we can avoid adding PCI device IDs completely anyway, so I
> would suggest just doing it good old fashioned way.

The trouble with adding all the ids is it will keep needing updates every
chipset (and a lot of existing idents).

Is it documented ? The instructions it was written to came from the
people who do the chips.

Alan
