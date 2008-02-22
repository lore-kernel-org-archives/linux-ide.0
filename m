From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: automatically use DMADIR if drive/bridge requires
 it
Date: Fri, 22 Feb 2008 09:11:34 -0500
Message-ID: <47BED816.9080109@rtr.ca>
References: <47B9D64C.3000705@rtr.ca> <47B9F05A.1060207@rtr.ca> <47BC6100.9020906@pobox.com> <47BC7727.1090508@rtr.ca> <47BCFD4E.4070100@gmail.com> <47BE9F66.5040404@tw.ibm.com> <47BECF0E.5040809@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1959 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751934AbYBVOLg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Feb 2008 09:11:36 -0500
In-Reply-To: <47BECF0E.5040809@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>, Ricardo Salveti de Araujo <rsalveti@br.ibm.com>

Mark Lord wrote:
> I have a funky looking thing here
> that says "SataLink SPiF223A" on it (????).  I wonder what it does?
..

Well, after some experimentation, this one appears to be ATA-only,
with no ATAPI support at all.

Cheers
