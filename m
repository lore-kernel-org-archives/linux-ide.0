From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] hpt366: remove dead old timing tables
Date: Wed, 18 Nov 2009 10:38:48 -0800 (PST)
Message-ID: <20091118.103848.39318908.davem@davemloft.net>
References: <200911181932.07651.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49230
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754738AbZKRSic (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Nov 2009 13:38:32 -0500
In-Reply-To: <200911181932.07651.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: sshtylyov@ru.mvista.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Wed, 18 Nov 2009 19:32:07 +0100

> It has been enough time since introduction of the new timing tables
> (commit 809b53c from Dec 12 2007) and the old timing tables are still
> available in pata_hpt37x.c (or git history) if somebody needs them.
> 
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied to ide-next-2.6, thanks.
