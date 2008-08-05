From: Tejun Heo <tj@kernel.org>
Subject: Re: Issue with AHCI driver
Date: Wed, 06 Aug 2008 08:10:37 +0900
Message-ID: <4898DDED.8090808@kernel.org>
References: <12918703.1217971710650.JavaMail.root@mswamui-bichon.atl.sa.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44345 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757109AbYHEXLe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Aug 2008 19:11:34 -0400
In-Reply-To: <12918703.1217971710650.JavaMail.root@mswamui-bichon.atl.sa.earthlink.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: the4hoffmans@earthlink.net
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, blward@micron.com

the4hoffmans@earthlink.net wrote:
> Here's a file with more data...

Eeek... the kernel is 2.6.19 which didn't contain the AHCI class code
matching.  Can you please try newer one?  For 2.6.19, you'll need to add
your PCI ID.

-- 
tejun
