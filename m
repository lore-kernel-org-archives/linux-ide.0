From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PROBLEM: Silicon Image 3112 Lockups
Date: Wed, 07 Sep 2005 02:09:29 -0400
Message-ID: <431E8419.9010201@pobox.com>
References: <Pine.LNX.4.63.0509061835230.2270@xmission.xmission.com> <431E4A0A.3060504@gmail.com> <431E4CDA.6090909@pobox.com> <431E519A.2090905@gmail.com> <431E5380.8010601@gmail.com> <Pine.LNX.4.63.0509062102290.11772@xmission.xmission.com> <431E81E3.50904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:8684 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750777AbVIGGJj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Sep 2005 02:09:39 -0400
In-Reply-To: <431E81E3.50904@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeremy Smith <alceste@xmission.com>, Alexander Shaposhnikov <shaposh@isp.nsc.ru>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Paul Taylor <Paul.Taylor@siliconimage.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
>  I don't know.  If some specific configurations are required for the 
> controller, they are usually done by BIOS (either mainboard BIOS or 
> per-controller BIOS), so BIOS update could affect the problem.  But 
> these are still just wild speculations.  Maybe we should contact ASUS 
> about this?


Note that, in the past,  system BIOS updates have cured sata_sil data 
corruption bug reports.  Updating BIOS is always a good idea.

	Jeff


