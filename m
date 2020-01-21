Return-Path: <SRS0=H5qQ=3K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0AAC2D0CE
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jan 2020 13:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F80220882
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jan 2020 13:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D6loO/rS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgAUNHT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Jan 2020 08:07:19 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54564 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgAUNHT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jan 2020 08:07:19 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00LCx1g6062472;
        Tue, 21 Jan 2020 13:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=sxhmTNU+snsGkd8641ghQkxgbiZcHqDW6xgsy0Zg1sA=;
 b=D6loO/rSfPd37TXyW8VlEna9KvjteVi5ETFAWlNL73toDpp3nmPR8W3XW2WQ+zXdElma
 rHJys4oVxUyXPTZ8oPPFeu97/GLmvQUnmLvUu9B+aKOcr1IVqW608ThPAYIHbZnFyRcr
 /omdZYU5jQhIEplkz6+KJmJthDJ2Wn3aHtV/02bZUEHdUXPWvPsOx22iFqk/wMqHm6zx
 huYwDcgQc5vH4o4xd7Yvw4WXLMay98qt4AlzaNhLg8Bjdc1cYJEU9ODJNDORrbxfIcVi
 30+kgSlSfXvCZbOtLWMEPzme2Nd0AmiNXcu+rIh0q8SckNRgW2Yv0ZU+Ld1PY9xEzBGW IA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xksyq4s9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 13:07:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00LCxNvS185296;
        Tue, 21 Jan 2020 13:07:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2xnsj4jpk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 13:07:06 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00LD75dU018276;
        Tue, 21 Jan 2020 13:07:05 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Jan 2020 05:07:05 -0800
Date:   Tue, 21 Jan 2020 16:06:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ide: make drive->dn read only
Message-ID: <20200121125942.hkr3zg77i5gtgc7v@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89d856ef-7c00-a2b7-bfcc-483c78092d20@samsung.com>
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001210107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001210107
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The IDE core always sets ->dn correctly so changing it is never
required.

Setting it to a different value than assigned by IDE core is very likely
to result in data corruption (due to wrong transfer timings being set on
the controller etc.)

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---

 include/linux/ide.h    | 4 ++++
 drivers/ide/ide-proc.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/ide.h b/include/linux/ide.h
index 06dae6438557..a254841bd315 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -945,6 +945,10 @@ ide_devset_get(_name, _field); \
 ide_devset_set(_name, _field); \
 IDE_DEVSET(_name, DS_SYNC, get_##_name, set_##_name)
 
+#define ide_devset_ro_field(_name, _field) \
+ide_devset_get(_name, _field); \
+IDE_DEVSET(_name, 0, get_##_name, NULL)
+
 #define ide_devset_rw_flag(_name, _field) \
 ide_devset_get_flag(_name, _field); \
 ide_devset_set_flag(_name, _field); \
diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index 11a801aa92d8..15c17f3781ee 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -206,7 +206,7 @@ static int set_xfer_rate (ide_drive_t *drive, int arg)
 ide_devset_rw(current_speed, xfer_rate);
 ide_devset_rw_field(init_speed, init_speed);
 ide_devset_rw_flag(nice1, IDE_DFLAG_NICE1);
-ide_devset_rw_field(number, dn);
+ide_devset_ro_field(number, dn);
 
 static const struct ide_proc_devset ide_generic_settings[] = {
 	IDE_PROC_DEVSET(current_speed, 0, 70),
-- 
2.11.0

