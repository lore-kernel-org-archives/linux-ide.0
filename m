From: Tejun Heo <htejun@gmail.com>
Subject: Re: (Another?) Seagate / Sil3112a problem...
Date: Mon, 08 Jan 2007 12:52:32 +0900
Message-ID: <45A1C000.7080500@gmail.com>
References: <J5J0S1$E84BD2336C01F896088E954AAF120859@laposte.net> <20061109135956.b744a3a7.akpm@osdl.org> <200701071704.36288.philippe.grenard@m4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:3593 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030481AbXAHDwj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jan 2007 22:52:39 -0500
Received: by wx-out-0506.google.com with SMTP id h27so7898798wxd
        for <linux-ide@vger.kernel.org>; Sun, 07 Jan 2007 19:52:38 -0800 (PST)
In-Reply-To: <200701071704.36288.philippe.grenard@m4x.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: philippe.grenard@m4x.org
Cc: Andrew Morton <akpm@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org

Hello,

[cc'ing lkml and linux-ide]

Philippe Grenard wrote:
> To "close" this problem, here are the latest news :
> I just bought some new power supply, and the problem has gone...
> Maybe that was due to poor power flow or crappy connexion ?...
> 
> now everything seems to work well, so as suspected, it was probably hardware 
> problem.
> 
> Sorry for that "false alarm", thanks again for everything, and keep up the 
> good work!

Ah... so it was another one of those PSU problems.  This problem is
becoming more prevalent these days.  Dual 12v lane PSUs suck for driving
a lot of disks.  They don't seem to allocate enough power to molex/sata
connectors.

-- 
tejun
