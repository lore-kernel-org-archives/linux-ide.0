From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_nv + ADMA + Samsung disk problem
Date: Wed, 02 Jan 2008 01:19:16 -0500
Message-ID: <477B2CE4.8070602@garzik.org>
References: <20070808120804.GB5257@boogie.lpds.sztaki.hu> <20080101164416.GA29574@boogie.lpds.sztaki.hu> <477B0429.7040909@gmail.com> <477B0CFD.1030603@shaw.ca> <477B10F2.9000107@shaw.ca> <477B1233.3090706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52122 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755095AbYABGTX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Jan 2008 01:19:23 -0500
In-Reply-To: <477B1233.3090706@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>, Gabor Gombas <gombasg@sztaki.hu>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kluo@nvidia.com, AMartin@nvidia.com, pchen@nvidia.com

Tejun Heo wrote:
> Thanks a lot for the detailed explanation.  Nvidia ppl, any ideas?
> FLUSH is used regularly.  We really need to fix this.


I reiterate my opinion :)  ...   We should remove ADMA support from 
sata_nv.  It's only in a few chips, it's not appearing in any new chips, 
and nasty problems have lingered since ADMA support was introduced.

Definitely sounds like we should disable ADMA by default for 2.6.24-rc, too.

	Jeff


