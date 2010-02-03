From: Mark Lord <kernel@teksavvy.com>
Subject: Re: 520 Bytes sector size
Date: Wed, 03 Feb 2010 12:19:46 -0500
Message-ID: <4B69B032.4010600@teksavvy.com>
References: <93b143da1002020450sf495912ib0ea75989d1d8928@mail.gmail.com>	<yq1aavrqlxw.fsf@sermon.lab.mkp.net> <20100202232540.7f5327f6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:11321 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932610Ab0BCRTt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Feb 2010 12:19:49 -0500
In-Reply-To: <20100202232540.7f5327f6@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Dan Porat <dan.porat@gmail.com>, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Tue, 02 Feb 2010 18:04:11 -0500
> "Martin K. Petersen" <martin.petersen@oracle.com> wrote:
> 
>>>>>>> "Dan" == Dan Porat <dan.porat@gmail.com> writes:
>> Dan> I would like to run 520 Bytes disk in native mode.  What changes I
>> Dan> have to run in sg driver ?  Is there any kernel already adapted for
>> Dan> 520 bytes sector size ?
>>
>> Linux does not support 520-byte sectors unless the drive is formatted
>> with DIF and hanging off a DIF-capable HBA.
..

The ATA READ_LONG and WRITE_LONG commands both use 520 byte sectors,
and both work with libata.

-ml
