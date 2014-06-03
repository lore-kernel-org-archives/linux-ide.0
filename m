From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Candidate for late revert ?
Date: Mon, 02 Jun 2014 21:17:32 -0400
Message-ID: <yq1k38y6bbn.fsf@sermon.lab.mkp.net>
References: <20140603000728.28fca8fe@www.etchedpixels.co.uk>
	<CA+55aFykTbMRKku1bDd_wHCjyD+Yf2v-B8-c+NKMZ0AnNkpVrw@mail.gmail.com>
	<yq138fm98in.fsf@sermon.lab.mkp.net>
	<20140603004520.GB19855@htj.dyndns.org>
	<yq1sinm6bl3.fsf@sermon.lab.mkp.net>
	<20140603011510.GD19855@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:25401 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbaFCBRq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jun 2014 21:17:46 -0400
In-Reply-To: <20140603011510.GD19855@htj.dyndns.org> (Tejun Heo's message of
	"Mon, 2 Jun 2014 21:15:10 -0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

>>>>> "Tejun" == Tejun Heo <tj@kernel.org> writes:

Tejun> I have no problem with adding debug features as long as it's
Tejun> clear that it's a debug feature - please gate it with a module
Tejun> param which clearly indicates that it's for debugging.

OK, will do.

-- 
Martin K. Petersen	Oracle Linux Engineering
