From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC: 2.6 patch] schedule BLK_DEV_IDE_SATA for removal
Date: Fri, 22 Jun 2007 11:39:45 +0800
Message-ID: <1182483586.10524.33.camel@shinybook.infradead.org>
References: <20070621235211.GH23017@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:49649 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbXFVDjT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jun 2007 23:39:19 -0400
In-Reply-To: <20070621235211.GH23017@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2007-06-22 at 01:52 +0200, Adrian Bunk wrote:
> Users should use the libata based drivers for SATA drives.

NAK. Not all IDE drivers are converted yet. Not even all the relatively
common ones.

-- 
dwmw2

