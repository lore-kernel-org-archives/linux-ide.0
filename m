From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [RFC PATCH 08/15] ata: ahci_platform: Manage SATA PHY
Date: Sun, 22 Sep 2013 22:24:36 +0400
Message-ID: <523F35E4.6050707@cogentembedded.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com> <1379595943-14622-9-git-send-email-rogerq@ti.com> <20130922165817.GD30946@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:50693 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258Ab3IVSYk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Sep 2013 14:24:40 -0400
Received: by mail-la0-f43.google.com with SMTP id ep20so1896160lab.30
        for <linux-ide@vger.kernel.org>; Sun, 22 Sep 2013 11:24:39 -0700 (PDT)
In-Reply-To: <20130922165817.GD30946@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Roger Quadros <rogerq@ti.com>, balbi@ti.com, bcousson@baylibre.com, tony@atomide.com, balajitk@ti.com, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

Hello.

On 09/22/2013 08:58 PM, Tejun Heo wrote:

>> From: Balaji T K <balajitk@ti.com>

>> Some platforms have a PHY hooked up to the
>> SATA controller. The PHY needs to be initialized
>> and powered up for SATA to work. We do that
>> using the PHY framework.

>> [Roger Q] Cleaned up.

>> CC: Tejun Heo <tj@kernel.org>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>

> Looks okay to me although I don't know whether everyone using
> ahci_platform would be happy with requiring phy.  Sergei, does this
> look good to you?

    Not sure why you asked -- I'm not using this driver, neither I'm the 
author of it (former MV's Anton Vorontsov is IIRC). I've commented on the 
patch anyway though...

> Thanks.

WBR, Sergei

