From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] sata_nv: fix ADMA ATAPI issues with memory over 4GB	(v2)
Date: Wed, 21 Nov 2007 08:23:38 -0600
Message-ID: <47443F6A.3050205@shaw.ca>
References: <47438248.7030704@shaw.ca>
 <1195648784.11490.0.camel@kayak.wul.qc.ec.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:63660 "EHLO
	pd4mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbXKUOXl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Nov 2007 09:23:41 -0500
In-reply-to: <1195648784.11490.0.camel@kayak.wul.qc.ec.gc.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: vincent.fortier1@ec.gc.ca
Cc: ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>

Vincent Fortier wrote:
> Le mardi 20 novembre 2007 =E0 18:56 -0600, Robert Hancock a =E9crit :
>> This fixes some problems with ATAPI devices on nForce4 controllers i=
n ADMA
>> mode on systems with memory located above 4GB. We need to delay sett=
ing the
>> 64-bit DMA mask until the PRD table and padding buffer are allocated=
 so that
>> they don't get allocated above 4GB and break legacy mode (which is n=
eeded for
>> ATAPI devices). Also, explicitly set a 32-bit DMA mask before alloca=
ting the
>> legacy buffers since setting the DMA mask affects both ports and we =
need to
>> ensure the second port's buffers are allocated properly (fixes a pro=
blem
>> with the previous version of this patch).
>>
>> Signed-off-by: Robert Hancock <hancockr@shaw.ca>
>>
>=20
> Would this be worth sending to stable team for 2.6.22 & 2.6.23 ?

Likely (after it gets merged), those versions would have the same bug..
