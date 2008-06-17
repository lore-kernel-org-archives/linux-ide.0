From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes 2/2] libata: implement
 ATAPI_HORKAGE_NOPIO and apply it to GGW-H10N
Date: Tue, 17 Jun 2008 09:54:35 +0100
Message-ID: <20080617095435.146f7ac3@lxorguk.ukuu.org.uk>
References: <4857313A.1000405@kernel.org>
	<48573174.9050103@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52478 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752992AbYFQJM3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jun 2008 05:12:29 -0400
In-Reply-To: <48573174.9050103@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, luke@lukeross.name

On Tue, 17 Jun 2008 12:37:24 +0900
Tejun Heo <tj@kernel.org> wrote:

> LG blueray drive GGW-H10N can't do ATAPI PIO.  Implement
> ATAPI_HORKAGE_NOPIO and apply it to the drive.  If the horkage is
> active, atapi_check_dma() always returns 0 and warns if the controller
> needs ATAPI PIO for certain commands.

A further sweep of google shows no other bug reports but this one anywhere
and nothing from LG about compatiblity as would be expected for such a
problem

So NACK this patch.

Alan
