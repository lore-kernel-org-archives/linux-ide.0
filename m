Return-Path: <SRS0=juF9=EF=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D908C4741F
	for <linux-ide@archiver.kernel.org>; Fri, 30 Oct 2020 14:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E7C2076E
	for <linux-ide@archiver.kernel.org>; Fri, 30 Oct 2020 14:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mji+/Cqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgJ3OIL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 30 Oct 2020 10:08:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51740 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJ3OIL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Oct 2020 10:08:11 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UBk6rL151547;
        Fri, 30 Oct 2020 11:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=s3tHlzB0xCGIK7yOwzACZQHeo2e//7rXl3a/1W9LG3w=;
 b=mji+/CqxaWQs11hQK+l6m0G8jy49CU8lI5i+d1zteXyQUiK2/qxKfqhlzcHEf7xfhRqS
 DRwbRhB0YrtrsIVDDWWloDSs7CkCnMjJv2Oa3DYuVAisqvcJmJSnBSs2IXGtg8hjjVel
 gP++V2gjn2zO6xrqankqNXe7xhK7DSRAlN7P8jgRnRGhNZQmaq2pvJWBVJCQohYfki5Y
 PHgZ3iv7NUEwjhgZezPwVazzL+z79agaslzKpn0uNxfNmOWaHy6lmBdLpbG8EMqqAHin
 ES/B08Zdw+amU/azdKk1BOnhuQYMloqo91sew1w/JNfMUiIOZJ+Qxup2ZYa690RGFQjm Kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34c9sb9fc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Oct 2020 11:51:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UBjVOF008711;
        Fri, 30 Oct 2020 11:51:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 34cx70m4mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Oct 2020 11:51:10 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09UBp9iE024367;
        Fri, 30 Oct 2020 11:51:09 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Oct 2020 04:51:08 -0700
Date:   Fri, 30 Oct 2020 14:51:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] ide: Prevent some negative shifts in ide_set_ignore_cable()
Message-ID: <20201030115102.GE3251003@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010300091
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Shifting by a negative number is undefined.  These values come from the
module parameter, so it's not a big deal from a practical perspective.

Fixes: 9fd91d959f1a ("ide: add "ignore_cable" parameter (take 2)")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/ide/ide.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index 9a9c64fd1032..dcfb8a187c46 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -338,7 +338,7 @@ static int ide_set_ignore_cable(const char *s, const struct kernel_param *kp)
 	if (sscanf(s, "%d:%d", &i, &j) != 2 && sscanf(s, "%d", &i) != 1)
 		return -EINVAL;
 
-	if (i >= MAX_HWIFS || j < 0 || j > 1)
+	if (i < 0 || i >= MAX_HWIFS || j < 0 || j > 1)
 		return -EINVAL;
 
 	if (j)
-- 
2.28.0

