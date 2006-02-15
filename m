From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: increase LBA48 max sectors to 65535
Date: Wed, 15 Feb 2006 14:03:20 -0500
Message-ID: <43F37AF8.2010903@rtr.ca>
References: <1139754779159-git-send-email-htejun@gmail.com> <43EF8E61.5040409@pobox.com> <43EFD73D.4070207@gmail.com> <43F011DF.6020203@pobox.com> <20060215072449.GA31691@htj.dyndns.org> <20060215130725.GP4203@suse.de> <43F342E6.9060909@gmail.com> <20060215151200.GW4203@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4577 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750897AbWBOTDV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 14:03:21 -0500
In-Reply-To: <20060215151200.GW4203@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

There were some PATA host controllers (eg. trm290) that choked
on nsects==0, but I've never found a drive that did.

Cheers
