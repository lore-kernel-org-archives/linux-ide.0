From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH libata/for-3.16-fixes] libata: introduce ata_host->n_tags
 to avoid oops on SAS controllers
Date: Wed, 23 Jul 2014 18:46:05 +0200
Message-ID: <2111455.4B0otWTvWT@amdc1032>
References: <1406040688-1762-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <4586703.PjmVDM7Oct@amdc1032> <20140723163601.GE7103@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:9813 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756598AbaGWQqZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jul 2014 12:46:25 -0400
In-reply-to: <20140723163601.GE7103@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@gmail.com>, Mike Qiu <qiudayu@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, wenxiong@linux.vnet.ibm.com, brking@linux.vnet.ibm.com, zhenghch@cn.ibm.com, haokexin@gmail.com, Peter Hurley <peter@hurleysoftware.com>, Peter Zijlstra <peterz@infradead.org>, Alexey Kardashevskiy <aik@ozlabs.ru>

On Wednesday, July 23, 2014 12:36:01 PM Tejun Heo wrote:
> Hello,
> 
> On Wed, Jul 23, 2014 at 06:31:58PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Hmmm, wasn't ATA_MAX_QUEUE used before not ATA_MAX_QUEUE - 1?
> > 
> > It seems that after your patch the loop in the ata_qc_new() will use
> > only 30 tags and not 31 ones?
> 
> It was always 31 (ATA_MAX_QUEUE - 1) with the tag 31 reserved for EH
> commands.  The previous patch just used limit value which is one too
> high.  I'm planning to change that but this is the way it has always
> been.

I see, thanks for explaining this.

BTW:
		/* the last tag is reserved for internal command. */
		if (tag == ATA_TAG_INTERNAL)
			continue;

in ata_qc_new()'s loop now becomes a dead code (loop will be done
maximum ATA_MAX_QUEUE - 2 times and ATA_TAG_INTERNAL is defined
as ATA_MAX_QUEUE - 1).  Compiler can probably optimize it away so
as a bonus of your patch we may get one condition check less in
a hot-path. :)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

