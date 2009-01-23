From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata_mv: basic PIO-only ATAPI support?
Date: Fri, 23 Jan 2009 17:52:17 +0000
Message-ID: <20090123175217.353654de@lxorguk.ukuu.org.uk>
References: <49750705.7010709@rtr.ca>
	<49750746.3010709@rtr.ca>
	<49750774.1070005@rtr.ca>
	<49773FD1.3040101@rtr.ca>
	<4977C5A5.8070202@gmail.com>
	<49780167.1060208@rtr.ca>
	<497801F9.2070009@rtr.ca>
	<4978028D.3020501@gmail.com>
	<4979FC55.1000904@rtr.ca>
	<4979FD22.8040407@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34283 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755800AbZAWRwG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Jan 2009 12:52:06 -0500
In-Reply-To: <4979FD22.8040407@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

> Question: is this the "right" way to force PIO-only,
> or is there a better mechanism that I'm missing.

If you want to force ATAPI into PIO modes only then use the
->mode_filter() functionality to drop out the non PIO modes. See
pata_hpt37x.c for an example where it does it for some drives only

If you want to just force some types of command into using PIO (eg by
direction, length etc) then use ->check_atapi_dma(qc) - see pata_it821x
for a worked example.

Alan
