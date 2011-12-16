From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: JMicron Technology JMB362 JMB363 SError: { DevExch }
 ExpressCard, sometimes fails to boot
Date: Fri, 16 Dec 2011 03:58:53 -0600
Message-ID: <20111216095853.GC5974@elie.hsd1.il.comcast.net>
References: <26E173AF030F44F8817F60B0D882E440@jmicron.com>
 <201112160255.pBG2tqEd003330@jmr105.jmicron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46490 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab1LPJ66 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Dec 2011 04:58:58 -0500
Received: by yenm11 with SMTP id m11so2070476yen.19
        for <linux-ide@vger.kernel.org>; Fri, 16 Dec 2011 01:58:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201112160255.pBG2tqEd003330@jmr105.jmicron.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Orson' <orson.wellies@gmail.com>
Cc: Show lu <showlu@jmicron.com>, 'Steven Chen' <stevenchen@jmicron.com>, linux-ide@vger.kernel.org, 'Tejun Heo' <tj@kernel.org>, 'Aries Lee' <arieslee@jmicron.com>

Show lu wrote:

> Please help to shows the PCIE CFG registers(of JMB36X) at first.

Thanks, Show.

Orson, running "lspci -vvnn -d 197b:2363" as root should do the trick.
