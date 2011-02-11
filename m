From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 21/20] ata_piix: add new PIIX_FLAG_* flags
Date: Fri, 11 Feb 2011 16:04:11 +0300
Message-ID: <4D5533CB.8000003@ru.mvista.com>
References: <201102081652.36752.bzolnier@gmail.com>	<4D51796C.8020008@ru.mvista.com> <AANLkTikyV579TRSMw_g_rTB7C641fWbdSELP9mpa30bG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60630 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726Ab1BKNF1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Feb 2011 08:05:27 -0500
In-Reply-To: <AANLkTikyV579TRSMw_g_rTB7C641fWbdSELP9mpa30bG@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello.

On 08-02-2011 21:18, Bartlomiej Zolnierkiewicz wrote:

>>> Turn open-coded checks in piix_set_timings() into PIIX_FLAG_* flags
>>> per suggestion from Alan Cox.

>>> Suggested-by: Alan Cox<alan@lxorguk.ukuu.org.uk>
>>> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>

>> [...]

>>> Index: b/drivers/ata/ata_piix.c
>>> ===================================================================
>>> --- a/drivers/ata/ata_piix.c
>>> +++ b/drivers/ata/ata_piix.c
>>> @@ -133,6 +133,8 @@ enum {
>>>         PIIX_FLAG_CHECKINTR     = (1<<  28), /* make sure PCI INTx enabled
>>> */
>>>         PIIX_FLAG_SIDPR         = (1<<  29), /* SATA idx/data pair regs */
>>> +       PIIX_FLAG_NO_SITRE      = (1<<  30), /* no SITRE register */

>>    The register in question is called SIDETIM, SITRE is a bit that enables
>> its use.

> ICH4-M databook that I have at hand (Intel IDE PRM seems to be gone
> from Intel's website, though I'm sure I have a backup _somewhere_) it

    If you mean ICH IDE Controller PRM (29860004.pdf), it indeed calls the 
register *SITR* (yet it has SIDETIM mentioned in the table 37 :-). Intel seems 
  not very consistent in its documentation. :-)

> Thanks,
> Bartlomiej

WBR, Sergei
