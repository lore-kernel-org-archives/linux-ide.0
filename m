From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: drivers/scsi/sata_vsc.c: inconsistent NULL checking
Date: Tue, 21 Mar 2006 22:08:44 -0500
Message-ID: <4420BFBC.7080804@pobox.com>
References: <20060309110207.GA4006@stusta.de>	 <e9c3a7c20603091144sb078d92tcc232db66492e6c9@mail.gmail.com> <e9c3a7c20603091241y571e552p82c5c8091095c421@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:65469 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750705AbWCVDI5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 22:08:57 -0500
In-Reply-To: <e9c3a7c20603091241y571e552p82c5c8091095c421@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, Dan Williams <dan.j.williams@intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Dan Williams wrote:
>>The attached patch cleans up the code, and adds GD31244 to the driver
>>description in drivers/scsi/Kconfig.

> Joe Perches suggested some coding style changes.  Here is version 2.

Applied.  When resending patches, please continue to follow the standard 
patch submission format, particularly #2, #5 and #6:
	http://linux.yyz.us/patch-format.html

Regards,

	Jeff


