From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Fix a theoretical Ooops case
Date: Sat, 23 Jun 2007 19:41:46 +0200
Message-ID: <200706231941.46092.bzolnier@gmail.com>
References: <20070622142005.7a20d4c4@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:28198 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871AbXFWRwq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 13:52:46 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1019617ugf
        for <linux-ide@vger.kernel.org>; Sat, 23 Jun 2007 10:52:45 -0700 (PDT)
In-Reply-To: <20070622142005.7a20d4c4@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

On Friday 22 June 2007, Alan Cox wrote:
> Found by a static analyser. It is in theory possible we dereference
> dev->id when it has become invalid. Re-order to avoid this.
> 
> Not needed for new-ide as we no longer support the crazy exabyte nest stuff
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied
