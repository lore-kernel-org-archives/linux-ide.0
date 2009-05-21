From: Gwendal Grignou <gwendal@google.com>
Subject: Re: NCQ sg_io
Date: Thu, 21 May 2009 16:53:35 -0700
Message-ID: <e7510f760905211653t6ccdefdu88d1af8c048fe9bd@mail.gmail.com>
References: <93b143da0905191111o4a0fad8djc1496989060c8b9@mail.gmail.com>
	 <e7510f760905201253s64ff7baer9de28fc7ea77e9f2@mail.gmail.com>
	 <93b143da0905201420l8ba4dd5me9a3df49dafa29e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:35237 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097AbZEUXxh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 May 2009 19:53:37 -0400
Received: from spaceape12.eur.corp.google.com (spaceape12.eur.corp.google.com [172.28.16.146])
	by smtp-out.google.com with ESMTP id n4LNrbcN011545
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2009 16:53:38 -0700
Received: from ewy28 (ewy28.prod.google.com [10.241.103.28])
	by spaceape12.eur.corp.google.com with ESMTP id n4LNrZ2D024573
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2009 16:53:36 -0700
Received: by ewy28 with SMTP id 28so1716396ewy.25
        for <linux-ide@vger.kernel.org>; Thu, 21 May 2009 16:53:35 -0700 (PDT)
In-Reply-To: <93b143da0905201420l8ba4dd5me9a3df49dafa29e0@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Porat <dan.porat@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, May 20, 2009 at 2:20 PM, Dan Porat <dan.porat@gmail.com> wrote:
> Thank plenty for your answer.
>
> So , what is the best way to send NCQ through user space ?
> Is it possible to disable the tagging mechanism by the driver and only
> rely on the tag given by the user space ?
That's one solution, but that's quite risky, it can be difficult to
guarantee nobody else access the disk. Another one is to alter
ata_scsi_pass_thru() to use qc->tag in case of FPDMA command. It is
already calculated before we enter the translation function.
Let me know how it goes,

Gwendal.

>
> Thanks
>
>
> On Wed, May 20, 2009 at 10:53 PM, Gwendal Grignou <gwendal@google.com> wrote:
>> Hi Dan,
>>
>> tf->nsect can not be calculated from user space: the tag must be
>> calculated by the driver.
>>
>> Gwendal.
>>
>> On Tue, May 19, 2009 at 11:11 AM, Dan Porat <dan.porat@gmail.com> wrote:
>>> As I have seen sg_io does not support NCQ in ATA passthrough.
>>> will changing the mapping function libata-scsi.c (line 2745) , work?
>>>
>>> If not , how else can I check the protocol (FPDMA) ?
>>> static u8
>>> 2725ata_scsi_map_proto(u8 byte1)
>>> 2726{
>>> 2727        switch((byte1 & 0x1e) >> 1) {
>>> 2728        case 3:         /* Non-data */
>>> 2729                return ATA_PROT_NODATA;
>>> 2730
>>> 2731        case 6:         /* DMA */
>>> 2732        case 10:        /* UDMA Data-in */
>>> 2733        case 11:        /* UDMA Data-Out */
>>> 2734                return ATA_PROT_DMA;
>>> 2735
>>> 2736        case 4:         /* PIO Data-in */
>>> 2737        case 5:         /* PIO Data-out */
>>> 2738                return ATA_PROT_PIO;
>>> 2739
>>> 2745        case 12:        /* FPDMA */
>>>                       return ATA_PROT_NCQ
>>> 2740        case 0:         /* Hard Reset */
>>> 2741        case 1:         /* SRST */
>>> 2742        case 8:         /* Device Diagnostic */
>>> 2743        case 9:         /* Device Reset */
>>> 2744        case 7:         /* DMA Queued */
>>>
>>> 2746        case 15:        /* Return Response Info */
>>> 2747        default:        /* Reserved */
>>> 2748                break;
>>> 2749        }
>>> 2750
>>> 2751        return ATA_PROT_UNKNOWN;
>>> 2752}
>>>
>>>
>>>
>>> Thanks
>>>
>>> Dan Porat
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>
