From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 10/13] sl82c105: add ->speedproc support
Date: Thu, 15 Mar 2007 17:36:33 +0000
Message-ID: <20070315173633.GA26160@flint.arm.linux.org.uk>
References: <45F86058.6090509@ru.mvista.com> <45F956B4.1060309@xandros.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2164 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbXCORgq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 13:36:46 -0400
Content-Disposition: inline
In-Reply-To: <45F956B4.1060309@xandros.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Woody Suwalski <woodys@xandros.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Mar 15, 2007 at 10:22:44AM -0400, Woody Suwalski wrote:
> Sergei Shtylyov wrote:
> >  I wonder is there are some W83C554 users anywhere -- that chipset 
> >also supports UltraDMA...
> >
> >MBR, Sergei
> Sergei,
> 
> ARM Netwinder machines are running hard disk IDE on SL82c105.
> Could you send me the actual source file to try (or a patch)?

That's actually a W83C553 which does not support UDMA in any shape or
form according to the documents.

I guess it's an enhancement found on W83C554, and in that case any
attempt to add UDMA support to the SL82C105 driver should be done
such that these older chipsets continue to work.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
