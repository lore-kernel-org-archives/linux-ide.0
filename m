From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V2] AHCI: Workaround for ThunderX Errata#22536
Date: Mon, 15 Feb 2016 13:30:41 -0500
Message-ID: <20160215183041.GH3965@htj.duckdns.org>
References: <1455319230-30201-1-git-send-email-tchalamarla@caviumnetworks.com>
 <20160214170152.GC3965@htj.duckdns.org>
 <56C147B2.9010303@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34696 "EHLO
	mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbcBOSan (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Feb 2016 13:30:43 -0500
Content-Disposition: inline
In-Reply-To: <56C147B2.9010303@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
Cc: stripathi@apm.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello, Tirumalesh.

On Sun, Feb 14, 2016 at 07:36:18PM -0800, Tirumalesh Chalamarla wrote:
> There is no need for special Driver, AHCI is sufficient for ThunderX, the
> file only contains this interrupt handler,
> is it preferable if this interrupt handler in libahci.c with others, instead
> of separate file?

Yeap, just fold it in ahci.c with surrounding #ifdef guard.

Thanks.

-- 
tejun
