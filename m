From: Richard Kennedy <richard@rsk.demon.co.uk>
Subject: Re: [PATCH] libata: reorder ata_queued_cmd to remove alignment
 padding on 64 bit builds
Date: Sun, 12 Sep 2010 12:21:21 +0100
Message-ID: <1284290481.1923.14.camel@castor.rsk>
References: <1284117583.1903.8.camel@castor.rsk>
	 <4C8A3F1E.8050400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:61861 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752755Ab0ILLVX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Sep 2010 07:21:23 -0400
In-Reply-To: <4C8A3F1E.8050400@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hugo Antunes <hugo.antunes@gmail.com>
Cc: jgarzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Fri, 2010-09-10 at 15:22 +0100, Hugo Antunes wrote:
> Greetings,
> 
> Following the list this pasts days, building a big machine with 45
> sata2 disks (WD green 1.5TB), Sil3124 4 ports sata2 with 9 port
> multipliers with 5 each also from Silicom image.
> 
> This machine should smoke but it doesn't, attached is the dmesg dump where it is possible to see the enourmous ammount
>  of hard and soft resets.Using Ubuntu/server 10.4 2.6.32-25-server x86_64, been questioning if this patch could 
> make me have better numbers from this system, going to build a debian/ubuntu kernel image with the patch, if anyone 
> has a link for a deb image with this patch..apreciated.
> 
> Keep the good work
> 
> Regards,
> ./hantunes
Hi,
I think it's very unlikely that my patch will have any impact on your
problem, it is only a very minor improvement when creating new ports.

I didn't get the dmesg attachment so I can't tell what sort of problems
you are having, but with that many drives I'd start by checking the
power supplies & cables and then try the latest kernel. 

regards
Richard



