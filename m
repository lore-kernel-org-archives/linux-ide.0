From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] sata_rcar: fix interrupt handling
Date: Sun, 02 Jun 2013 21:00:11 +0400
Message-ID: <51AB7A1B.4060905@cogentembedded.com>
References: <201306010238.35442.sergei.shtylyov@cogentembedded.com> <51A92CF0.3090804@cogentembedded.com> <20130602075821.GA8286@mtj.dyndns.org> <51AB2F0A.9030703@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33512 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296Ab3FBRAP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Jun 2013 13:00:15 -0400
Received: by mail-lb0-f169.google.com with SMTP id 10so3094874lbf.0
        for <linux-ide@vger.kernel.org>; Sun, 02 Jun 2013 10:00:14 -0700 (PDT)
In-Reply-To: <51AB2F0A.9030703@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, vladimir.barinov@cogentembedded.com

Hello.

On 06/02/2013 03:39 PM, Sergei Shtylyov wrote:

>
>>>      Darn, I forgot to Cc: stable@vger.kernel.org again.
>
>> Applied to libata/for-3.10-fixes w/ stable cc'd.  BTW, the driver
>> generates the following compile warning.
>
>>     CC      drivers/ata/sata_rcar.o
>>     drivers/ata/sata_rcar.c: In function =E2=80=98sata_rcar_thaw=E2=80=
=99:
>>     drivers/ata/sata_rcar.c:183:2: warning: large integer implicitly=
=20
>> truncated to unsigned type [-Woverflow]
>
>     It compiles without warnings for me, IIRC. What version of gcc ar=
e=20
> you using?

>> Care to fix it?
>
>    I'll look into it...


     I tried 4.2.0, 4.3.3 (that one broke with segmentation fault), and=
=20
4.7.3 and no warning...
So, please tell me what version you have for the changelog.

>> Thanks.
>

MBR, Sergei

