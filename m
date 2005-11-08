From: Mark Lord <liml@rtr.ca>
Subject: Re: sata spindown
Date: Tue, 08 Nov 2005 00:31:18 -0500
Message-ID: <43703826.2020801@rtr.ca>
References: <20051107220452.GD25098@chrislansdown.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:13509 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S965208AbVKHFbW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Nov 2005 00:31:22 -0500
In-Reply-To: <20051107220452.GD25098@chrislansdown.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christopher Lansdown <chris@powerblogs.com>
Cc: linux-ide@vger.kernel.org

Christopher Lansdown wrote:
>
> Having a laptop with a SATA hard drive (with an intel ICH6M chipset), I've
> been trying to find out the status both of spindown (a la 'hdparm -S') and
> suspend/resume....

Just keep doing it the way you have in the past:

"hdparm -C" gives the power status, and "hdparm -S" sets the spindown timeout.

This requires the "libata passthru" feature set, which most distro's patch
in by default these days.  Jeff is finally sending it upstream for future
kernels, too, and Andrew already has had it in -mm for some time now.

Cheers
