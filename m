From: Florian Effenberger <florian@effenberger.org>
Subject: Re: libata interface fatal error
Date: Thu, 14 Jun 2007 17:12:27 +0200
Message-ID: <46715ADB.4020202@effenberger.org>
References: <46580134.7010107@effenberger.org> <465BEF50.8050207@gmail.com> <466725E5.9030405@effenberger.org> <4667D4F5.1060302@gmail.com> <466FC901.4060907@effenberger.org> <46710DDC.1030900@gmail.com> <467122B8.1090206@effenberger.org> <467133D7.7070000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from garfield.effenberger.org ([85.214.43.221]:33474 "EHLO
	garfield.effenberger.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbXFNPMb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jun 2007 11:12:31 -0400
In-Reply-To: <467133D7.7070000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Hi Tejun,

> Okay, ich8.  I don't think the chipset is at fault here and you have a
> lot of disks.  My primary suspect is power supply problem but things
> like this are hard to prove.  With the merged speed down fix, libata
> will do the right thing after a few errors, so ignoring the problem
> wouldn't be a too bad idea.  If you're curious, you can try to connect
> drives to different SATA ports and power lanes and see whether errors
> follow the disk, port or power lane.

exactly, should be four disks in the machine.

What power supply would you recommend for this type of disks? I think we 
got a 450W Enermax, IIRC.

What do you mean by "merged speed down fix"? Is your fix for the speed 
down logic implemented in the current kernel, so I don't have to patch 
anymore (except when I want to force 1.5Gbps right from the beginning)?

All SATA parts are used, so reconnecting is not an option. But I can try 
to switch the power supply (lanes).

Thanks for all your kind help, that is much appreciated!
Florian
