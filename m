Return-Path: <SRS0=TxtD=3S=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DDDC2D0DB
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jan 2020 17:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99DE206F0
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jan 2020 17:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e7L2TCwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgA2RrQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 29 Jan 2020 12:47:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41992 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgA2RrP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jan 2020 12:47:15 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00THcwLG126119;
        Wed, 29 Jan 2020 17:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=lwS0OgyEz/S/yIRyeJcc23PQIQm2EF2vWGxSVmIUGAA=;
 b=e7L2TCwetOgu6k5B5Z8EaCNGYbwyufGq0Z8/k1USa5mC8uk+J9qwFtymmQmDx8s4dBJK
 S5la3Bz0Ulowu0vrLKnEnJjqArbZiq8/vQGR9q4vBXfqkly3YF34QLh6+Q4+L+m9bfYW
 DcR+4yktC0OVgXRmYODEmOlRU5vDRCWkmiwXfUS7ehW0Z4rXmKOn+N08XLnpb1UWG6rX
 H92gHFWdF78Kpx/YhBV8pW5dVN0VlIzv+PH0X+WcdvFBKo/K4IcviN6UXWzLTaXbGKmk
 Lk6l+jZfdocS1OLRugjM4382estGhzX4MrfNjTnw84UEzRVMi0Wg1EA4rvlD18SZMRfm Fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xrd3uf33d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 17:46:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00THcF2d053105;
        Wed, 29 Jan 2020 17:46:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xu8e6ta9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 17:46:52 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00THkofY002378;
        Wed, 29 Jan 2020 17:46:50 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jan 2020 09:46:50 -0800
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/28] ata: start separating SATA specific code from libata-scsi.c
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133418eucas1p157933935f14f9c83c604bc5dc38bcbae@eucas1p1.samsung.com>
        <20200128133343.29905-25-b.zolnierkie@samsung.com>
        <20200129173156.GL12616@infradead.org>
Date:   Wed, 29 Jan 2020 12:46:46 -0500
In-Reply-To: <20200129173156.GL12616@infradead.org> (Christoph Hellwig's
        message of "Wed, 29 Jan 2020 09:31:56 -0800")
Message-ID: <yq1h80e6tq1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001290145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001290145
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Christoph,

> On Tue, Jan 28, 2020 at 02:33:39PM +0100, Bartlomiej Zolnierkiewicz wrote:
>> * include libata-scsi-sata.c in the build when CONFIG_SATA_HOST=y
>
> The libata-core.c vs libata-scsi.c split already is a bit weird, any
> reason not to simply have a single libata-sata.c?

I agree, I also tripped over libata-scsi-sata.

-- 
Martin K. Petersen	Oracle Linux Engineering
