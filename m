From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ata: ahci_brcmstb: Fix misuse of IS_ENABLED
Date: Thu, 6 Aug 2015 14:32:22 -0400
Message-ID: <20150806183222.GA14626@mtj.duckdns.org>
References: <1438835298.28215.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:33505 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851AbbHFScZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Aug 2015 14:32:25 -0400
Received: by ykoo205 with SMTP id o205so69994563yko.0
        for <linux-ide@vger.kernel.org>; Thu, 06 Aug 2015 11:32:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1438835298.28215.1.camel@ingics.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Aug 06, 2015 at 12:28:18PM +0800, Axel Lin wrote:
> While IS_ENABLED() is perfectly fine for CONFIG_* symbols, it is not
> for other symbols such as __BIG_ENDIAN that is provided directly by
> the compiler.
> 
> Switch to use CONFIG_CPU_BIG_ENDIAN instead of __BIG_ENDIAN.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied to libata/for-4.2-fixes w/ stable cc'd.

Thanks.

-- 
tejun
