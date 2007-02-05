From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] libata: Add a host flag to indicate lack of IORDY
 capability
Date: Mon, 5 Feb 2007 14:51:20 -0800
Message-ID: <20070205145120.546feb43.akpm@linux-foundation.org>
References: <20070205161515.38b8107d@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:37224 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964854AbXBEWva (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Feb 2007 17:51:30 -0500
In-Reply-To: <20070205161515.38b8107d@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Mon, 5 Feb 2007 16:15:15 +0000
Alan <alan@lxorguk.ukuu.org.uk> wrote:

> This is the first preparation to doing the !IORDY cases properly. Further
> diffs will then add the needed logic to do it right.
> 
>...
>
>  static int pio_mask = 0x1F;		/* PIO range for autospeed devices */
> ++static int iordy_mask = 0xFFFFFFFF;	/* Use iordy if available */

That isn't compileable.  Are you sure you sent the correct patch?

This patch needed some fixups against git-libata-all, but they were pretty
obvious.
