From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: finally use __initconst in ata_parse_force_one()
Date: Wed, 10 Jun 2015 13:47:00 +0900
Message-ID: <20150610044700.GH11955@mtj.duckdns.org>
References: <1433856799-24825-1-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33626 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbbFJErH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jun 2015 00:47:07 -0400
Content-Disposition: inline
In-Reply-To: <1433856799-24825-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 09, 2015 at 03:33:19PM +0200, Rasmus Villemoes wrote:
> Just six days after this FIXME was added seven years ago, Sam Ravnborg
> added the missing feature (37c514e3dfc8 "Add missing init section
> definitions"), though it ended up being called __initconst.
> 
> Let's use it; better late than never.

Heh, seriously.

Applied to libata/for-4.2.

Thanks!

-- 
tejun
