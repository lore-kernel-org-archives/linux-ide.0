From: Konstantin Sobolev <kos@supportwizard.com>
Subject: Re: poor sata performance on 2.6
Date: Fri, 16 Apr 2004 01:13:10 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404160113.10553.kos@supportwizard.com>
References: <200404150236.05894.kos@supportwizard.com> <20040415195053.GP468@openzaurus.ucw.cz>
Reply-To: kos@supportwizard.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.rol.ru ([194.67.21.9]:25940 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S263574AbUDOVK1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Apr 2004 17:10:27 -0400
Received: from 81.211.110.66.adsl-spb.net.rol.ru ([81.211.110.66]:41366 "EHLO
	81.211.110.66.adsl-spb.net.rol.ru" smtp-auth: <none> TLS-CIPHER: <none>
	TLS-PEER-CN1: <none>) by gnome03.net.rol.ru with ESMTP
	id S17476630AbUDOVKY (ORCPT <rfc822;linux-ide@vger.kernel.org>
	+ 1 other); Fri, 16 Apr 2004 01:10:24 +0400
In-Reply-To: <20040415195053.GP468@openzaurus.ucw.cz>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thursday 15 April 2004 23:50, Pavel Machek wrote:
> > /dev/hde:
> >  Timing buffer-cache reads:   1436 MB in  2.00 seconds = 717.03 MB/sec
> >  Timing buffered disk reads:  100 MB in  3.03 seconds =  32.95 MB/sec
>
> 33MB/sec "totally unacceptable"? Wow.
well.. taking into account it's price and final 68MB/sec I've got after 
following Justin's advice.. :)
-- 
/KoS
* Jeez, if you love Honkus...					      
