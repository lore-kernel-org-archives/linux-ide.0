From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return zeroes after TRIM
Date: Thu, 08 Jan 2015 09:29:27 -0500
Message-ID: <yq14ms14a7s.fsf@sermon.lab.mkp.net>
References: <20141204170611.GB2995@htj.dyndns.org>
	<yq14mtahmil.fsf@sermon.lab.mkp.net>
	<20141205145148.GI4080@htj.dyndns.org>
	<1418184578.2121.3.camel@HansenPartnership.com>
	<20141210142927.GA6294@htj.dyndns.org>
	<yq1oarbcj6f.fsf@sermon.lab.mkp.net>
	<20150105162830.GP15833@htj.dyndns.org>
	<yq1387n8nfv.fsf@sermon.lab.mkp.net>
	<20150107025455.GL3077@htj.dyndns.org>
	<20150107041537.GH31508@dastard>
	<20150107152648.GC4395@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:41888 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756088AbbAHO3k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jan 2015 09:29:40 -0500
In-Reply-To: <20150107152648.GC4395@htj.dyndns.org> (Tejun Heo's message of
	"Wed, 7 Jan 2015 10:26:48 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, linux-ide@vger.kernel.org, linux-fsdevel@vger.kernel.org

>>>>> "Tejun" == Tejun Heo <tj@kernel.org> writes:

Tejun> do you have a newer version or shall I apply the original one?

Just sent an updated patch that catches the latest Micron/Crucial drives
as well.

-- 
Martin K. Petersen	Oracle Linux Engineering
