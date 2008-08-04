From: Tejun Heo <tj@kernel.org>
Subject: Re: Issue with AHCI driver
Date: Tue, 05 Aug 2008 08:10:09 +0900
Message-ID: <48978C51.90208@kernel.org>
References: <25908599.1217883409412.JavaMail.root@elwamui-milano.atl.sa.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50598 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755531AbYHDXLA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Aug 2008 19:11:00 -0400
In-Reply-To: <25908599.1217883409412.JavaMail.root@elwamui-milano.atl.sa.earthlink.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: the4hoffmans@earthlink.net
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, blward@micron.com

the4hoffmans@earthlink.net wrote:
> Jeff,
> 
> I changed line 53 of libata.h from "#undef ATA_DEBUG" to "#define
> ATA_DEBUG" and we got a bunch of compiler errors.  Was that not what
> you wanted?  Should I change ATA_VERBOSE_DEBUG instead?

Can you post boot log w/o ATA_DEBUG?  And the result of lspci -nnvvv?

-- 
tejun
