From: Tigran Aivazian <tigran@veritas.com>
Subject: Re: question about SATA and IDE DVD/CD drives.
Date: Fri, 2 Jul 2004 17:56:24 +0100 (BST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0407021745400.2190-100000@einstein.homenet>
References: <40E5817D.4000408@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pengo.systems.pipex.net ([62.241.160.193]:29384 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S264726AbUGBQ5s (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jul 2004 12:57:48 -0400
In-Reply-To: <40E5817D.4000408@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Fri, 2 Jul 2004, Jeff Garzik wrote:
> Enable CONFIG_IDE, and disable CONFIG_BLK_DEV_IDE_SATA, and that will 
> fix things I bet.

Tried this as well on the latest snapshot (2.6.7-bk9) and it failed as 
well. Namely, SATA disk works fine but IDE subsystem doesn't see the DVD 
drive.

Are you sure that I only need to enable CONFIG_IDE and not some of the
other IDE options (disk, cdrom, chipset-specific etc)?

Kind regards
Tigran


