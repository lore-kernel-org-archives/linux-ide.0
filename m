From: Dan Porat <dan.porat@gmail.com>
Subject: Re: NCQ sg_io
Date: Thu, 21 May 2009 00:20:27 +0300
Message-ID: <93b143da0905201420l8ba4dd5me9a3df49dafa29e0@mail.gmail.com>
References: <93b143da0905191111o4a0fad8djc1496989060c8b9@mail.gmail.com>
	 <e7510f760905201253s64ff7baer9de28fc7ea77e9f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:8116 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbZETVU1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 May 2009 17:20:27 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1188013fga.17
        for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 14:20:27 -0700 (PDT)
In-Reply-To: <e7510f760905201253s64ff7baer9de28fc7ea77e9f2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: linux-ide@vger.kernel.org

Thank plenty for your answer.

So , what is the best way to send NCQ through user space ?
Is it possible to disable the tagging mechanism by the driver and only
rely on the tag given by the user space ?

Thanks


On Wed, May 20, 2009 at 10:53 PM, Gwendal Grignou <gwendal@google.com> =
wrote:
> Hi Dan,
>
> tf->nsect can not be calculated from user space: the tag must be
> calculated by the driver.
>
> Gwendal.
>
> On Tue, May 19, 2009 at 11:11 AM, Dan Porat <dan.porat@gmail.com> wro=
te:
>> As I have seen sg_io does not support NCQ in ATA passthrough.
>> will changing the mapping function libata-scsi.c (line 2745) , work?
>>
>> If not , how else can I check the protocol (FPDMA) ?
>> static u8
>> 2725ata_scsi_map_proto(u8 byte1)
>> 2726{
>> 2727 =A0 =A0 =A0 =A0switch((byte1 & 0x1e) >> 1) {
>> 2728 =A0 =A0 =A0 =A0case 3: =A0 =A0 =A0 =A0 /* Non-data */
>> 2729 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ATA_PROT_NODATA;
>> 2730
>> 2731 =A0 =A0 =A0 =A0case 6: =A0 =A0 =A0 =A0 /* DMA */
>> 2732 =A0 =A0 =A0 =A0case 10: =A0 =A0 =A0 =A0/* UDMA Data-in */
>> 2733 =A0 =A0 =A0 =A0case 11: =A0 =A0 =A0 =A0/* UDMA Data-Out */
>> 2734 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ATA_PROT_DMA;
>> 2735
>> 2736 =A0 =A0 =A0 =A0case 4: =A0 =A0 =A0 =A0 /* PIO Data-in */
>> 2737 =A0 =A0 =A0 =A0case 5: =A0 =A0 =A0 =A0 /* PIO Data-out */
>> 2738 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ATA_PROT_PIO;
>> 2739
>> 2745 =A0 =A0 =A0 =A0case 12: =A0 =A0 =A0 =A0/* FPDMA */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ATA_PROT_NCQ
>> 2740 =A0 =A0 =A0 =A0case 0: =A0 =A0 =A0 =A0 /* Hard Reset */
>> 2741 =A0 =A0 =A0 =A0case 1: =A0 =A0 =A0 =A0 /* SRST */
>> 2742 =A0 =A0 =A0 =A0case 8: =A0 =A0 =A0 =A0 /* Device Diagnostic */
>> 2743 =A0 =A0 =A0 =A0case 9: =A0 =A0 =A0 =A0 /* Device Reset */
>> 2744 =A0 =A0 =A0 =A0case 7: =A0 =A0 =A0 =A0 /* DMA Queued */
>>
>> 2746 =A0 =A0 =A0 =A0case 15: =A0 =A0 =A0 =A0/* Return Response Info =
*/
>> 2747 =A0 =A0 =A0 =A0default: =A0 =A0 =A0 =A0/* Reserved */
>> 2748 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> 2749 =A0 =A0 =A0 =A0}
>> 2750
>> 2751 =A0 =A0 =A0 =A0return ATA_PROT_UNKNOWN;
>> 2752}
>>
>>
>>
>> Thanks
>>
>> Dan Porat
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-ide"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
