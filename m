From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 7/7] libata: Add 32bit PIO support
Date: Tue, 6 Jan 2009 09:46:21 +0000
Message-ID: <20090106094621.4de3c8ed@lxorguk.ukuu.org.uk>
References: <20090105141102.28189.44312.stgit@localhost.localdomain>
	<20090105141619.28189.6174.stgit@localhost.localdomain>
	<4962AE92.5060401@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33771 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751321AbZAFS0V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Jan 2009 13:26:21 -0500
In-Reply-To: <4962AE92.5060401@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

> >  include/linux/libata.h    |    3 +++
> >  7 files changed, 66 insertions(+), 9 deletions(-)
> 
> This can likely be enabled for more controllers (presumably all the 
> SFF-based SATA controllers as well 

It can - but I'm doing them as they get tested and documentation
confirmation where possible.

> Don't some of the VLB controller drivers have their own private 32-bit 
> PIO implementation? Those should likely be updated to use this support.

Most VLB 32bit requires a sync sequence start and end so its not quite so
simple but yes.
