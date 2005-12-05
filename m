From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: mod15write
Date: Mon, 05 Dec 2005 13:24:09 -0500
Message-ID: <439485C9.30001@pobox.com>
References: <4391EC88.9010604@pobox.com> <439456EA.3000606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:58763 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932497AbVLESYM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Dec 2005 13:24:12 -0500
In-Reply-To: <439456EA.3000606@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Carlos Pardo <Carlos.Pardo@siliconimage.com>

Tejun Heo wrote:
> So, if the lock ups of 3114 are actually m15w, splitting writes into two 
> commands such that it doesn't end on a 8k or 7.5k boundary doesn't seem 
> to work.  I'll retest 3112 on the older machine and report.

sata_sil has always had lock-up reports, so don't be too quick to blame 
mod15write.  It's likely there is some other problem.

I wonder if we could get this looked at in a SATA bus analyzer...  (I 
don't have one, alas)

	Jeff


