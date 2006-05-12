From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: ata_piix resume from S3 on T43P failed
Date: Fri, 12 May 2006 13:51:46 +0800
Message-ID: <1147413106.7273.70.camel@forrest26.sh.intel.com>
References: <1147334740.7273.38.camel@forrest26.sh.intel.com>
	 <4462F667.3060504@gmail.com> <4462F767.5070003@gmail.com>
	 <1147340790.7273.47.camel@forrest26.sh.intel.com>
	 <20060511105555.GK4157@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50598 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750943AbWELGCx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 May 2006 02:02:53 -0400
In-Reply-To: <20060511105555.GK4157@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Thu, 2006-05-11 at 12:55 +0200, Jens Axboe wrote:
> run dmesg prior to suspending, then it'll be cached and can be run after
> resume even if the disk doesn't want to talk to you.
> 

Don't know why the mails with attached files were not sent to mailing
list, so I put them at
http://www.infradead.org/~forrest/suspend-resume-dmesg/

Thanks,
Forrest
