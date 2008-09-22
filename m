From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] IDE-TAPE NULL terminate strings.
Date: Mon, 22 Sep 2008 17:16:45 +0400
Message-ID: <48D79ABD.8060805@ru.mvista.com>
References: <20080921185138.GA16310@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:10734 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752047AbYIVNPv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Sep 2008 09:15:51 -0400
In-Reply-To: <20080921185138.GA16310@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark de Wever <koraq@xs4all.nl>
Cc: Gadi Oxman <gadio@netvision.net.il>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Mark de Wever wrote:

> After updating my kernel to 2.6.26 the output for the ide-tape drive
> during booting is garbled eg
> ide-tape: hdd <-> ht0: Seagate <98>=DF8A51|1=C0<81>=DC=BA<98>=DF STT2=
0000A rev 8A51|1=C0<81>=DC=BA<98>=DF

> This patch fixes the problem by NULL terminating the strings.

    Looks like this bugs was introduced by this commit:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=3D41f81d545b6b1f585a02d1d8545978714f710e91

MBR, Sergei
