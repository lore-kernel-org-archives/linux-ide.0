From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Non-PCI AHCI SATA driver
Date: Thu, 08 Jan 2009 18:12:45 -0600
Message-ID: <4966967D.90908@shaw.ca>
References: <19F8576C6E063C45BE387C64729E739403ECEDD8CD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo2no.shaw.ca ([64.59.134.9]:65219 "EHLO
	idcmail-mo2no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbZAIAMs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jan 2009 19:12:48 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739403ECEDD8CD@dbde02.ent.ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Abraham, Thomas" <t-abraham@ti.com>
Cc: "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "Subbrathnam, Swaminathan" <swami.iyer@ti.com>

Abraham, Thomas wrote:
> Hi Jeff,
> 
> I am working on a platform that has a non-PCI AHCI SATA controller module. Is there any patch available that can be used to obtain a non-PCI AHCI SATA driver.

Well, non-PCI AHCI is kind of a contradiction, as the AHCI spec 
specifically refers to a PCI device. "AHCI-like" may be more like it. I 
don't think anyone has worked on such a beast in Linux yet, or at least 
they haven't submitted the patches :-)
