From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] ide: remove obsolete CONFIG_BLK_DEV_ADMA - cleanup
 arch
Date: Tue, 14 Sep 2004 18:02:11 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040914180211.78b6085f.akpm@osdl.org>
References: <20040914095330.GF9994@rdrz.de>
	<20040914095847.GG9994@rdrz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:18905 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266136AbUIOA6Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Sep 2004 20:58:24 -0400
In-Reply-To: <20040914095847.GG9994@rdrz.de>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Raphael Zimmerer <killekulla@rdrz.de>
Cc: linux-kernel@vger.kernel.org

Raphael Zimmerer <killekulla@rdrz.de> wrote:
>
> Cleans up default config for various archs, removing
> CONFIG_BLK_DEV_IDEPCI

I don't see much point in applying global defconfig sweeps, really. 
There's no end to it.

Obsolete paremeters do no real harm, and arch maintainers will
automatically eliminate obsolete stuff when they do their next defconfig
update.
