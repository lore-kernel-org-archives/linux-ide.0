From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 4/4] libata: Fall back to unqueued READ LOG EXT if the DMA variant fails
Date: Tue, 16 Jun 2015 12:43:24 -0400
Message-ID: <yq14mm7hadv.fsf@sermon.lab.mkp.net>
References: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com>
	<1430790861-30066-4-git-send-email-martin.petersen@oracle.com>
	<557B39FB.4060304@redhat.com> <yq1wpz5hn0y.fsf@sermon.lab.mkp.net>
	<20150615152459.GA14007@dhcp-10-15-1-8.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:41914 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789AbbFPQne (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jun 2015 12:43:34 -0400
In-Reply-To: <20150615152459.GA14007@dhcp-10-15-1-8.hsv.redhat.com> (David
	Milburn's message of "Mon, 15 Jun 2015 10:24:59 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org, hare@suse.de, tj@kernel.org

>>>>> "David" == David Milburn <dmilburn@redhat.com> writes:

David> Ahh, ok, would it be ok to slightly change the error message to
David> indicate the drive doesn't support queued TRIM.

I don't have a problem with your more elaborate debug message.

It is a clear bug in the drive firmware, though. The ACS spec mandates
that the log page shall be supported if IDENTIFY DEVICE word 77, bit 6
is set.

-- 
Martin K. Petersen	Oracle Linux Engineering
