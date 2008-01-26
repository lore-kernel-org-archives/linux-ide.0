From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 10/14] sata_mv Use DMA memory pools for hardware memory
 tables
Date: Sat, 26 Jan 2008 10:45:38 -0500
Message-ID: <479B55A2.4060807@pobox.com>
References: <4798FB68.70400@rtr.ca> <4798FCE1.30702@rtr.ca> <479AB639.5020108@pobox.com> <479B4F55.8050105@rtr.ca> <479B5207.9000608@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53934 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017AbYAZPpm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jan 2008 10:45:42 -0500
In-Reply-To: <479B5207.9000608@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Just say exactly what you require here.
> And keep in mind that any change I make incurs a 2-day wait
> while the Marvell folks vet it again (not my choice).


(about to go to sleep, so the rest must wait)

Bandwidth and mailing list archives are cheap, emailing is scriptable 
and its less confusion to simply discuss, revise, then repost the whole 
thing.  Keeping track of the latest revision of each of 15 patches is an 
exercise in complexity management :)

When its just one or two patches, replying with an updated
	"[PATCH v2] ..."
generally works, but that doesn't scale well.

(and, more practically, I made a guess that the patch series would need 
some revisions somewhere, assumed it would be reposted post-discussion, 
and deleted it locally after review)

	Jeff



