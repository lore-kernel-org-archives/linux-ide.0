From: "i.t consulting" <i_t@thum.ath.cx>
Subject: libata's VIA SATA still fails
Date: Thu, 29 Jul 2004 10:55:10 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4108BB6E.9070801@thum.ath.cx>
References: <4103F79C.1010508@thum.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 213-172-119-022.dsl.aktivanet.de ([213.172.119.22]:35393 "EHLO
	it97.dyndns.org") by vger.kernel.org with ESMTP id S267317AbUG2Iyt
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jul 2004 04:54:49 -0400
Received: from thum.ath.cx (ithum@localhost.it97.dyndns.org [IPv6:::1])
	by it97.dyndns.org (8.13.0/8.13.0) with ESMTP id i6T8sqXl018154
	for <linux-ide@vger.kernel.org>; Thu, 29 Jul 2004 10:54:53 +0200 (CEST)
In-Reply-To: <4103F79C.1010508@thum.ath.cx>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


  hi,

  I've decided to drop you a note that
  libata's VIA SATA still fails for me on
  a MSI motherboard (KT6 delta)
  for booting
  - fedora core 2 boot cdrom
  - yoper 2.6.7-5 boot cdrom
  and
  compiling a gentoo kernel 2.6.7-mm6
  but starts successfully with a gentoo livecd kernel 2.6.0-gss

(means: libsata is not working for over 6 months!)
the sata drivers are successfully loading,
but then,
the partitions on the sata discs are not recognized fiurthermore;
there is a
lost interrupt !

  Regards
  i.t

-- 
  . ___
  |  |  Irmund     Thum
  |  |  +49 6374 992542
        +49 173 7405882
http://thum.ath.cx
     i.t-security4u
     Friedhofstr. 9
   67685 Weilerbach
