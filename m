From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/1] sata_sil: Option to use IO space to access TF
 registers.
Date: Fri, 31 Oct 2008 08:48:20 +0000
Message-ID: <20081031084820.78190319@lxorguk.ukuu.org.uk>
References: <20081022182243.9471.87443.stgit@linux-chris2.mips.com>
	<20081022221623.344aea62@lxorguk.ukuu.org.uk>
	<20081022233439.GA30488@ftp.linux-mips.org>
	<20081023083215.74e48b03@lxorguk.ukuu.org.uk>
	<20081030225853.GA525@ftp.linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35266 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752392AbYJaIsV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Oct 2008 04:48:21 -0400
In-Reply-To: <20081030225853.GA525@ftp.linux-mips.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Dearman <chris@linux-mips.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Thu, 30 Oct 2008 22:58:53 +0000
Chris Dearman <chris@linux-mips.org> wrote:

> On Thu, Oct 23, 2008 at 08:32:15AM +0100, Alan Cox wrote:
> > I would make the switch a runtime value personally - some network drivers
> > do this for similar reasons.
> 
> OK. Something like this?

Yep something exactly like that. Looks good to me

Alan
