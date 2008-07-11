From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Dubious IRQ masking in ide_config_drive_speed()
Date: Fri, 11 Jul 2008 23:44:30 +0200
Message-ID: <200807112344.30990.bzolnier@gmail.com>
References: <200711290104.21376.bzolnier@gmail.com> <200807112139.31353.bzolnier@gmail.com> <48767D6D.6000009@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:14294 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbYGJVt3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jul 2008 17:49:29 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1738371ywe.1
        for <linux-ide@vger.kernel.org>; Thu, 10 Jul 2008 14:49:10 -0700 (PDT)
In-Reply-To: <48767D6D.6000009@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Mikhail Cherkashin <mcherkashin@ru.mvista.com>

On Thursday 10 July 2008, you wrote:

[...]

>    BTW, I was counting on your feedback concerning driver->quirk_list 
> handling.

Done, please see the other mail.

Sorry for the delay, I needed to find some "straight" time to calmly
recall/recheck/rethink all issues related to ->quirk_list.  

>    Do you think the current patch for ide_driveid_update() is acceptable?

I applied it, didn't I? :)

Thanks,
Bart
