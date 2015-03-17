From: Feng Kan <fkan@apm.com>
Subject: Re: [PATCH] sata: xgene: add ACPI support for APM X-Gene SATA ports
Date: Tue, 17 Mar 2015 11:22:06 -0700
Message-ID: <CAL85gmD5dNOsghaHMndhr9Mb7A=jaE6yyO5JeO7o1zb24_6=JQ@mail.gmail.com>
References: <1418337070-17644-1-git-send-email-fkan@apm.com>
	<CAL85gmAHLk9XCbr-1+USmOKxd5O7iCxWX0vqSRf74Brn2pzESg@mail.gmail.com>
	<54AE36AF.3070603@linaro.org>
	<CAL85gmDbZgM48C5UFgOgLiQhDU6sCmF59O_oaN8thYoYP+DFRA@mail.gmail.com>
	<54AEC6D5.1050806@linaro.org>
	<CAOHikRA_CVoao-nBcjb=v-j3oR+s6R6cxZBkvrTxNhF_8UD=5Q@mail.gmail.com>
	<54B4BB4A.9040901@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exprod5og108.obsmtp.com ([64.18.0.186]:34595 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753291AbbCQSWI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2015 14:22:08 -0400
Received: by oier21 with SMTP id r21so16082931oie.1
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2015 11:22:06 -0700 (PDT)
In-Reply-To: <54B4BB4A.9040901@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Suman Tripathi <stripathi@apm.com>, patches <patches@apm.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mark Salter <msalter@redhat.com>, Tejun Heo <tj@kernel.org>, hdegoede@redhat.com

On Mon, Jan 12, 2015 at 10:29 PM, Hanjun Guo <hanjun.guo@linaro.org> wr=
ote:
> On 2015=E5=B9=B401=E6=9C=8813=E6=97=A5 05:07, Suman Tripathi wrote:
>>
>> Hi,
>>
>> Tested-by: Suman Tripathi <stripathi@apm.com>
>>
>> On Thu, Jan 8, 2015 at 11:35 PM, Hanjun Guo <hanjun.guo@linaro.org
>> <mailto:hanjun.guo@linaro.org>> wrote:
>>
>>     On 2015=E5=B9=B401=E6=9C=8809=E6=97=A5 01:56, Feng Kan wrote:
>>
>>         On Wed, Jan 7, 2015 at 11:50 PM, Hanjun Guo
>>         <hanjun.guo@linaro.org <mailto:hanjun.guo@linaro.org>> wrote=
:
>>
>>             Hi Feng Kan,
>>
>>             I have some comments below.
>>
>>
>>             On 2015=E5=B9=B401=E6=9C=8808=E6=97=A5 01:32, Feng Kan w=
rote:
>>
>>
>>                 Just want to ping this again.
>>
>>                 Happy new year
>>
>>                 On Thu, Dec 11, 2014 at 2:31 PM, Feng Kan <fkan@apm.=
com
>>                 <mailto:fkan@apm.com>> wrote:
>>
>>
>>                     This adds ACPI support for the APM X-Gene SATA
>>                     ports. When the system
>>                     boots using ACPI table, the SATA ports are able =
to
>>                     configure using the
>>                     values supplied by the ACPI table rather than th=
e DTS.
>>
>>                     Signed-off-by: Feng Kan <fkan@apm.com
>>                     <mailto:fkan@apm.com>>
>>                     ---
>>                         drivers/ata/ahci_xgene.c | 10 ++++++++++
>>                         1 file changed, 10 insertions(+)
>>
>>                     diff --git a/drivers/ata/ahci_xgene.c
>>                     b/drivers/ata/ahci_xgene.c
>>                     index d0c851a..4951392 100644
>>                     --- a/drivers/ata/ahci_xgene.c
>>                     +++ b/drivers/ata/ahci_xgene.c
>>                     @@ -22,6 +22,7 @@
>>                          * NOTE: PM support is not currently availab=
le.
>>                          *
>>                          */
>>                     +#include <linux/acpi.h>
>>                         #include <linux/module.h>
>>                         #include <linux/platform_device.h>
>>                         #include <linux/ahci_platform.h>
>>                     @@ -521,6 +522,14 @@ disable_resources:
>>                                return rc;
>>                         }
>>
>>                     +#ifdef CONFIG_ACPI
>>                     +static const struct acpi_device_id
>>                     xgene_ahci_acpi_match[] =3D {
>>                     +       { "APMC0D0D", },
>>
>>
>>
>>             When I was going through the PNP and ACPI ID list in
>>             http://www.uefi.org/PNP_ACPI___Registry
>>             <http://www.uefi.org/PNP_ACPI_Registry>, I found that
>>             there is no "APMC" for ACPI ID, I only found that there =
is
>>             a PNP ID "APM" for Applied Memory Tech company, are
>>             you using PNP ID for this one?
>>
>>             if not, I think you can send a request to UEFI and
>>             request a new ACPI ID of "APMC" for Applied Micro, and t=
hen
>>             submit the patch again.
>>
>>             How to send a request to register the ACPI ID, you can
>>             refer to:
>>             http://www.uefi.org/PNP_ACPI___Registry
>>             <http://www.uefi.org/PNP_ACPI_Registry>
>>
>>
>>         Hanjun, the documents are bit out of sync. We have received
>>         approval and
>>         it is present in the document link below. I can also forward=
 the
>>         approval letter
>>         if it needed.
>>
>>
>> http://download.microsoft.com/__download/7/E/7/7E7662CF-CBEA-__470B-=
A97E-CE7CE0D98DC2/ISA%__20PNPID%20List.xlsx
>>
>> <http://download.microsoft.com/download/7/E/7/7E7662CF-CBEA-470B-A97=
E-CE7CE0D98DC2/ISA%20PNPID%20List.xlsx>
>>
>>
>>     Sorry for missing this link, I think I should report this
>>     inconsistency to ACPI spec working group and then update it
>>     accordingly.
>
>
> Also I had reported this issue to ASWG and some people will
> check with this issue and fix it, so
>
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Hi. Is there a chance this can make it into tree. Thanks

>
> Thanks
> Hanjun
