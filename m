From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3] sata_fsl: reduce compatibility to fsl,pq-sata
Date: Mon, 31 Mar 2008 21:15:48 -0500
Message-ID: <F555823E-5333-4DD3-9816-FAEC5EFD1649@kernel.crashing.org>
References: <20080328105133.43eb4fb1.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:37905 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018AbYDACQH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Mar 2008 22:16:07 -0400
In-Reply-To: <20080328105133.43eb4fb1.kim.phillips@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, jgarzik@pobox.com


On Mar 28, 2008, at 10:51 AM, Kim Phillips wrote:
> as prescribed in Documentation/powerpc/booting-without-of.txt.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> Cc: Jeff Garzik <jgarzik@pobox.com>
> ---
> arch/powerpc/boot/dts/mpc8377_mds.dts |    4 ++--
> arch/powerpc/boot/dts/mpc8379_mds.dts |    8 ++++----
> drivers/ata/sata_fsl.c                |    5 +----
> 3 files changed, 7 insertions(+), 10 deletions(-)

applied.

- k
