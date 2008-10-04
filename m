From: Tejun Heo <tj@kernel.org>
Subject: Re: #tj-upstream build fails because system_entering_hibernation
 is not exported
Date: Sun, 05 Oct 2008 05:50:52 +0900
Message-ID: <48E7D72C.9080307@kernel.org>
References: <48E7D49D.4080808@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55449 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753343AbYJDUwu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Oct 2008 16:52:50 -0400
In-Reply-To: <48E7D49D.4080808@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Hello, Rafael.
> 
> #tj-upstream fails to build with the following message.
> 
> ERROR: "system_entering_hibernation" [drivers/ata/libata.ko] undefined!

Okay, I just added EXPORT_SYMBOL_GPL() right below the function body and
rebased #tj-upstream.  Is that okay?

Thanks.

-- 
tejun
