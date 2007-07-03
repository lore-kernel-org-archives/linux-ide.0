From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/1] ide: pdc202xx_new PLL input clock fix
Date: Tue, 3 Jul 2007 20:57:25 +0200
Message-ID: <200707032057.25295.bzolnier@gmail.com>
References: <7ac1e90c0706210447k7c1bdb26y43d62e930ce7728e@mail.gmail.com> <46893D48.3060801@ru.mvista.com> <4689DCF5.3040809@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:7713 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757054AbXGCU0q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 16:26:46 -0400
Received: by py-out-1112.google.com with SMTP id u77so3464599pyb
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 13:26:46 -0700 (PDT)
In-Reply-To: <4689DCF5.3040809@tw.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bahadir Balban <bahadir.balban@gmail.com>, linux-ide@vger.kernel.org

On Tuesday 03 July 2007, Albert Lee wrote:
> Recently the PLL input clock of Promise 2027x is sometimes detected
> higer than expected (e.g. 20.027 MHz compared to 16.714 MHz).
> It seems sometimes the mdelay() function is not as precise as it
> used to be. Per Alan's advice, HT or power management might affect
> the precision of mdelay().
> 
> This patch calls gettimeofday() to mesure the time elapsed and
> calculate the PLL input clock accordingly.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

applied, thanks!
