From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Subject: Re: ahci, SActive flag, and the HD activity LED
Date: Wed, 03 Aug 2005 07:17:13 +0200
Message-ID: <42F05359.7030006@fujitsu-siemens.com>
References: <42EF93F8.8050601@fujitsu-siemens.com> <20050802163519.GB3710@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:17454 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S262056AbVHCFRQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Aug 2005 01:17:16 -0400
In-Reply-To: <20050802163519.GB3710@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>

Jens Axboe wrote:

>>If I am reading the specs correctly, that'd mean the ahci driver is 
>>wrong in setting the SActive bit.
> 
> I completely agree, that was my reading of the spec as well and hence my
> original posts about this in the NCQ thread.

Have you (or has anybody else) also seen the wrong behavior of the 
activity LED?

Regards
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
