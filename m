From: Aron Rubin <arubin@atl.lmco.com>
Subject: Re: [PATCH] Silicon image 3114 SATA link (really basic support)
Date: Tue, 09 Dec 2003 13:22:26 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3FD612E2.90607@atl.lmco.com>
References: <20031203204445.GA26987@gtf.org> <200312051842.26599.marchand@kde.org> <3FD0C4B0.8020106@pobox.com> <200312051907.13727.marchand@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [192.35.37.50] ([192.35.37.50]:42222 "EHLO
	enterprise.atl.lmco.com") by vger.kernel.org with ESMTP
	id S266042AbTLISWh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Dec 2003 13:22:37 -0500
In-Reply-To: <200312051907.13727.marchand@kde.org>
List-Id: linux-ide@vger.kernel.org
To: Mickael Marchand <marchand@kde.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mickael Marchand wrote:
> here it is ;) (for 2.6.0-test11)
> it includes patches in siimage.c but it did not work IIRC (lost interrupt).
> (don't compile siimage inside the kernel, it would not boot)

Your messages seem to be conflicting. Does this work or not or just 
enough to see messages? I am dealing with the same exact thing for the 
3512 chipset.

Aron


-- 

ssh aron@rubinium.org cat /dev/brain | grep ^work:

Aron Rubin                       Member, Engineering Staff
Lockheed Martin                  E-Mail: arubin@atl.lmco.com
Advanced Technology Laboratories Phone:  856.792.9865
3 Executive Campus               Fax:    856.792.9930
Cherry Hill, NJ USA 08002        Web:    http://www.atl.lmco.com

