From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return zeroes after TRIM
Date: Wed, 10 Dec 2014 16:02:32 -0500
Message-ID: <yq1oarbcj6f.fsf@sermon.lab.mkp.net>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net>
	<20141204170611.GB2995@htj.dyndns.org>
	<yq14mtahmil.fsf@sermon.lab.mkp.net>
	<20141205145148.GI4080@htj.dyndns.org>
	<1418184578.2121.3.camel@HansenPartnership.com>
	<20141210142927.GA6294@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:23711 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933253AbaLJVCi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Dec 2014 16:02:38 -0500
In-Reply-To: <20141210142927.GA6294@htj.dyndns.org> (Tejun Heo's message of
	"Wed, 10 Dec 2014 09:29:27 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org

>>>>> "Tejun" == Tejun Heo <tj@kernel.org> writes:

Tejun> If raid consistency truly is the only reason for this, that
Tejun> approach seems way more fruitful to me than playing this optional
Tejun> feature game with hardware vendors which so often leads to
Tejun> eventual abysmal outcomes.

The other use case is the filesystem one where it is common to zero
block ranges for bitmaps, etc. In many workloads there's is a
significant win to trimming over writing out many blocks of zeroes.

-- 
Martin K. Petersen	Oracle Linux Engineering
