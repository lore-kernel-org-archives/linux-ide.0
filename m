From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] libata: switch to using block layer tagging support
Date: Wed, 20 May 2009 15:47:28 -0400
Message-ID: <4A145E50.8090000@garzik.org>
References: <20090520065942.GD11363@kernel.dk>	 <20090520070038.GE11363@kernel.dk>	 <da824cf30905201010h1424e414idc3b01ecf7682005@mail.gmail.com>	 <e7510f760905201108l4486ff6foc560c1271ebee7a7@mail.gmail.com>	 <1242845440.2881.74.camel@localhost.localdomain>	 <4A1452E9.7000204@garzik.org> <4A145458.5080302@garzik.org> <e7510f760905201242s3cb84154m6e9a5795fd2357c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38551 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755518AbZETTrd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 May 2009 15:47:33 -0400
In-Reply-To: <e7510f760905201242s3cb84154m6e9a5795fd2357c5@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Grant Grundler <grundler@google.com>, Jens Axboe <jens.axboe@oracle.com>, linux-ide@vger.kernel.org, htejun@gmail.com

Gwendal Grignou wrote:
> We can not have more than 16 devices per ata_port: a PMP can only have
> 15 device ports [Sata 2.6- 16.2], and we can not connect a PMP to
> another one.

Whoops, you're right.  I guess I mixed up SAS expanders and PMP's, when 
coughing up that "32".

	Jeff


