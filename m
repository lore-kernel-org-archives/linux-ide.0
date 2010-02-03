From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2] libata: fix ata_id_logical_per_physical_sectors
Date: Wed, 03 Feb 2010 13:14:23 -0500
Message-ID: <yq1bpg6mbk0.fsf@sermon.lab.mkp.net>
References: <20100128104234.GA25693@lst.de> <20100128123011.GA32001@lst.de>
	<20100203173721.GA21703@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet11.oracle.com ([148.87.113.123]:60129 "EHLO
	rcsinet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab0BCSQf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Feb 2010 13:16:35 -0500
In-Reply-To: <20100203173721.GA21703@lst.de> (Christoph Hellwig's message of
	"Wed, 3 Feb 2010 18:37:21 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, stable@kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:

Christoph> Without this patch the minimum I/O size for 4k drives will be
Christoph> reported incorrectly, which will make paritions misaligned on
Christoph> modern distros.

I'm in total agreement with the patch (feel free to add my Acked-by:).

However, the minimum I/O size should still be reported correctly.  We
don't allow min_io to be smaller than physical_block_size...

[root@10 ~]# grep . /sys/block/sdc/queue/{logical_block,physical_block,minimum_io}_size
/sys/block/sdc/queue/logical_block_size:512
/sys/block/sdc/queue/physical_block_size:4096
/sys/block/sdc/queue/minimum_io_size:4096

-- 
Martin K. Petersen	Oracle Linux Engineering
