From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: disable drive interrupts in ide_driveid_update()
Date: Fri, 11 Jul 2008 21:11:32 +0200
Message-ID: <200807112111.33084.bzolnier@gmail.com>
References: <200807092048.48078.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:60120 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431AbYGJTXj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jul 2008 15:23:39 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1178258yxm.1
        for <linux-ide@vger.kernel.org>; Thu, 10 Jul 2008 12:23:38 -0700 (PDT)
In-Reply-To: <200807092048.48078.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, mcherkashin@ru.mvista.com

On Wednesday 09 July 2008, Sergei Shtylyov wrote:
> From: Mikhail Cherkashin <mcherkashin@ru.mvista.com>
> 
> Since ide_driveid_update() uses polling to execute the IDENTIFY DEVICE command
> but clears nIEN bit in the control register and doesn't mask the IDE interrupt,
> the latter does happen and lead to the corresponding message to appear:
> 
> ide0: unexpected interrupt, status=0x58, count=1
> 
> when e.g. running hdparm with option -X with a non-PCI IDE driver...
> 
> Signed-off-by: Mikhail Cherkashin <mcherkashin@ru.mvista.com>
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
