From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
Subject: Re: [patch 05/25] ata: add the SW NCQ support to sata_nv for MCP51/MCP55/MCP61
Date: Wed, 26 Sep 2007 07:46:11 +0200
Message-ID: <46F9F223.4000406@dunaweb.hu>
References: <200708102059.l7AKxYVQ008581@imap1.linux-foundation.org> <46F2F6E5.3010406@garzik.org> <46F35C7F.20400@dunaweb.hu> <46F9D6A8.8010809@garzik.org> <46F9EFC9.9030209@dunaweb.hu> <46F9F05F.40905@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from linux.dunaweb.hu ([62.77.196.1]:50869 "EHLO linux.dunaweb.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbXIZFqR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Sep 2007 01:46:17 -0400
In-Reply-To: <46F9F05F.40905@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, kluo@nvidia.com, pchen@nvidia.com, Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org

Jeff Garzik =EDrta:
> Zoltan Boszormenyi wrote:
>> Jeff Garzik =EDrta:
>>> Zoltan Boszormenyi wrote:
>>>> Hi,
>>>>
>>>> Jeff Garzik =EDrta:
>>>>> akpm@linux-foundation.org wrote:
>>>>>> From: Kuan Luo <kluo@nvidia.com>
>>>>>>
>>>>>> Add the Software NCQ support to sata_nv.c for MCP51/MCP55/MCP61 =
SATA
>>>>>> controller.  NCQ function is disable by default, you can enable=20
>>>>>> it with
>>>>>> 'swncq=3D1'.  NCQ will be turned off if the drive is Maxtor on=20
>>>>>> MCP51 or MCP55
>>>>>> rev 0xa2 platform.
>>>>>>
>>>>>> [akpm@linux-foundation.org: build fix]
>>>>>> Signed-off-by: Kuan Luo <kluo@nvidia.com>
>>>>>> Signed-off-by: Peer Chen <pchen@nvidia.com>
>>>>>> Cc: Zoltan Boszormenyi <zboszor@dunaweb.hu>
>>>>>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>>>>> ---
>>>>>>
>>>>>>  drivers/ata/sata_nv.c |  860=20
>>>>>> +++++++++++++++++++++++++++++++++++++++-
>>>>>>  1 files changed, 851 insertions(+), 9 deletions(-)
>>>>>
>>>>> I finally gave this a thorough review.
>>>>>
>>>>> Overall, good work.  The state transitions all seem solid.  I mad=
e=20
>>>>> several minor changes and cleanups, and checked it into the=20
>>>>> 'nv-swncq' branch of=20
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.=
git
>>>>>
>>>>> Two hurdles before I'm ready to push upstream:
>>>>>
>>>>> * someone please verify my minor changes did not break anything; =
I=20
>>>>> don't have real hardware
>>>>
>>>> After reading the diff between the original and your cleaned up=20
>>>> version
>>>> it seems both the change from 4 individual flags to a single=20
>>>> integer and the
>>>> nv_swncq_bmdma_stop() -> __ata_bmdma_stop() transition are=20
>>>> obviously correct.
>>>> I attached a small cleanup patch which may make one check a bit=20
>>>> more readable.
>>>>
>>>> However, can you explain this chunk below? Why isn't it needed?
>>>>
>>>> @@ -615,7 +622,6 @@ static const struct ata_port_info nv_por
>>>>        {
>>>>                .sht            =3D &nv_swncq_sht,
>>>>                .flags          =3D ATA_FLAG_SATA | ATA_FLAG_NO_LEG=
ACY,
>>>> -               .link_flags     =3D ATA_LFLAG_HRST_TO_RESUME,
>>>>                .pio_mask       =3D NV_PIO_MASK,
>>>>                .mwdma_mask     =3D NV_MWDMA_MASK,
>>>>                .udma_mask      =3D NV_UDMA_MASK,
>>>
>>> that's a bug.  fixed.
>>>
>>> I also applied your cleanup.
>>
>> Thanks, but you took the wrong cleanup patch.
>> My original, i.e. this chunk below is wrong.
>>
>> @@ -2291,8=20
>> <http://git.kernel.org/?p=3Dlinux/kernel/git/jgarzik/libata-dev.git;=
a=3Dblob;f=3Ddrivers/ata/sata_nv.c;h=3D540f218e10e56c8a85a937bc920a5d96=
434bcc8f;hb=3D41f0f8af3edfccd58b5c9d714928d773a072b693#l2291>=20
>> +2283,7=20
>> <http://git.kernel.org/?p=3Dlinux/kernel/git/jgarzik/libata-dev.git;=
a=3Dblob;f=3Ddrivers/ata/sata_nv.c;h=3Dffd00f5c533d7b58dde67cfef7d2191c=
a15ea140;hb=3D5a5a9e1890b8260686218a68862d880daee1a817#l2283>=20
>> @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
>>                 */
>>                pp->dhfis_bits |=3D (0x1 << pp->last_issue_tag);
>>                pp->ncq_flags |=3D ncq_saw_d2h;
>> -               if ((pp->ncq_flags & ncq_saw_sdb) ||
>> -                   (pp->ncq_flags & ncq_saw_backout)) {
>> +               if (pp->ncq_flags & (ncq_saw_sdb || ncq_saw_backout)=
) {
>>                        ata_ehi_push_desc(ehi, "illegal fis=20
>> transaction");
>>                        ehi->err_mask |=3D AC_ERR_HSM;
>>                        ehi->action |=3D ATA_EH_HARDRESET;
>>
>> It should be a binary OR between the flags. This caused immediate
>> NCQ errors upon boot and lead to disabling NCQ.
>> My second patch has it corrected.
>
> fixed

Thanks. And would you please also enable swncq by default? :-)
It's very stable.

Best regards,
Zolt=E1n B=F6sz=F6rm=E9nyi


