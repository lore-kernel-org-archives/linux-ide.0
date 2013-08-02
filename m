From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] Hard disk S3 resume time optimization
Date: Fri, 02 Aug 2013 19:05:05 +0200
Message-ID: <1375463105.13494.0.camel@linux-fkkt.site>
References: <11E08D716F0541429B7042699DD5C1A1706803A6@FMSMSX103.amr.corp.intel.com>
	,<1375447356.2138.13.camel@linux-fkkt.site>
	 <11E08D716F0541429B7042699DD5C1A1706804B6@FMSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54582 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755151Ab3HBRFH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Aug 2013 13:05:07 -0400
In-Reply-To: <11E08D716F0541429B7042699DD5C1A1706804B6@FMSMSX103.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Brandt, Todd E" <todd.e.brandt@intel.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>

On Fri, 2013-08-02 at 16:41 +0000, Brandt, Todd E wrote:
> Do you mean in terms of debug after a failure? I can resubmit the patch with the scsi_sense_hdr buffer still in place. I just wanted to keep the first draft simple to get the concept across. 
How are errors reported?

	Regards
		Oliver


