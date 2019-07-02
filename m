Return-Path: <SRS0=9A0L=VA=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2839CC5B57D
	for <linux-ide@archiver.kernel.org>; Wed,  3 Jul 2019 00:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019E8218EA
	for <linux-ide@archiver.kernel.org>; Wed,  3 Jul 2019 00:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dt6CEbOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfGCAvR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:51:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36538 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfGCAvR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jul 2019 20:51:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x62KdB0N122060;
        Tue, 2 Jul 2019 20:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Btqnb6jEsDeij5wx3tEbk8C4VGfyI72sDX9/2IUYuwQ=;
 b=dt6CEbOA94XnSB2ajoPrdODN/IRZihtm6hLroe+UySMPTmluP474hjbDVuIEG70wDLUJ
 S1vzethdz3jVrM718BTcdnNgpZF5A4sSoGPQrfVuWKtjHL59ZiUWwQ5UBrofDxqPO4mz
 xR3sMO+vYHi5iRm71GO+KGSrt348LuB6rITyjPbtkivAd9TQMFFyF5V4kfqgcSPsFM5K
 UoEIws07MLulsUk6HOMy7Bw75JGIxdEV3Na2EXeMHse+6jYtddbwMKrsm/P4cgKaFjC0
 jgy8qrZX3XqcCaZEhn57qXi+gzqGdnp1sR5OMpGZn6tnw1TlKPcZu9U7rWIY2TLFyKA6 Dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2te61e5v8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 20:41:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x62Kc6t1073119;
        Tue, 2 Jul 2019 20:41:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2tebkug4fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 20:41:47 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x62Kfkqw025134;
        Tue, 2 Jul 2019 20:41:46 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jul 2019 13:41:45 -0700
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] libata: Drop firmware version check from the ST1000LM024 quirk
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190701165813.15607-1-hdegoede@redhat.com>
Date:   Tue, 02 Jul 2019 16:41:44 -0400
In-Reply-To: <20190701165813.15607-1-hdegoede@redhat.com> (Hans de Goede's
        message of "Mon, 1 Jul 2019 18:58:13 +0200")
Message-ID: <yq1h884f9tj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9306 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=949
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907020228
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9306 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907020228
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Hans,

> There are several firmware versions between version 2AR10001 and
> 2BA30001, presumably these also have broken FPDMA_AA activation, so
> lets play it safe and apply the quirk to all firmware versions.

Looks good.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
