From: Gwendal Grignou <gwendal@google.com>
Subject: Re: NCQ sg_io
Date: Wed, 20 May 2009 12:53:05 -0700
Message-ID: <e7510f760905201253s64ff7baer9de28fc7ea77e9f2@mail.gmail.com>
References: <93b143da0905191111o4a0fad8djc1496989060c8b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:31814 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbZETTxJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 May 2009 15:53:09 -0400
Received: from spaceape7.eur.corp.google.com (spaceape7.eur.corp.google.com [172.28.16.141])
	by smtp-out.google.com with ESMTP id n4KJrAFH030566
	for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 12:53:10 -0700
Received: from bwz26 (bwz26.prod.google.com [10.188.26.26])
	by spaceape7.eur.corp.google.com with ESMTP id n4KJr5Sq014889
	for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 12:53:07 -0700
Received: by bwz26 with SMTP id 26so651673bwz.7
        for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 12:53:05 -0700 (PDT)
In-Reply-To: <93b143da0905191111o4a0fad8djc1496989060c8b9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Porat <dan.porat@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi Dan,

tf->nsect can not be calculated from user space: the tag must be
calculated by the driver.

Gwendal.

On Tue, May 19, 2009 at 11:11 AM, Dan Porat <dan.porat@gmail.com> wrote:
> As I have seen sg_io does not support NCQ in ATA passthrough.
> will changing the mapping function libata-scsi.c (line 2745) , work?
>
> If not , how else can I check the protocol (FPDMA) ?
> static u8
> 2725ata_scsi_map_proto(u8 byte1)
> 2726{
> 2727        switch((byte1 & 0x1e) >> 1) {
> 2728        case 3:         /* Non-data */
> 2729                return ATA_PROT_NODATA;
> 2730
> 2731        case 6:         /* DMA */
> 2732        case 10:        /* UDMA Data-in */
> 2733        case 11:        /* UDMA Data-Out */
> 2734                return ATA_PROT_DMA;
> 2735
> 2736        case 4:         /* PIO Data-in */
> 2737        case 5:         /* PIO Data-out */
> 2738                return ATA_PROT_PIO;
> 2739
> 2745        case 12:        /* FPDMA */
>                       return ATA_PROT_NCQ
> 2740        case 0:         /* Hard Reset */
> 2741        case 1:         /* SRST */
> 2742        case 8:         /* Device Diagnostic */
> 2743        case 9:         /* Device Reset */
> 2744        case 7:         /* DMA Queued */
>
> 2746        case 15:        /* Return Response Info */
> 2747        default:        /* Reserved */
> 2748                break;
> 2749        }
> 2750
> 2751        return ATA_PROT_UNKNOWN;
> 2752}
>
>
>
> Thanks
>
> Dan Porat
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
