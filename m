From: =?ISO-8859-1?Q?Andr=E9_Tomt?= <andre@tomt.net>
Subject: Re: ahci, SActive flag, and the HD activity LED
Date: Wed, 03 Aug 2005 13:08:40 +0200
Message-ID: <42F0A5B8.6060300@tomt.net>
References: <42EF93F8.8050601@fujitsu-siemens.com> <20050802163519.GB3710@suse.de> <42F05359.7030006@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.skjellin.no ([80.239.42.67]:27624 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S262220AbVHCLIn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Aug 2005 07:08:43 -0400
In-Reply-To: <42F05359.7030006@fujitsu-siemens.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>

Martin Wilck wrote:
> Jens Axboe wrote:
> 
>>> If I am reading the specs correctly, that'd mean the ahci driver is 
>>> wrong in setting the SActive bit.
>>
>>
>> I completely agree, that was my reading of the spec as well and hence my
>> original posts about this in the NCQ thread.
> 
> 
> Have you (or has anybody else) also seen the wrong behavior of the 
> activity LED?

I have, Asus P5LD2 i945P, ICH7R AHCI controller, Hitachi Deskstar T7K250 
250GB "SATA2" drives. Kernel 2.6.12.x
