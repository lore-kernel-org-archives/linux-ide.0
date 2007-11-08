From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 13/15] ide: remove hwif->intrproc
Date: Thu, 08 Nov 2007 11:43:45 +0900
Message-ID: <473277E1.5000500@gmail.com>
References: <200710310055.13329.bzolnier@gmail.com> <4728F05A.5000502@ru.mvista.com> <47325DA0.4070905@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:45237 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbXKHCnx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Nov 2007 21:43:53 -0500
Received: by rv-out-0910.google.com with SMTP id k20so21216rvb
        for <linux-ide@vger.kernel.org>; Wed, 07 Nov 2007 18:43:52 -0800 (PST)
In-Reply-To: <47325DA0.4070905@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>, Albert Lee <albertcc@tw.ibm.com>

Mark Lord wrote:
>> Bartlomiej Zolnierkiewicz wrote:
>>
>>> * hpt366.c::hpt3xx_intrproc() is the only user of hwif->intrproc
> ..
> 
> Speaking of which..
> 
> I believe I have a small PCI card here with an HPT366 chip on it.
> Does anyone there want it before I throw it away?

I already have a 372.  It should be almost the same, right?

-- 
tejun
