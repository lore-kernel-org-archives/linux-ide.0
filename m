From: Alexander Sabourenkov <screwdriver@lxnt.info>
Subject: Re: Sata Sil3512 bug?
Date: Mon, 15 Oct 2007 12:44:01 +0400
Message-ID: <47132851.5050409@lxnt.info>
References: <200710030726.l937QXuV026661@harpo.it.uu.se> <47035355.2040405@lxnt.info> <1398538486.20071014140703@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.lxnt.info ([217.23.143.142]:59921 "EHLO mail.lxnt.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753564AbXJOJTy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Oct 2007 05:19:54 -0400
In-Reply-To: <1398538486.20071014140703@zonnet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: MisterE <MisterE2002@zonnet.nl>
Cc: Mikael Pettersson <mikpe@it.uu.se>, htejun@gmail.com, alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

MisterE wrote:
> Hello,
> 
> Alexander, does these problems with the Promise SATA300 TX4 happen to
> everyone?
> 

Most probably not, as I think it would have been fixed much faster then.

I was waiting for a) release of 2.6.23, and b) me completing the move to 
another flat
to retest all the latest developments in mainline and libata-dev.

With a) done and b) almost done, I'll retest and report any issues quite 
soon.

Besides, there is a report of TX4 and 2.6.23 not showing problems that 
were there with 2.6.22,
( see "Bug is fixed in 2.6.23.1: sata_promise: port is slow to respond, 
reset failed" thread).


> The only alternatives are
> using soft-raid products as normal controllers. Does anyone have experiences
> with the following products?
> * Highpoint RocketRAID 1640 (150 MB/s)
> * Highpoint RocketRAID 1740 (300 MB/s)
> * Adaptec 1210SA
> 

For any kind of non-hobby task I'd skip trying to build a disk array to 
buying a SATA-SCSI/SATA-iSCSI box.
While I had many mind-boggling issues with various combinations of SATA 
HDDs, onboard and standalone
controllers, Promise and Infortrend disk arrays worked quite reliably.

-- 

./lxnt
