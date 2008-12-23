From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] sata_sil: add Large Block Transfer support
Date: Tue, 23 Dec 2008 10:10:33 +0000
Message-ID: <20081223101033.70c74ec7@lxorguk.ukuu.org.uk>
References: <4945BDED.7050205@shaw.ca>
	<494F69C4.2060708@kernel.org>
	<49506AAF.3040400@shaw.ca>
	<49506BBC.8040600@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34618 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752330AbYLWKKZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Dec 2008 05:10:25 -0500
In-Reply-To: <49506BBC.8040600@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockr@shaw.ca>, ide <linux-ide@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

> > We know the register's always MMIO on this controller, so it's slightly
> > more optimal to avoid the conditional in there.
> 
> Yeah, by a small margin but I think the consensus was to use
> ioread/write no matter what if it's mapped using iomap.  I don't think
> we guarantee iomapped address == mmio address after all.

This was discussed before - using writel/readl on iomap is wrong. It may
happen to work on some platforms but shouldn't be expected to work on all.
