From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: WD20EARS: finally reporting 4KByte sector size!
Date: Wed, 18 May 2011 17:43:40 -0500
Message-ID: <4DD44B9C.1050809@hardwarefreak.com>
References: <4DD0A00D.3030104@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:46624 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643Ab1ERWnn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 May 2011 18:43:43 -0400
In-Reply-To: <4DD0A00D.3030104@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On 5/15/2011 10:54 PM, Mark Lord wrote:
> I picked up my third WD 2TB "Green" drive today,
> and lo and behold.. the firmware (51.0AB51) actually
> reports the real physical sector size (finally!).

>         Logical  Sector size:                   512 bytes
>         Physical Sector size:                  4096 bytes

What is the positive significance of this change?  What does this
materially change for the better?

-- 
Stan
