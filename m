From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [-mm patch] drivers/ide/ide-dma.c: unexport ide_set_dma
Date: Sat, 16 Jun 2007 02:18:01 +0200
Message-ID: <200706160218.01278.bzolnier@gmail.com>
References: <20070606220313.8f7c1fab.akpm@linux-foundation.org> <20070614221642.GD3588@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:45463 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755565AbXFPARP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Jun 2007 20:17:15 -0400
Received: by ug-out-1314.google.com with SMTP id j3so970490ugf
        for <linux-ide@vger.kernel.org>; Fri, 15 Jun 2007 17:17:14 -0700 (PDT)
In-Reply-To: <20070614221642.GD3588@stusta.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Friday 15 June 2007, Adrian Bunk wrote:
> ide_set_dma no longer has any modular user.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

applied
