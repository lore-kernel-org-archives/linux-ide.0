From: Dan Porat <dan.porat@gmail.com>
Subject: Re: 520 Bytes sector size
Date: Mon, 8 Feb 2010 20:49:16 +0200
Message-ID: <93b143da1002081049u7a5b90ebkff73018e72f5c5f9@mail.gmail.com>
References: <93b143da1002020450sf495912ib0ea75989d1d8928@mail.gmail.com>
	 <yq1aavrqlxw.fsf@sermon.lab.mkp.net>
	 <20100202232540.7f5327f6@lxorguk.ukuu.org.uk>
	 <4B69B032.4010600@teksavvy.com>
	 <93b143da1002062357o4503d1aajeff1595684211c5@mail.gmail.com>
	 <4B6EE668.1000701@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:35514 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab0BHStS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Feb 2010 13:49:18 -0500
Received: by bwz19 with SMTP id 19so2177868bwz.28
        for <linux-ide@vger.kernel.org>; Mon, 08 Feb 2010 10:49:16 -0800 (PST)
In-Reply-To: <4B6EE668.1000701@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org

Some high-end storage disks are formatted to sectors of 520.
They save the payload with the DIF .

This is the disk I have.

Thanks


On Sun, Feb 7, 2010 at 6:12 PM, Mark Lord <kernel@teksavvy.com> wrote:
> Dan Porat wrote:
>>
>> I see , but aren't all the commands (including FPDMA) , shoudl work in
>> 520 mode , when the disk is formatted to 520 ?
>
> ..
>
> How does one "Format to 520" ??
>
