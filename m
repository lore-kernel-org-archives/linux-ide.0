From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2.6 patch] IDE: possible cleanups
Date: Thu, 3 Feb 2005 00:21:30 +0100
Message-ID: <58cb370e05020215213206ccfc@mail.gmail.com>
References: <20050131190154.GB18316@stusta.de>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.200]:32097 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262823AbVBBXVc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2005 18:21:32 -0500
Received: by wproxy.gmail.com with SMTP id 67so156347wri
        for <linux-ide@vger.kernel.org>; Wed, 02 Feb 2005 15:21:30 -0800 (PST)
In-Reply-To: <20050131190154.GB18316@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, 31 Jan 2005 20:01:54 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> This patch contains the following possible cleanups:
> - make some needlessly global code static
> - ide-dma.c: remove the unneeded EXPORT_SYMBOL(__ide_dma_test_irq)
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

applied
