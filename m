Return-Path: <SRS0=z20e=XV=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA97C4360C
	for <linux-ide@archiver.kernel.org>; Thu, 26 Sep 2019 22:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B36720835
	for <linux-ide@archiver.kernel.org>; Thu, 26 Sep 2019 22:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="azeLIFk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfIZWBV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Sep 2019 18:01:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47384 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbfIZWBV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Sep 2019 18:01:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8QLwdbg073477;
        Thu, 26 Sep 2019 22:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=EB5I11fp/sugBNR0Bk95vLcbosGFf8qCInfwQyXL1Ks=;
 b=azeLIFk53uuKYvu4fqV1LT9fcHW8tyxOHrIicdZzMjJocFyEsWN1Cvs3/gjmDxlFMPsT
 gnn/Aw9pZJIH9OEliCdjkDsT0zkm5WkCLVNfRtoKId5cJMTCVFOzzzEobtJ/Vxi5OtWD
 2Djr6azcKVEqJ7TGjvRx2uTt4cDLv5PZFRwSgwzpMZFmIw3kdZNIrCU2ESxsdU3l2dvt
 5JmsEs3j+n7em1lcCxGMGGTQS7qJY1UxP0M3MNFYUDiCFWvH2ARYPDvGtuhlXevPvomo
 r1lewxJqzZPGv3OtoYEcFVF3hloY27UnwE/uXdn7WYorVULVgpxtSsP05/XvLqbGIFVl EA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2v5cgregt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 22:01:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8QLwmVH123295;
        Thu, 26 Sep 2019 22:01:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2v8yjx6cgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 22:01:08 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8QM17Qg010299;
        Thu, 26 Sep 2019 22:01:07 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Sep 2019 15:01:06 -0700
To:     Stefan Tauner <tauner@technikum-wien.at>
Cc:     linux-ide@vger.kernel.org
Subject: Re: Questions (and a possible bug) regarding the ata_device_blacklist and ATA_HORKAGE_ZERO_AFTER_TRIM
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190926150400.2524a63b@legacy>
Date:   Thu, 26 Sep 2019 18:01:03 -0400
In-Reply-To: <20190926150400.2524a63b@legacy> (Stefan Tauner's message of
        "Thu, 26 Sep 2019 15:04:00 +0200")
Message-ID: <yq1pnjm1zvk.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9392 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909260173
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9392 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909260173
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Stefan,

> I don't know the technical details how this is communicated by the
> drive but I assume it's the same thing that smartctl and hdparm output
> as "Model Number" and "Device Model" respectively.

Yes.

> If this is correct (is it?) then there is a problem with the list
> AFAICT because the Crucial SSD I have reports this field simply as
> "CT500MX500SSD4" but the kernel expects "Crucial" at the beginning of
> almost all Crucial drives (line 4523+) including the vendor wildcard at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/libata-core.c#n4586
> Interestingly, in line 4520 there is an entry for the CT500BX100SSD1
> that does not start with "Crucial".

With a few exceptions, the entries in the libata white/blacklist were
submitted by Crucial/Micron themselves. But it's possible that they
changed their naming scheme.

> After looking into smartctl's drive database I guess the MX500 [2] (as
> well as BX100, BX200, BX300 and BX500 [1]) series stand out in this
> regard. This means that all of them do *not* get the
> ATA_HORKAGE_ZERO_AFTER_TRIM flag set because they are not matched by
> any of the model-specific entries nor the cumulative "Crucial*" vendor
> entry.

The newest drives I have are M550 models.

> I have not tested my drive to actually return zeros after trimming but
> from the kernel code I would assume that its intent is to match all
> Crucial SSDs and thus it is a bug mine is not matched. If someone
> tells me to the preferred method to test it I am happy to do this. If
> need be I can also submit a patch (just for MX500? all of the above?).

There's no way to exhaustively test. Many drives will return zeroes most
of the time but can have corner conditions that cause them to ignore
TRIM commands.

The ones we whitelisted were as a result of feedback from the vendors
themselves (thanks to an advertised qualification for use with hardware
RAID5 controllers). As you know, there is no way for a drive to express
this capability/guarantee in the ATA protocol.

> Is there any way to see which flags the kernel applies to a drive?

# grep . /sys/class/ata_device/*/trim
/sys/class/ata_device/dev1.0/trim:unqueued
/sys/class/ata_device/dev2.0/trim:queued

> Interestingly, "lsblk -D" does only show "0" for the Samsung device
> (although AFAICT it is matched by the white list AND reports
> "Deterministic read ZEROs after TRIM" according to hdparm. But I don't
> know what lsblk actually looks at...?

lsblk looks at /sys/block/*/queue/discard*

You get "0" for the discard granularity on the Samsung?

-- 
Martin K. Petersen	Oracle Linux Engineering
