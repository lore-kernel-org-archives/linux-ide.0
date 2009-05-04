From: s ticket <smticket@gmail.com>
Subject: Re: How to assess PMP register
Date: Mon, 4 May 2009 13:04:17 +0800
Message-ID: <fa69d4570905032204q726728a1qd4be4800b916439a@mail.gmail.com>
References: <fa69d4570904291849p638b849fm856be97c81340624@mail.gmail.com>
	 <49FA2763.9040409@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:6488 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbZEDFER convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 May 2009 01:04:17 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2106648ywb.1
        for <linux-ide@vger.kernel.org>; Sun, 03 May 2009 22:04:17 -0700 (PDT)
In-Reply-To: <49FA2763.9040409@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

>> Is there any way to read PMP registers after hardreset/softreset?
>> SATA Controller is marvell 88SX7042 and driver is sata_mv.
>> I try to send 0xE4 and 0xE6 command to read/write PMP registers:
>
> ..
>>
>> =A0 =A0 =A0 =A0if (ioctl(fd, SG_IO, &io_hdr) =3D=3D -1) {
>
> ..
>
> No, there is no existing way to access PMP registers from user space.
>
But what's the difference in dealing with '0xE4' and '0xE8' commands.
I found that only the two commands will reset the link
