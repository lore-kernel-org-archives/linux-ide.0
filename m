From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: 520 BPS data integrity vendors
Date: Sat, 03 Jul 2010 03:33:59 -0400
Message-ID: <yq1mxu981eg.fsf@sermon.lab.mkp.net>
References: <AANLkTilcpFgsYtEUkZ2zAU3SDs0jetiajYPzKUWgFMyD@mail.gmail.com>
	<1278093968.2856.169.camel@mulgrave.site>
	<AANLkTilWKeOAXMukh_zvXzdXkdOTk6soAEnpzFNwvBA3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:33026 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661Ab0GCHeL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Jul 2010 03:34:11 -0400
In-Reply-To: <AANLkTilWKeOAXMukh_zvXzdXkdOTk6soAEnpzFNwvBA3@mail.gmail.com>
	(Dan Porat's message of "Fri, 2 Jul 2010 21:03:26 -0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Porat <dan.porat@gmail.com>
Cc: James Bottomley <James.Bottomley@suse.de>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

>>>>> "Dan" == Dan Porat <dan.porat@gmail.com> writes:

>>> Would you know of any specific LSI SAS/HBAmodel which will support
>>> SCSI DIF/DIX ?

LSI's 92xx series HBAs have the LSISAS2008 chip that's required for DIF
operation. These boards do not support DIX.

-- 
Martin K. Petersen	Oracle Linux Engineering
