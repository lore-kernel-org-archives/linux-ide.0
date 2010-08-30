From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend
 to RAM
Date: Mon, 30 Aug 2010 14:55:30 +0200
Message-ID: <4C7BAA42.2050809@kernel.org>
References: <1283027290.2721.37.camel@myfedorahat>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58007 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754082Ab0H3NCW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Aug 2010 09:02:22 -0400
In-Reply-To: <1283027290.2721.37.camel@myfedorahat>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Siddhartha Jain <siddhartha@siddharthajain.net>
Cc: linux-ide@vger.kernel.org

On 08/28/2010 10:28 PM, Siddhartha Jain wrote:
> I am going to try pointing rsyslog at a remote syslog server to see if I
> can capture what happens at resume-time but any other pointers to
> debug/troubleshoot this issue will be helpful.

Setting up netconsole (see Documentation/networking/netconsole.txt in
the kernel source tree) would be better.

Thanks.

-- 
tejun
