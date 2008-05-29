From: Li Zefan <lizf@cn.fujitsu.com>
Subject: Re: [BUG ?] kmalloc() with GFP_KERNEL while holding spinlock ?
Date: Thu, 29 May 2008 12:29:46 +0800
Message-ID: <483E313A.9040905@cn.fujitsu.com>
References: <483E2156.9020108@cn.fujitsu.com> <87fxs1rcag.fsf@saeurebad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:61847 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751251AbYE2EbX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 May 2008 00:31:23 -0400
In-Reply-To: <87fxs1rcag.fsf@saeurebad.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Johannes Weiner <hannes@saeurebad.de>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Johannes Weiner wrote:
> Fixed by commit ae6c23c4e1ec9720b99e1e6850fe47c6c7fddbb3 "Fixups to ATA
> ACPI hotplug" by Matthew Garrett.
> 

Thanks. The code I was reading is 2.6.26-rc2-mm1. I should have checked the
latest kernel.

