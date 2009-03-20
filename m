From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata-core More robust parsing for multi_count(v5)
Date: Fri, 20 Mar 2009 14:07:14 +0000
Message-ID: <20090320140714.2e7770d0@lxorguk.ukuu.org.uk>
References: <49C1047D.4000008@rtr.ca>
	<49C11A0C.3070502@rtr.ca>
	<49C11ED4.2030307@rtr.ca>
	<49C19087.5000307@gmail.com>
	<49C190F1.7010202@kernel.org>
	<49C28133.8050401@rtr.ca>
	<49C281A5.5080404@rtr.ca>
	<49C2D642.90706@kernel.org>
	<49C39690.6090802@rtr.ca>
	<49C396CF.7030202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37419 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751736AbZCTOHi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Mar 2009 10:07:38 -0400
In-Reply-To: <49C396CF.7030202@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

> Oh, and zero means "don't care".  So it's really easy to add
> to libata without having to patch each and every driver.

If its only one driver why not do it the way we do things like transfer
length limits for LBA48 (see pata_it821x and others)

