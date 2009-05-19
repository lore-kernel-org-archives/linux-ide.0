From: Dan Porat <dan.porat@gmail.com>
Subject: NCQ sg_io
Date: Tue, 19 May 2009 14:11:57 -0400
Message-ID: <93b143da0905191111o4a0fad8djc1496989060c8b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:63316 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952AbZESSL5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2009 14:11:57 -0400
Received: by fg-out-1718.google.com with SMTP id d23so920309fga.17
        for <linux-ide@vger.kernel.org>; Tue, 19 May 2009 11:11:58 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

As I have seen sg_io does not support NCQ in ATA passthrough.
will changing the mapping function libata-scsi.c (line 2745) , work?

If not , how else can I check the protocol (FPDMA) ?
static u8
2725ata_scsi_map_proto(u8 byte1)
2726{
2727        switch((byte1 & 0x1e) >> 1) {
2728        case 3:         /* Non-data */
2729                return ATA_PROT_NODATA;
2730
2731        case 6:         /* DMA */
2732        case 10:        /* UDMA Data-in */
2733        case 11:        /* UDMA Data-Out */
2734                return ATA_PROT_DMA;
2735
2736        case 4:         /* PIO Data-in */
2737        case 5:         /* PIO Data-out */
2738                return ATA_PROT_PIO;
2739
2745        case 12:        /* FPDMA */
                       return ATA_PROT_NCQ
2740        case 0:         /* Hard Reset */
2741        case 1:         /* SRST */
2742        case 8:         /* Device Diagnostic */
2743        case 9:         /* Device Reset */
2744        case 7:         /* DMA Queued */

2746        case 15:        /* Return Response Info */
2747        default:        /* Reserved */
2748                break;
2749        }
2750
2751        return ATA_PROT_UNKNOWN;
2752}



Thanks

Dan Porat
