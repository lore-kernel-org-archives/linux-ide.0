From: Alexander Sabourenkov <screwdriver@lxnt.info>
Subject: Re: Sata Sil3512 bug?;  Promise SATA300 TX4
Date: Sun, 21 Oct 2007 01:50:54 +0400
Message-ID: <471A783E.9060607@lxnt.info>
References: <200710030726.l937QXuV026661@harpo.it.uu.se> <47035355.2040405@lxnt.info> <135469746.20071017143929@zonnet.nl> <47160601.80506@lxnt.info> <1785297944.20071017170444@zonnet.nl> <4717CB10.3080509@lxnt.info> <471807DF.8010100@gmail.com> <47191C3A.5040909@lxnt.info> <47194497.3040101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.lxnt.info ([217.23.143.142]:61536 "EHLO mail.lxnt.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763AbXJUCqd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Oct 2007 22:46:33 -0400
In-Reply-To: <47194497.3040101@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, MisterE <MisterE2002@zonnet.nl>, alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, jgarzik@pobox.com, jeff@garzik.org

Hello.

Tejun Heo wrote:
> 
> Does the attached patch help?
> 

It does somehow force 1.5GB/s mode, and it does change the pattern of
'configured for UDMAxxx' messages that come along with errors, and it
causes the following error:

ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xb t4
ata3: hotplug_status 0x10
ata3: soft resetting link
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3.00: configured for UDMA/133
ata3: EH complete

for both drives on TX4 on startup, but read errors are still there.

dmesgs at http://lxnt.info/linux/libata-dev/patch0/

READY
[]


-- 

./lxnt
