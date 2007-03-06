From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Subject: Re: [PATA] Failed to set xfermode on LITE-ON LTR-48246S
Date: Tue, 6 Mar 2007 10:23:39 +0100
Message-ID: <20070306092339.GA3803@titan.lahn.de>
References: <Pine.LNX.4.64.0702041057090.8424@woody.linux-foundation.org> <20070227135838.GA4328@titan.lahn.de> <45EB9822.40300@gmail.com> <20070305103840.GA4381@titan.lahn.de> <45EC3B3F.7020509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:48335
	"EHLO schlidder.svs.informatik.uni-oldenburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030189AbXCFJXl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Mar 2007 04:23:41 -0500
Content-Disposition: inline
In-Reply-To: <45EC3B3F.7020509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hello Tejun!

On Tue, Mar 06, 2007 at 12:46:07AM +0900, Tejun Heo wrote:
> Philipp Matthias Hahn wrote:
> > On Mon, Mar 05, 2007 at 01:10:10PM +0900, Tejun Heo wrote:
> > > * Does applying the attached patch over unpatched 2.6.20.1 fix the problem?
> >
> > Yes, it seems to fix it. (testes on top of the first patch mentioned
> > above, but witheout the second one.).
> > If I should test it as the sole patche, just mail me again please.
>
> Yeap, please test it on top of vanilla kernel to verify that the patch
> proper fixes the problem.

Yes, applying only this patch does fix the problem.
Thank you for your support.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
