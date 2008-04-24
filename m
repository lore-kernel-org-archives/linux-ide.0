From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci: retry enabling AHCI a few times before spitting
 out WARN_ON()
Date: Thu, 24 Apr 2008 10:34:50 +0900
Message-ID: <480FE3BA.9020508@gmail.com>
References: <480F231A.7020401@gmail.com> <200804240224.09518.volker.armin.hemmann@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:25742 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbYDXBfD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 21:35:03 -0400
Received: by py-out-1112.google.com with SMTP id u52so4656462pyb.10
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 18:34:58 -0700 (PDT)
In-Reply-To: <200804240224.09518.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Peer Chen <pchen@nvidia.com>

Volker Armin Hemmann wrote:
> Hi,
> 
> patch -p1 <  ../ahci.patch
> patching file drivers/ata/ahci.c
> Hunk #1 FAILED at 556.
> 1 out of 1 hunk FAILED -- saving rejects to file drivers/ata/ahci.c.rej

Have you backed out the original patch?  It works fine here.

-- 
tejun
