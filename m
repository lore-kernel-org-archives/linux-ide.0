From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/9] sl82c105: remove dead code
Date: Mon, 12 Jan 2009 00:14:39 +0300
Message-ID: <496A613F.5090901@ru.mvista.com>
References: <20090106183520.21193.63704.sendpatchset@localhost.localdomain> <20090106183526.21193.24866.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:13209 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753081AbZAKVOo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jan 2009 16:14:44 -0500
In-Reply-To: <20090106183526.21193.24866.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev list <Linuxppc-dev@ozlabs.org>

Hello.

Bartlomiej Zolnierkiewicz wrote:

> CONFIG_LOPEC and CONFIG_SANDPOINT config options are gone.
>   

  So these are gone with arch/ppc/?
  That's a pity -- MV has spent a lot of efforts on porting the latter 
to arch/powerpc/ but somehow it haven't got merged upstream. My patches 
ot this driver were actually due to it being used on Sandpoint. :-)

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


