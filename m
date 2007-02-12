From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_via: fix resource-managed iomap conversion
Date: Mon, 12 Feb 2007 12:10:08 -0800
Message-ID: <45D0C9A0.1030707@gmail.com>
References: <20070210010914.GA19717@havoc.gtf.org> <20070210054629.GA4395@gentoox2.trippelsdorf.de> <45CF93D1.9080009@gmail.com> <20070212025843.GA4406@gentoox2.trippelsdorf.de> <45D0B740.9050704@gmail.com> <20070212193302.GA5003@gentoox2.trippelsdorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:14957 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965287AbXBLUKS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Feb 2007 15:10:18 -0500
Received: by py-out-1112.google.com with SMTP id a29so900466pyi
        for <linux-ide@vger.kernel.org>; Mon, 12 Feb 2007 12:10:17 -0800 (PST)
In-Reply-To: <20070212193302.GA5003@gentoox2.trippelsdorf.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Markus Trippelsdorf wrote:
> On Mon, Feb 12, 2007 at 10:51:44AM -0800, Tejun Heo wrote:
>> Conversion to resource-managed iomap was buggy causing init failures
>> on both vt6420 and 6421 - BAR5 wasn't mapped for both controllers
>> while on vt6420 sata_via tried to map BAR0-4 twice.  Fix it.

Great, can anyone verify this on vt6421?

-- 
tejun
