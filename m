From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/4] block: Allow devices to indicate whether discarded blocks are zeroed
Date: Sat, 21 Nov 2009 15:17:55 -0500
Message-ID: <yq1ws1jr5sc.fsf@sermon.lab.mkp.net>
References: <1258771524-26673-1-git-send-email-martin.petersen@oracle.com>
	<1258771524-26673-2-git-send-email-martin.petersen@oracle.com>
	<4B07E214.3020800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet11.oracle.com ([148.87.113.123]:18766 "EHLO
	rgminet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508AbZKUUTj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Nov 2009 15:19:39 -0500
In-Reply-To: <4B07E214.3020800@redhat.com> (Ric Wheeler's message of "Sat, 21
	Nov 2009 07:50:28 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ric Wheeler <rwheeler@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, jens.axboe@oracle.com, james.bottomley@hansenpartnership.com, hch@infradead.org, willy@wil.cx, jgarzik@pobox.com, sandeen@redhat.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

>>>>> "Ric" == Ric Wheeler <rwheeler@redhat.com> writes:

>> + lim->discard_zeroes_data = -1;

Ric> Did you mean to set this to -1 ?

Yep, it's a "not set yet" value for the stacking to work properly in
this case.

-- 
Martin K. Petersen	Oracle Linux Engineering
