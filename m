From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ata: ahci: power off unused ports
Date: Fri, 9 May 2008 17:06:41 +0100
Message-ID: <20080509160641.GA30219@srcf.ucam.org>
References: <20080508161008.59361de5@appleyard> <20080508233713.GB15377@srcf.ucam.org> <20080509155830.GE6957@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:45162 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755268AbYEIQHA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 May 2008 12:07:00 -0400
Content-Disposition: inline
In-Reply-To: <20080509155830.GE6957@csclub.uwaterloo.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 09, 2008 at 11:58:31AM -0400, Lennart Sorensen wrote:
> On Fri, May 09, 2008 at 12:37:13AM +0100, Matthew Garrett wrote:
> > Just out of interest, is this set on laptop bays? (Are any of those even 
> > native SATA yet?)
> 
> My wife's Asus R1F does in fact have SATA in use for the drive bay and
> allows swapping between the DVD-RW and a second HD (or another battery
> if she had one) in that bay.  I would think many laptops do that now.

Genuinely SATA, or PATA bridged to SATA?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
