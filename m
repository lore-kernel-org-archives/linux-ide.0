From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Fwd: libata extension
Date: Tue, 13 Mar 2007 07:23:45 -0400
Message-ID: <45F689C1.9070900@garzik.org>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>	 <3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com>	 <3aac340703121007q35c7acf7t648e0ed7608be04d@mail.gmail.com>	 <200703122106.39669.bzolnier@gmail.com> <3aac340703121936k51df425dg7e1a74688a67075@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58966 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234AbXCMLXr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Mar 2007 07:23:47 -0400
In-Reply-To: <3aac340703121936k51df425dg7e1a74688a67075@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vitaliyi <imgrey@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Vitaliyi wrote:
>> Why is the access to Control register needed?
> 
> To execute soft reset for example.
> 
>> > In the perfect case i would like to be able to execute vendor command
>> > set (reverse engineered).
>>
>> Sounds interesting. :-)
>>
>> Could you give some more details on what are you going to implement?
> 
> Reading/writing service area, uploading, downloading modules, working
> with flash etc.

SAT (aka ATA passthru) defines how to do soft-reset.

SG_IO supports the ATA_12 and ATA_16 commands which permit soft-reset 
and similar tasks.  libata supports this interface, but does not yet 
support soft-reset and similar non-comment-oriented tasks.  This would 
be the best area to add such features, though.

	Jeff



