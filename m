From: Tejun Heo <htejun@gmail.com>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Fri, 07 Sep 2007 03:02:45 +0900
Message-ID: <46E040C5.1060509@gmail.com>
References: <46D2595B.1030409@sauce.co.nz> <46D2792B.401@vc.cvut.cz> <46DBCCE9.9080806@gmail.com> <46DBDA84.3050505@vc.cvut.cz> <46DC030E.9070704@gmail.com> <46DCB709.902@vc.cvut.cz> <46DE9C20.9030007@vc.cvut.cz> <20070905213006.GH22695@curie-int.orbis-terrarum.net> <46DFCDF0.6050107@vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:9044 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755672AbXIFSES (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Sep 2007 14:04:18 -0400
Received: by rv-out-0910.google.com with SMTP id k20so205926rvb
        for <linux-ide@vger.kernel.org>; Thu, 06 Sep 2007 11:04:17 -0700 (PDT)
In-Reply-To: <46DFCDF0.6050107@vc.cvut.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, linux-ide@vger.kernel.org, Richard Scobie <richard@sauce.co.nz>

Petr Vandrovec wrote:
> Concurrent hdparm -t, like
> 
> hdparm -t /dev/sdd & hdparm -t /dev/sde & hdparm -t /dev/sdf & hdparm -t
> /dev/sdg & sleep 20
> 
> (and from hdparm output & visually confirmed that all activity LEDs go
> on & off simultaneously)

Not sure whether it matters but 'hdparm' tests are fairly short.  You
can probably get more reliable result using dd with direct flag specified.

> So NCQ should not be able to show any (definitely not huge) benefits,
> but there should not be any reason to not get 4x 1 drive speed as long
> as neither PMP link nor PCI-X limits are hit.

As said before, 3124/32 hardware seems to have limitations in transfer
rate it can reach.

Thanks.

-- 
tejun
