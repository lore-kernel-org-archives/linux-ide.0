From: Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH] libata-sff: Reenable Port Multiplier after libata-sff remodeling.
Date: Tue, 31 Aug 2010 22:57:17 -0700
Message-ID: <AANLkTinf8aqTwBGe96fVBJZq7CSoM1ZOf-g4E5RLd29z@mail.gmail.com>
References: <4C7CB7A0.3000003@kernel.org>
	<1283296836-23863-1-git-send-email-gwendal@google.com>
	<4C7D9108.5010506@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:44851 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab0IAF5U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Sep 2010 01:57:20 -0400
Received: from kpbe18.cbf.corp.google.com (kpbe18.cbf.corp.google.com [172.25.105.82])
	by smtp-out.google.com with ESMTP id o815vJBN022724
	for <linux-ide@vger.kernel.org>; Tue, 31 Aug 2010 22:57:19 -0700
Received: from gxk4 (gxk4.prod.google.com [10.202.11.4])
	by kpbe18.cbf.corp.google.com with ESMTP id o815vH3p012745
	for <linux-ide@vger.kernel.org>; Tue, 31 Aug 2010 22:57:18 -0700
Received: by gxk4 with SMTP id 4so2064057gxk.25
        for <linux-ide@vger.kernel.org>; Tue, 31 Aug 2010 22:57:17 -0700 (PDT)
In-Reply-To: <4C7D9108.5010506@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: tj@kernel.org, nicolas@jungers.net, linux-ide@vger.kernel.org

Got it for the patch. Thanks for taking care of the submission.
Gwendal.

On Tue, Aug 31, 2010 at 4:32 PM, Jeff Garzik <jeff@garzik.org> wrote:
> On 08/31/2010 07:20 PM, Gwendal Grignou wrote:
>>
>> Keep track of the link on the which the current request is in progre=
ss.
>> It allows support of links behind port multiplier.
>>
>> Not all libata-sff is PMP compliant. Code for native BMDMA controlle=
r
>> does not take in accound PMP.
>>
>> Tested on Marvell 7042 and Sil7526.
>>
>> Signed-off-by: Gwendal Grignou<gwendal@google.com>
>> ---
>> =A0drivers/ata/libata-sff.c | =A0 38 ++++++++++++++++++++++++++++---=
-------
>> =A0drivers/ata/sata_mv.c =A0 =A0| =A0 =A02 +-
>> =A0include/linux/libata.h =A0 | =A0 =A03 ++-
>> =A03 files changed, 31 insertions(+), 12 deletions(-)
>
> FWIW, the normal standard for revised patches is to include a short
> changelog following the "---", but preceding the patch itself. Someth=
ing
> like:
>
> ---------------------SNIP-----------------------
> Not all libata-sff is PMP compliant. Code for native BMDMA controller
> does not take in accound PMP.
>
> Tested on Marvell 7042 and Sil7526.
>
> Signed-off-by: Gwendal Grignou <gwendal@google.com>
> ---
> v3: cleanups, add WARN_ON() etc
> v2: ata_sff_queue_pio_task takes a qc etc
>
> =A0drivers/ata/libata-sff.c | =A0 38 ++++++++++++++++++++++++++++----=
------
> =A0drivers/ata/sata_mv.c =A0 =A0| =A0 =A02 +-
> =A0include/linux/libata.h =A0 | =A0 =A03 ++-
> =A03 files changed, 31 insertions(+), 12 deletions(-)
> ---------------------SNIP-----------------------
>
>
>
> I'll queue this up along with the other libata fixes tonight (unless =
there
> are further revisions of course:))
>
> =A0 =A0 =A0 =A0Jeff
>
>
>
