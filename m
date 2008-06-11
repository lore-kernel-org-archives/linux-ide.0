From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Promise SATA300 TX4
Date: Wed, 11 Jun 2008 10:03:17 +0200
Message-ID: <18511.34501.593196.761308@harpo.it.uu.se>
References: <1067206692.20080610231140@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:35583 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753939AbYFKIDr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Jun 2008 04:03:47 -0400
In-Reply-To: <1067206692.20080610231140@zonnet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: MisterE <MisterE2002@zonnet.nl>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Alexander Sabourenkov <screwdriver@lxnt.info>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Tue, 10 Jun 2008 23:11:40 +0200, MisterE wrote:
>Hello,
>
>A long while ago we had contact about corruption with this
>controller. Then you people found the ASIC PRD bug.
>
>When the 2.6.24 kernel was released i made a custom version for my
>debian fileserver. It's now running for a while without real problems.
>
>But now and then i get a message in my log which concerns me. I can't
>reproduce them but mass actions (copy, move, delete, etc.) does not
>seem to cause it.
>
>Example:
>
>
>Mar 24 14:27:59 fileserver -- MARK --
>Mar 24 14:47:59 fileserver -- MARK --
>Mar 24 15:07:59 fileserver -- MARK --
>Mar 24 15:22:59 fileserver kernel:          res 50/00:00:3e:3f:db/00:00:2=
>a:00:00/e0 Emask 0x2 (HSM violation)
>Mar 24 15:22:59 fileserver kernel: ata1: soft resetting link
>Mar 24 15:22:59 fileserver kernel: ata1: SATA link up 3.0 Gbps (SStatus 1=
>23 SControl 300)
>Mar 24 15:22:59 fileserver kernel: ata1.00: configured for UDMA/133
>Mar 24 15:22:59 fileserver kernel: ata1: EH complete

Occasional hickups like these can be caused by inadequate
power-supply units. Nothing driver-related comes to mind.

/Mikael
