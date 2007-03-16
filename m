From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Sat, 17 Mar 2007 00:05:45 +0300
Message-ID: <45FB06A9.7080301@ru.mvista.com>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>	<45F56800.3040104@rtr.ca>	<3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com>	<45F5A523.1080500@rtr.ca>	<45FA8D7A.3040504@rtr.ca>	<45FAA35C.2090902@ru.mvista.com>	<45FAA822.7050208@rtr.ca>	<45FAAACE.6000503@ru.mvista.com>	<45FAACD4.6000709@rtr.ca>	<45FAAD11.9010905@rtr.ca>	<45FAB662.2040901@ru.mvista.com> <20070316170802.227ff58b@lxorguk.ukuu.org.uk> <45FAE7F3.7050201@pobox.com> <45FAFB24.2050800@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:35714 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965927AbXCPVGE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 17:06:04 -0400
In-Reply-To: <45FAFB24.2050800@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mikael Pettersson <mikpe@it.uu.se>

Hello.

Mark Lord wrote:

> I've tested ATA1 and newer PATA drives, and various SATA drives
> with these commands without bothering to drop to PIO0,
> and none of them had issues.

    Of course -- that PIO0 warning was for the sake of "some ATA-1 drives". :-)

> Cheers

MBR, Sergei
