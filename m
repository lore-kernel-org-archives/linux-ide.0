From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: incoming
Date: Fri, 20 Oct 2006 23:31:16 +0100
Message-ID: <1161383476.26440.63.camel@localhost.localdomain>
References: <20061020143929.8819dfa8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25800 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S2992725AbWJTWbz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Oct 2006 18:31:55 -0400
In-Reply-To: <20061020143929.8819dfa8.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Ar Gwe, 2006-10-20 am 14:39 -0700, ysgrifennodd Andrew Morton:
> I have 12 ata patches here - I'm not sure that Tejun's ones are the latest
> version, but I'll just send the whole lot as-is, see what happens...

Looks fine with respect to my bits and Tejun's. Now Tejun's polling
identify is in I'll have a pile of patches next week as most PATA
controllers want to use this.

Alan

