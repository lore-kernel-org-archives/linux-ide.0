From: Lin Mac <mkl0301@gmail.com>
Subject: Re: [PATCH v3 2/2] ahci_platform: add support for CNS3xxx SoC devices
Date: Fri, 7 Jan 2011 02:14:12 +0800
Message-ID: <AANLkTimA4HvL2b-JAooR2out-19cEvBYUNYGFZz-VMwQ@mail.gmail.com>
References: <1294336393-920-1-git-send-email-mkl0301@gmail.com>
	<1294336393-920-3-git-send-email-mkl0301@gmail.com>
	<AANLkTinO-feQkpfoZhmOV7VyPbyL=f8KV1_Qysps04ve@mail.gmail.com>
	<20110106180948.GX27131@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53694 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010Ab1AFSON convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 13:14:13 -0500
Received: by mail-fx0-f46.google.com with SMTP id 20so16247409fxm.19
        for <linux-ide@vger.kernel.org>; Thu, 06 Jan 2011 10:14:12 -0800 (PST)
In-Reply-To: <20110106180948.GX27131@trinity.fluff.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Dooks <ben@trinity.fluff.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, cbouatmailru@gmail.com, htejun@gmail.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

2011/1/7 Ben Dooks <ben@trinity.fluff.org>:
> On Fri, Jan 07, 2011 at 02:04:33AM +0800, Lin Mac wrote:
>> Hi Jeff,
>>
>> 2011/1/7 =A0<mkl0301@gmail.com>:
>> > From: Mac Lin <mkl0301@gmail.com>
>> >
>> > CNS3xxx override the softreset function of ahci_platform ahci_soft=
reset by
>> > cns3xxx_ahci_softreset, which would retry ahci_do_softreset again =
with pmp=3D0 if
>> > pmp=3D15 failed, for the controller has problem receiving D2H Reg =
=46IS of the
>> > different PMP setting of the previous sent H2D Reg FIS.
>> >
>> > Following describe the isssue with original ahci_platform driver o=
n
>> > linux-2.6.37-rc3, arm/cns3xxx.
>> >
>> > If CONFIG_SATA_PMP is enabled, while not using multiplier and conn=
ect the disks
>> > directly to the board, the disk cannot be found due to software re=
set always
>
>> complicated if more SoC-specific code added.
>> I really prefer the original way.
>
> Is there a reference to the original?
v2: http://www.spinics.net/lists/linux-ide/msg39766.html

Best Regards,
Mac Lin
