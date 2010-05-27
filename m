From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH]: ata: fix unused variable warning in sil_host_intr()
Date: Thu, 27 May 2010 21:48:50 +0400
Message-ID: <4BFEB082.1040303@ru.mvista.com>
References: <20100527173114.23427.67952.sendpatchset@prarit.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:52043 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756760Ab0E0Rtn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 May 2010 13:49:43 -0400
Received: by wwb34 with SMTP id 34so193732wwb.19
        for <linux-ide@vger.kernel.org>; Thu, 27 May 2010 10:49:42 -0700 (PDT)
In-Reply-To: <20100527173114.23427.67952.sendpatchset@prarit.bos.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Hello.

Prarit Bhargava wrote:

    s/unused/uninitialized/ in the subject. Unused variable is a=20
different thing.

> Warning seen with 'make -j24 CONFIG_DEBUG_SECTION_MISMATCH=3Dy':

    I don't think any of these matters here...

> drivers/ata/sata_sil.c: In function =E2=80=98sil_host_intr=E2=80=99:
> drivers/ata/sata_sil.c:442: error: =E2=80=98serror=E2=80=99 may be us=
ed uninitialized in this function

> Signed-off-by: Prarit Bhargava <prarit@redhat.com>

MBR, Sergei

