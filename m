From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 1/4] libata sata_qstor fix oops on rmmod
Date: Wed, 07 Nov 2007 11:24:44 -0500
Message-ID: <4731E6CC.1060407@rtr.ca>
References: <4731DF06.3050202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2210 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752336AbXKGQYq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Nov 2007 11:24:46 -0500
In-Reply-To: <4731DF06.3050202@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
>
>This belongs in 2.6.24. 

Note that without these four patches, sata_qstor is not currently functional in 2.6.24.

