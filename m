From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata-core Use more robust parsing for multi_count
Date: Wed, 18 Mar 2009 14:32:30 +0000
Message-ID: <20090318143230.2b64e273@lxorguk.ukuu.org.uk>
References: <49C1047D.4000008@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46175 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756832AbZCROcA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Mar 2009 10:32:00 -0400
In-Reply-To: <49C1047D.4000008@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

> +			switch (dev->id[59] & 0xff) {

Umm surely...

	if (n & (n - 1))

otherwise looks good.

Alan
