From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2.6.32 v2] MCP55 SATA2 conditional MSI support for sata_nv
Date: Fri, 07 Aug 2009 08:26:58 +0900
Message-ID: <4A7B66C2.3060207@kernel.org>
References: <20090805192055.8F2DE1007C@gold.linx.net>	 <4A7A16C9.6030500@gmail.com>	 <412A05BA40734D4887DBC67661F433080D73228B@EXMAIL.ad.emulex.com> <1249574363.4530.23.camel@localhost> <412A05BA40734D4887DBC67661F433080D7322B1@EXMAIL.ad.emulex.com> <4A7B633C.3040500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51459 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838AbZHFX1M (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Aug 2009 19:27:12 -0400
In-Reply-To: <4A7B633C.3040500@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Chetan.Loke@Emulex.Com, tony@linx.net, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, philipl@overt.org

Robert Hancock wrote:
>> If I'm not wrong then that's how it's supposed to be done. free_irq
>> and then disable_msi. You can't reverse the order. Also the driver
>> should know when to quiesce the ASIC. So quiesce first and then
>> shutdown everything.
> 
> Seems like devres should handle this somehow, or else something in
> libata core.. Tejun?

Yeah, if the device was enabled with pcim_enable_device(), devres will
take of all the cleanups.  No need to worry about them.

Thanks.

-- 
tejun
