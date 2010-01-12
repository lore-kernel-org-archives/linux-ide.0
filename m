From: David Miller <davem@davemloft.net>
Subject: Re: icside: bring back ->maskproc method
Date: Tue, 12 Jan 2010 01:50:45 -0800 (PST)
Message-ID: <20100112.015045.64283532.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38280
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753810Ab0ALJuh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jan 2010 04:50:37 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com, rmk@arm.linux.org.uk


Applied, thanks Bart.

As per testing, reverting this change seems to put the driver closer
to a state where it was actually tested.  So I think I'll toss this to
-stable eventually.
