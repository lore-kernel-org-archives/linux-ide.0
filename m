From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/3] ide-tape: convert to ide_debug_log macro
Date: Tue, 21 Jul 2009 20:46:05 -0700 (PDT)
Message-ID: <20090721.204605.119697841.davem@davemloft.net>
References: <1247910917-5237-1-git-send-email-petkovbb@gmail.com>
	<1247910917-5237-3-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42704
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755940AbZGVDp7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jul 2009 23:45:59 -0400
In-Reply-To: <1247910917-5237-3-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Borislav Petkov <petkovbb@googlemail.com>
Date: Sat, 18 Jul 2009 11:55:16 +0200

> Remove tape->debug_mask and use drive->debug_mask instead.
> 
> There should be no functional change resulting from this patch.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

Applied.
