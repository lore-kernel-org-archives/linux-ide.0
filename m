From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_piix on MacBook4,1: fail to startup in a certain situation
Date: Thu, 29 May 2008 10:45:18 +0900
Message-ID: <483E0AAE.9000307@gmail.com>
References: <20080528075106.F2C3D29C127@m02-blue.in.shared-server.net>	<20080528075747.A18A5114160@m03-blue.in.shared-server.net>	<483D1429.3080804@gmail.com>	<20080528092117.4A5177080E8@m04-blue.in.shared-server.net>	<483D6AF4.8000502@gmail.com>	<20080528225338.5FB121E0868@m06-blue.in.shared-server.net>	<483DF782.1050208@gmail.com> <20080529011256.60F8ECC0F2@m01-blue.in.shared-server.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:62313 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712AbYE2BpX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2008 21:45:23 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2780871wfd.4
        for <linux-ide@vger.kernel.org>; Wed, 28 May 2008 18:45:23 -0700 (PDT)
In-Reply-To: <20080529011256.60F8ECC0F2@m01-blue.in.shared-server.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: MATSUBAYASHI 'Shaolin' Kohji <shaolin@rhythmaning.org>
Cc: linux-ide@vger.kernel.org

MATSUBAYASHI 'Shaolin' Kohji wrote:
> At Thu, 29 May 2008 09:23:30 +0900,
> Tejun Heo wrote:
>> Hmmm.. That really doesn't make much sense.  Can you please try the
>> attached one just in case?
> 
> Still no luck - I couldn't see any progress even with this patch.
> Booting still stops during either of the followings:
> 
>         if (pci_resource_start(pdev, PIIX_SIDPR_BAR) == 0 ||
>             pci_resource_len(pdev, PIIX_SIDPR_BAR) != PIIX_SIDPR_LEN)
>                 return;
> 
> or
> 
> scontrol = piix_sidpr_read(dev0, SCR_CONTROL);
> 
> Once the AC Adapter is plugged in, booting continues fine.

With the patch applied, control should never reach either of the above
two lines.  Can you please double check?

-- 
tejun
