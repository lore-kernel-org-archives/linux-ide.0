From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [Patch] enable AHCI mode on certain ich chipsets
Date: Fri, 18 Feb 2011 15:03:20 +0100
Message-ID: <87aahtsamv.fsf@nemi.mork.no>
References: <20110216090548.GQ5778@Redstar.dorchain.net>
	<20110217100330.GO19830@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:50682 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425Ab1BRODf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Feb 2011 09:03:35 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1PqQvl-0007ZT-SM
	for linux-ide@vger.kernel.org; Fri, 18 Feb 2011 15:03:33 +0100
Received: from nemi.mork.no ([148.122.252.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 18 Feb 2011 15:03:33 +0100
Received: from bjorn by nemi.mork.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 18 Feb 2011 15:03:33 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tejun Heo <tj@kernel.org> writes:

> I'm not particularly inclined toward including this patch in upstream
> as long as it can't be enabled by default.  It's just gonna be an
> extra piece of code to carry around which only a handful of people us=
e
> and nobody really knows on which hardware it works or not and to what
> extent.

Then enable it by default :-)



Bj=C3=B8rn

