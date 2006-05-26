From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Add ata_piix's own resume function
Date: Fri, 26 May 2006 19:50:15 -0400
Message-ID: <44779437.9060502@garzik.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <20060526230534.GA3640@suse.de> <44778F2A.7070708@garzik.org> <4477916B.5000600@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38624 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964873AbWEZXuS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 May 2006 19:50:18 -0400
In-Reply-To: <4477916B.5000600@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>

Another note for people working on libata suspend/resume:  There are 
other details to consider along the controller->bus->device chain to 
look into, besides bringing the ATA bus to bus-idle.

For example, suspend on modern controllers should probably quiesce 
interrupts, and free_irq(), or at least zero the interrupt mask.

It is entirely possible we might resume to an interrupt storm if we're 
not careful.

	Jeff



