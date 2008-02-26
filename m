From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ops->qc_defer not invoked on ata_exec_internal_sg() paths ?
Date: Tue, 26 Feb 2008 12:32:09 +0000
Message-ID: <20080226123209.7ca9eed4@core>
References: <47C35B6B.8000406@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49288 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751457AbYBZMm2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Feb 2008 07:42:28 -0500
In-Reply-To: <47C35B6B.8000406@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, 25 Feb 2008 19:20:59 -0500
Mark Lord <liml@rtr.ca> wrote:

> The optional .qc_defer() methods don't seem to be called
> on the ata_exec_internal_sg() path.
> 
> At present, this is probably okay.  But in the future,
> as we add functionality for link power management
> and hotplug polling, this could be a problem.

It becomes a problem for me certainly if we ever issue anything via
exec_internal_sg while another command may be outstanding anywhere on the
same *host*. Right now its ok.

Alan
