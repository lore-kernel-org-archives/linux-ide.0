From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Thu, 19 Aug 2010 11:37:39 +0200
Message-ID: <4C6CFB63.2070001@kernel.org>
References: <20100810155559.7620.79711.stgit@localhost.localdomain>	<4C6AB68D.8000102@kernel.org>	<20100817174257.3691ed68@lxorguk.ukuu.org.uk>	<4C6AB919.7060203@kernel.org>	<20100817180158.179e7780@lxorguk.ukuu.org.uk>	<4C6ABFFA.2000502@kernel.org>	<20100817192353.3529733c@lxorguk.ukuu.org.uk>	<4C6B7B72.4090405@kernel.org>	<20100818110306.03ce2fbc@lxorguk.ukuu.org.uk>	<4C6BE9C8.4030803@kernel.org> <20100818161521.430ba361@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49437 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883Ab0HSJlg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Aug 2010 05:41:36 -0400
In-Reply-To: <20100818161521.430ba361@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, jeff@garzik.org

Hello,

On 08/18/2010 05:15 PM, Alan Cox wrote:
>> That's the reason why we have module priorities.  The link priority
>> becomes module priority and modprobe will deterministically prefer
>> ata_piix over ata_generic if a controller is supported by both.
> 
> Sure - but if ata_generic is already compiled in or already loaded ?

Well, what if pata_acpi is already compiled in or already loaded?  Or
what if ata_piix is already compiled in or already loaded but ahci is
not for an ich6 controller?  We have priorities in the drivers, if the
user/admin wants to use the lower priority ones that much, he/she
shall.  This isn't an issue.  There's no way to hotplug intel IDEs
anyway.

Thanks.

-- 
tejun
