From: Tejun Heo <tj@kernel.org>
Subject: Re: ahci sometimes fails to suspend controller
Date: Thu, 23 Jul 2009 19:11:33 +0900
Message-ID: <4A683755.60909@kernel.org>
References: <20090719220423.54e8c75d@uranus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55091 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbZGWKKG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Jul 2009 06:10:06 -0400
In-Reply-To: <20090719220423.54e8c75d@uranus>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Benjamin S." <sbenni@gmx.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Benjamin S. wrote:
> Hello,
> 
> I have a Gigabyte GA-MA78G-DS3H mainboard with SB700 chipset and the 
> controller is recognized by ahci. It works great until I have suspended 
> (to ram) and resumed my system several times and then the kernel fails
> to suspend (or maybe resume). Please note that although it happened
> the first time I have suspend in the case of the dmesg output below, it 
> usually sometimes works and sometimes not.

Does "pci=nomsi" help?

-- 
tejun
