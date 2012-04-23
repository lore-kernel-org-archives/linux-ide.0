From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH] libata: clear error mask of old error history
Date: Mon, 23 Apr 2012 09:09:51 +0800
Message-ID: <CAF1ivSY3Q6Yky_fNPreGJijvJu-q4WgDBKYgcWGQvr227crmWA@mail.gmail.com>
References: <1334885938.4927.11.camel@minggr>
	<4F913A80.3030207@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:49200 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277Ab2DWBJw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2012 21:09:52 -0400
Received: by qadc11 with SMTP id c11so1157766qad.19
        for <linux-ide@vger.kernel.org>; Sun, 22 Apr 2012 18:09:51 -0700 (PDT)
In-Reply-To: <4F913A80.3030207@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>

On Fri, Apr 20, 2012 at 6:29 PM, Sergei Shtylyov <sshtylyov@mvista.com>=
 wrote:
> Hello.
>
>
> On 20-04-012 5:38, Lin Ming wrote:
>
>> The old error history was cleared in ata_ering_clear().
>> It only sets ATA_EFLAG_OLD_ER eflags, but the err_mask was not clear=
ed.
>> So ata_ering_map() still iterates the old error history.
>
>
>> This causes problem, for example, wrong probe trials count were retu=
rned
>> in
>> ata_eh_schedule_probe(), which in turn causes SATA link speed to be =
slowed
>> down
>> to 1.5Gbps.
>
>
>> Reported-and-tested-by: Martin Mokrejs<mmokrejs@fold.natur.cuni.cz>
>> Signed-off-by: Lin Ming<ming.m.lin@intel.com>
>> ---
>
>
>> Hi Jeff,
>
>
>> This patch fixes an old regression introduced in 2.6.37-rc1
>> of commit d902747.
>
>
>> So it should be included into stable releases since 2.6.37.
>
>
> =A0 You should have included:
>
> Cc: stable@vger.kernel.org # 2.6.37+
>
> after your signoff in this case.

Re-send with stable CCed.

Thanks.

>
> MBR, Sergei
