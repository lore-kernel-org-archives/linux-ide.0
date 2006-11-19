From: Nicolas DET <nd@bplan-gmbh.de>
Subject: Re: [PATCH/RFC] ata: Add support for the MPC52xx ATA controller using libata
Date: Sun, 19 Nov 2006 20:14:09 +0100 (MET)
Message-ID: <20061119201411.b5dd5dd5.nd@bplan-gmbh.de>
References: <11637151391017-git-send-email-tnt@246tNt.com>	<200611172049.49260.jarno.manninen@tut.fi>	<455E0907.8000009@246tNt.com>	<455E3A7E.3030807@garzik.org>	<455E4406.8050405@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:37580 "EHLO
	mo-p07-ob.rzone.de") by vger.kernel.org with ESMTP id S933038AbWKSTO5
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Nov 2006 14:14:57 -0500
In-Reply-To: <455E4406.8050405@246tNt.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sylvain Munaut <tnt@246tNt.com>
Cc: Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Sven Luther <sl@bplan-gmbh.de>, linuxppc-embedded@ozlabs.org

On Sat, 18 Nov 2006 00:21:42 +0100
Sylvain Munaut <tnt@246tNt.com> wrote:


> Aside from that, does the driver looks ok ? It has been tested ok on another
> 5200b platform as well. I'd like to include it in a patch set I'll probably
> send next weekend. I'll try to add the timing computation to the generic
> call and make use of those.
> 
> 

I succefully tested the driver on Efika 5k2: I booted my root fs and did 2 min badblocks. No problems.

Regards,
