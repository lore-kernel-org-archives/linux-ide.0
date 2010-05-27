From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH]: ata: fix unused variable warning in sil_host_intr()
Date: Thu, 27 May 2010 14:02:09 -0400
Message-ID: <4BFEB3A1.1080608@redhat.com>
References: <20100527173114.23427.67952.sendpatchset@prarit.bos.redhat.com> <4BFEB082.1040303@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6897 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752666Ab0E0SGb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 May 2010 14:06:31 -0400
In-Reply-To: <4BFEB082.1040303@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

> Hello.
>
> Prarit Bhargava wrote:
>
>    s/unused/uninitialized/ in the subject. Unused variable is a=20
> different thing.

Oops.  Sorry for the typo.

P.


>
>> Warning seen with 'make -j24 CONFIG_DEBUG_SECTION_MISMATCH=3Dy':
>
>    I don't think any of these matters here...
>
>> drivers/ata/sata_sil.c: In function =E2=80=98sil_host_intr=E2=80=99:
>> drivers/ata/sata_sil.c:442: error: =E2=80=98serror=E2=80=99 may be u=
sed=20
>> uninitialized in this function
>
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>
> MBR, Sergei
>
