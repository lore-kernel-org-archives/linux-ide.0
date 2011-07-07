From: Richard Kang <turquesa@malgn.com>
Subject: Re: qc timeout on a marvell 88F6282 board
Date: Thu, 07 Jul 2011 15:36:14 +0900
Message-ID: <4E1553DE.5050504@malgn.com>
References: <4E0AEAB1.4090106@malgn.com>	<CAMAG_ef0y=Jg=8eQSWj_e8kwGAtFwJXsvPATiL1fkq57kVzubA@mail.gmail.com>	<4E12CAD1.3030302@malgn.com>	<CAMAG_efStJsEeZrdf-eSq89aHrji3t5+RYO+arrUYiAQpn7LgQ@mail.gmail.com>	<4E14040F.9030503@malgn.com> <CAMAG_efiyOdFCs4TAe0NusQ7yxLFg6gyajqSX51a965jEPioJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [125.7.223.35] ([125.7.223.35]:49514 "EHLO mail.malgn.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750776Ab1GGGgQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 Jul 2011 02:36:16 -0400
In-Reply-To: <CAMAG_efiyOdFCs4TAe0NusQ7yxLFg6gyajqSX51a965jEPioJw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: linux-ide@vger.kernel.org

2011-07-06 =EC=98=A4=ED=9B=84 5:07, saeed bishara =EC=93=B4 =EA=B8=80:
> Richard,
>
>   this board is supported by mainline kernel, can you try latest
> version (3.0-rcX)?
>> I can't find reason of not working. Please advise to me.
>>
>> Thank you.
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Dear saeed,

I tested sata_sil24 driver with 3.0.0-rc6.
At first booting, machine id was not supported in new kernel.
And I replaced id(0x690) of DB-88F6281-BP with 0x20f.
After changing machine id, booting was completed.

I loaded "libata dma=3D0" and "sata_sil24".
But result was same to before. -> qc timeout(0xec)

Thank you.
