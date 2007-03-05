From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Subject: Re: [PATA] Failed to set xfermode on LITE-ON LTR-48246S
Date: Mon, 5 Mar 2007 11:38:40 +0100
Message-ID: <20070305103840.GA4381@titan.lahn.de>
References: <Pine.LNX.4.64.0702041057090.8424@woody.linux-foundation.org> <20070227135838.GA4328@titan.lahn.de> <45EB9822.40300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:47927
	"EHLO schlidder.svs.informatik.uni-oldenburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933051AbXCEKin (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Mar 2007 05:38:43 -0500
Content-Disposition: inline
In-Reply-To: <45EB9822.40300@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Helo Tejun!

On Mon, Mar 05, 2007 at 01:10:10PM +0900, Tejun Heo wrote:
> Philipp Matthias Hahn wrote:
> > As reported by John Williams and others like in
> > http://www.mail-archive.com/linux-ide@vger.kernel.org/msg03088.html
> > I too have a problem with 2.6.20.1 using ata_piix not detecting the
> > CD-ROM any more. Applying the patch from
> > http://lkml.org/lkml/2007/2/12/24 did not help, but additionally
> > applying
> > http://readlist.com/lists/vger.kernel.org/linux-kernel/45/228948.html
> > made it work. Here's the relevant extra debugging output:
> 
> * Did it work with previous kernels?

Previously I was using the old IDE modules just fine, it was only with
2.6.20 that I did the switch to libata and encountered the problem.

> * Does applying the attached patch over unpatched 2.6.20.1 fix the problem?

Yes, it seems to fix it. (testes on top of the first patch mentioned
above, but witheout the second one.).
If I should test it as the sole patche, just mail me again please.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
