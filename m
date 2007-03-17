From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] jmicron: make ide jmicron driver play nice with libata ones
Date: Sat, 17 Mar 2007 21:36:20 +0100
Message-ID: <200703172136.20784.bzolnier@gmail.com>
References: <20070316060610.GA6152@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:38802 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbXCQVBp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Mar 2007 17:01:45 -0400
Received: by ug-out-1314.google.com with SMTP id 44so986749uga
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 14:01:43 -0700 (PDT)
In-Reply-To: <20070316060610.GA6152@htj.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, justin@jmicron.com


On Friday 16 March 2007, Tejun Heo wrote:
> When libata is configured, the device is configured such that SATA and
> PATA ports live in separate functions with different programming
> interfaces.  pata_jmicron and ide jmicron drivers can drive only the
> PATA part.
> 
> This patch makes jmicron match PCI class code such that it doesn't
> attach itself to the SATA part preventing the proper ahci driver from
> attaching.
> 
> This change is suggested by Bartlomiej.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

applied, thanks
