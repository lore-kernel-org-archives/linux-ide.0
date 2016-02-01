From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v2 1/3] ata: Remove the AHCI_HFLAG_EDGE_IRQ support from libahci.
Date: Mon, 1 Feb 2016 11:45:00 -0800
Message-ID: <CAOHikRBbTafF68qF9n+HNo4p6bwAShZtObw8sPDe45QmG0Xxiw@mail.gmail.com>
References: <1453888197-11368-1-git-send-email-stripathi@apm.com>
	<1453888197-11368-2-git-send-email-stripathi@apm.com>
	<20160131113249.GW32380@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:33489 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163AbcBATpB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2016 14:45:01 -0500
Received: by mail-yk0-f178.google.com with SMTP id z13so60836140ykd.0
        for <linux-ide@vger.kernel.org>; Mon, 01 Feb 2016 11:45:00 -0800 (PST)
In-Reply-To: <20160131113249.GW32380@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Mark Langsdorf <mlangsdo@redhat.com>, Jon Masters <jcm@redhat.com>, patches <patches@apm.com>, Suman Tripathi <svtripathi@gmail.com>

On Sun, Jan 31, 2016 at 3:32 AM, Tejun Heo <htejun@gmail.com> wrote:
> On Wed, Jan 27, 2016 at 03:19:55PM +0530, Suman Tripathi wrote:
>> This patch removes the AHCI_HFLAG_EDGE_IRQ support from libahci.
>> The upcoming patches will have the flexibility to override
>> irq handlers in the LLD's. Controller's implementing a EDGE trigger
>> latch can implement their own interrupt handler inside the driver.
>>
>> Signed-off-by: Suman Tripathi <stripathi@apm.com>
>
> Shouldn't this patch come after the irq override is in place?
>
> 1. introduce irq override.
>
> 2. remove AHCI_HFLAG_EDGE_IRQ by moving the edge triggered handler to
>    ahci_xgene.
>
> 3. Update xgene irq handler to address the erratum.

Thought of remove the AHCI_HFLAG_EDGE entirely first because we don't
require it . Then implement the irq override capability.
>
> Thanks.
>
> --
> tejun



-- 
Thanks,
with regards,
Suman Tripathi
