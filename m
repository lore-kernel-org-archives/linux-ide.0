From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) ide_get_best_pio_mode() returns incorrect IORDY setting (take 2)
Date: Sat, 10 Feb 2007 01:12:40 +0100
Message-ID: <200702100112.40911.bzolnier@gmail.com>
References: <200702081632.43844.sshtylyov@ru.mvista.com> <200702081657.39757.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:54845 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423376AbXBJAHa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Feb 2007 19:07:30 -0500
Received: by ug-out-1314.google.com with SMTP id 44so94192uga
        for <linux-ide@vger.kernel.org>; Fri, 09 Feb 2007 16:07:29 -0800 (PST)
In-Reply-To: <200702081657.39757.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


On Thursday 08 February 2007 14:57, Sergei Shtylyov wrote:
> The function ide_get_best_pio_mode() fails to return the correct IORDY setting
> for the explicitly specified modes -- fix this along with the heading comment,
> and also remove the long commented out code.
> 
> Also, while at it, correct the misliading comment about the PIO cycle time in
> <linux/ide.h> -- it actually consists of only the active and recovery periods,
> with only some chips also including the address setup time into equation...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
