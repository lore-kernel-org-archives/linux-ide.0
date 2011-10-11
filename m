From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: ide_port_wait_ready() fix
Date: Tue, 11 Oct 2011 15:17:39 -0400 (EDT)
Message-ID: <20111011.151739.917285592017305911.davem@davemloft.net>
References: <201110111913.18492.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:34289 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198Ab1JKTRn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Oct 2011 15:17:43 -0400
In-Reply-To: <201110111913.18492.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Tue, 11 Oct 2011 19:13:18 +0200

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: ide_port_wait_ready() fix
> 
> Fix for commit a20b2a4 ("ide: skip probe if there are no devices on
> the port (v2)").  We must check for slave device before failing.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This will mishandle the case where there is no slave in the device
list.
