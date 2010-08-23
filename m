From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 6/6] sd: Update thin provisioning support
Date: Mon, 23 Aug 2010 15:06:00 -0400
Message-ID: <yq14oeltahz.fsf@sermon.lab.mkp.net>
References: <1282232941-9910-1-git-send-email-martin.petersen@oracle.com>
	<1282232941-9910-7-git-send-email-martin.petersen@oracle.com>
	<20100820090039.GD27033@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:49108 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419Ab0HWTGU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Aug 2010 15:06:20 -0400
In-Reply-To: <20100820090039.GD27033@lst.de> (Christoph Hellwig's message of
	"Fri, 20 Aug 2010 11:00:40 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

>>>>> "hch" == Christoph Hellwig <hch@lst.de> writes:

hch> I don't think we can simply break all existing setups with support
hch> for earlier SBC drafts.  I think we should use the TPU and TPWS
hch> same bits if present and else fall back to our current heuristics.

Originally my patch included support for "legacy" TP devices triggered
by TPE=1 but no TP VPD page listed in page 0.  I also supported the even
older TP approach (WRITE SAME without the UNMAP bit, all zero payload).

However, I talked to a few partners and everybody were going to add the
TP VPD to their firmware builds right away.  So I ripped out the compat
stuff because I felt it was weird to have explicit support for an
intermediate SBC3 release in there.

How would you feel about a sysfs switch to "force" TP on for devices
that don't report it correctly?

-- 
Martin K. Petersen	Oracle Linux Engineering
