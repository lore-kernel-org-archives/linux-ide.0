From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: Disabling Command Completion Coalescing (CCC) in SATA AHCI
Date: Fri, 20 May 2011 14:49:27 +0400
Message-ID: <4DD64737.10706@ru.mvista.com>
References: <BANLkTinPkdTkOQHNnPHwtXq2SMCo-uAALA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34182 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934104Ab1ETKuQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 May 2011 06:50:16 -0400
Received: by bwz15 with SMTP id 15so2842699bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 20 May 2011 03:50:15 -0700 (PDT)
In-Reply-To: <BANLkTinPkdTkOQHNnPHwtXq2SMCo-uAALA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pallav Bose <pallavbose@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

On 20-05-2011 0:32, Pallav Bose wrote:

> I'm working on 2.6.35.9 version of the Linux kernel and am trying to
> disable Command Completion Coalescing. I have Native Command Queuing
> enabled by activating the RAID mode through the BIOS.

> I was looking at the Serial ATA AHCI 1.3 Specification and found on
> page 115 that -

> The CCC feature is only in use when CCC_CTL.EN is set to =911=92. If
> CCC_CTL.EN is set to =910=92, no CCC interrupts shall be generated.

> Next, I had a look at the relevant code (namely, the files concerning
> AHCI) for this version of the kernel but wasn't able to make any
> progress. I found the following enum constant - HOST_CAP_CCC =3D (1<<
> 7) - in drivers/ata/ahci.h, but I'm not sure how this should be
> modified to disable command coalescing. I did set HOST_CAP_CCC to 0
> but through some experiments that I conducted, I found that responses
> were being batched.

    This constant is only used to report the controller capability, I s=
ee no=20
other code depending on it, hence there doesn't seem to be any CCC supp=
ort...

[...]

> The mass storage controller in the system is: Promise Technology, Inc=
=2E
> PDC20268 (Ultra100 TX2) (rev 02),

    I don't understand. This controller is not AHCI, and not even SATA =
one.

> and the HDD being used is: WD Caviar Black (Model number - WD1001FALS=
).

WBR, Sergei
