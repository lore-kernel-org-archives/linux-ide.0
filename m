From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata interface fatal error
Date: Mon, 18 Jun 2007 16:13:46 +0900
Message-ID: <467630AA.5050108@gmail.com>
References: <200706180705.l5I75U6r000348@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.228]:19387 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757323AbXFRHNw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 03:13:52 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1290899nzf
        for <linux-ide@vger.kernel.org>; Mon, 18 Jun 2007 00:13:51 -0700 (PDT)
In-Reply-To: <200706180705.l5I75U6r000348@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Tomi.Orava@ncircle.nullnet.fi, florian@effenberger.org, jeff@garzik.org, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> Yes, this is familiar. Several people have reported problems with
> Seagate's 7200.10 disks in 3Gbps operation on sata_promise.
> Unfortunately the error reports don't really give a clue as to what
> the root cause is.
> 
> I used to be able to forcibly trigger similar errors with their
> 7200.9 disks, but I can't seem to do that any more.

Maybe we need to limit link speed to 1.5Gbps for these drives on
sata_promise?

-- 
tejun
