From: Richard Zhu <richard.zhu@linaro.org>
Subject: Re: [PATCH V7 0/5] imx53 ahci driver v7
Date: Wed, 31 Aug 2011 15:16:22 +0800
Message-ID: <CAJNCFVLzmOGsXw5tpQjSkKH7foLx+LMYF=qoJ_tvo9YoO6KxGQ@mail.gmail.com>
References: <1314762635-3923-1-git-send-email-richard.zhu@linaro.org>
	<87obz683zl.fsf@lebrac.rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58838 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199Ab1HaHQX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Aug 2011 03:16:23 -0400
Received: by gxk21 with SMTP id 21so335821gxk.19
        for <linux-ide@vger.kernel.org>; Wed, 31 Aug 2011 00:16:22 -0700 (PDT)
In-Reply-To: <87obz683zl.fsf@lebrac.rtp-net.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, eric.miao@linaro.org, linux-ide@vger.kernel.org, eric@eukrea.com, avorontsov@ru.mvista.com, jgarzik@pobox.com

Hi Arnaud:
These serial patches are same to the v7 patch sent yesterday.
Just add the cover-letter description, and the acked, tested info in
the commit msg.

Best Regards
Richard Zhu

On 31 August 2011 14:55, Arnaud Patard <arnaud.patard@rtp-net.org> wrot=
e:
> Richard Zhu <richard.zhu@linaro.org> writes:
>
> Hi,
>
>> *** BLURB HERE ***
>> This is the seventh iteration of the imx53 ahci patch. Changes betwe=
en
>> v5 and v7 are described in the following description.
>>
>> ChangeLog v5->v6:
>> =A0- Move the most ahci initialization codes from the board related =
files
>> =A0to the common ahci_sata file.
>>
>> =A0- Add the imx53 ahci's own ata_port_info definition in ahci_platf=
orm
>> =A0driver, since the 'ahci_pmp_retry_srst_ops' is required when imx5=
3
>> =A0ahci is present.
>>
>> ChangeLog v6->v7:
>> =A0- Define the default imx53 ahci platform data, reduce the modific=
atons
>> =A0on the board related files.
>>
>> =A0- Handle the sata_pwr_en pin obviously on smd board.
>>
> Sorry to disturb you with silly questions, but a v7 has already been
> sent yesterday [1]. Is this patchset the same as yesterday or did you
> modify some parts ?
>
> Thanks,
> Arnaud
>
> [1]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/063=
195.html
>
