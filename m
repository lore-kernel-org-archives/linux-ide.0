From: David Miller <davem@davemloft.net>
Subject: Re: revert request "ide: skip probe if there are no devices on the
 port (v2)"
Date: Sun, 28 Mar 2010 18:59:45 -0700 (PDT)
Message-ID: <20100328.185945.253510769.davem@davemloft.net>
References: <20100328212728.GA2674@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41415
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755557Ab0C2B7V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Mar 2010 21:59:21 -0400
In-Reply-To: <20100328212728.GA2674@spacedout.fries.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: david@fries.net
Cc: bzolnier@gmail.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

From: David Fries <david@fries.net>
Date: Sun, 28 Mar 2010 16:27:28 -0500

> Now that I have 2.6.34-rc2 booting it no longer detects the cdrom
> drive.  That is looking at the kernel messages, partition dump, and
> after booting hdparm etc does not find the drive.  I expect it is
> because the cdrom is a slave drive without a master on that ribbon.
> Reverting

Reverted, thanks for the report David.
