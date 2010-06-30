From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH]ata:ahci.c Fix warning: comparison between 'enum 	<anonymous>'
 and 'enum <anonymous>'
Date: Tue, 29 Jun 2010 23:38:47 -0700
Message-ID: <4C2AE677.2020202@gmail.com>
References: <1277866406-8253-1-git-send-email-justinmattock@gmail.com> <AANLkTinetp4EnDl_O89pvccbJnuzRRQc5FHDX3-P3-Jv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:62265 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081Ab0F3GiX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jun 2010 02:38:23 -0400
Received: by pxi8 with SMTP id 8so223860pxi.19
        for <linux-ide@vger.kernel.org>; Tue, 29 Jun 2010 23:38:23 -0700 (PDT)
In-Reply-To: <AANLkTinetp4EnDl_O89pvccbJnuzRRQc5FHDX3-P3-Jv@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?SMOla29uIEzDuHZkYWw=?= <hlovdal@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, tj@kernel.org

On 06/29/2010 11:11 PM, H=C3=A5kon L=C3=B8vdal wrote:
> On 30 June 2010 04:53, Justin P. Mattock<justinmattock@gmail.com>  wr=
ote:
>> -       int n_ports, i, rc;
>> +       int n_ports, i, rc, sum =3D 32;
>>
>>         VPRINTK("ENTER\n");
>>
>> -       WARN_ON(ATA_MAX_QUEUE>  AHCI_MAX_CMDS);
>> +       WARN_ON(ATA_MAX_QUEUE>  sum);
>
> Should'nt that rather be
>
>         int n_ports, i, rc, sum =3D AHCI_MAX_CMDS;
>
> ?
>
> BR H=C3=A5kon L=C3=B8vdal
>

o.k. I resent again with the small change that you had mentioned.

Justin P. Mattock
