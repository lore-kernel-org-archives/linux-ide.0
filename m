From: Tino Keitel <tino.keitel@tikei.de>
Subject: Re: Intel X25-M and device-initiated interface power management
Date: Wed, 17 Mar 2010 12:48:23 +0100
Message-ID: <20100317114823.GA9557@mac.home>
References: <20100316220522.GA14120@x61.home>
 <4BA01E0B.5050906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eazy.amigager.de ([213.239.192.238]:50616 "EHLO
	eazy.amigager.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381Ab0CQLsa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Mar 2010 07:48:30 -0400
Received: from mac.home (port-92-206-33-132.dynamic.qsc.de [92.206.33.132])
	by eazy.amigager.de (Postfix) with ESMTPA id 3E400FA8008
	for <linux-ide@vger.kernel.org>; Wed, 17 Mar 2010 12:48:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4BA01E0B.5050906@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Tue, Mar 16, 2010 at 18:10:51 -0600, Robert Hancock wrote:

[...]

> Have a look here:
> 
> http://www.thinkwiki.org/wiki/How_to_reduce_power_consumption#SATA_Link_Power_Management
> 
> Replace host0, host1, etc. with the appropriate numbers..

I set it to max_performance for all scsi_host sysfs entries, but the
DIPM feature in hdparm -I was still shown es enabled.  So this can't be
the reason for the disabled DIPM I saw in the google hits.

Regards,
Tino
