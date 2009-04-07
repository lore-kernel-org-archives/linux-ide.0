From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ata_piix: VGN-BX297XP wants the controller
 power up on suspend
Date: Mon, 06 Apr 2009 20:01:48 -0400
Message-ID: <49DA97EC.7040600@garzik.org>
References: <49D17582.7090208@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42346 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbZDGABy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Apr 2009 20:01:54 -0400
In-Reply-To: <49D17582.7090208@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, GNUtoo@no-log.org

Tejun Heo wrote:
> Sony VGN-BX297XP fails suspend if the controller is powered down when
> calling into ACPI suspend.  Add the machine to piix_broken_suspend
> list.
> 
> This problem was reported by GNUtoo@no-log.org on bko#10293.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Reported-by: GNUtoo@no-log.org

applied


