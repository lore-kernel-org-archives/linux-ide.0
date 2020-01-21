Return-Path: <SRS0=H5qQ=3K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAB1C2D0CE
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jan 2020 14:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E697A2087E
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jan 2020 14:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jBZNaSdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgAUOSD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:18:03 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46504 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbgAUOSC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jan 2020 09:18:02 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00LECbP2126599;
        Tue, 21 Jan 2020 14:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=wMyjKPkb/ldQtYDPiDTSnJ182QJqhmu05G31vnwN+Ow=;
 b=jBZNaSdiVNGM59iWMzN6A7A/B39QM0pEQZMuUXOBDYxoDihWBgcOXeWsEbfJk5oUczza
 QNdR7EeI+1ooaxwYKBUzKfWLSg/accLcmfzwz/p0qJoj4+c7U/kXNlUN7dqlr1S2EwG2
 RkMTp0n9H8EED/0eAJsjY0sd0228XmZBjjp9K5IEGZadTUW7UbT4wNBFIpAuKZNK9wa9
 ueXGiWK8xknESA/tZki2g8LnkiCfFzKkfQKEWVd9Yvq74J34kt7wHViGzOpCfdTO3mrG
 5hs5amc+XfYrWkaJ9w1Aqt+U9OstBjj1EWpN73xLwdPvsYkOFDnEXZ7Os6LfGhVeb9GJ Qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xksyq569a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 14:17:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00LEE7dE104634;
        Tue, 21 Jan 2020 14:17:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2xnpee1se7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 14:17:50 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00LEHolP016616;
        Tue, 21 Jan 2020 14:17:50 GMT
Received: from kadam (/10.175.179.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Jan 2020 06:17:49 -0800
Date:   Tue, 21 Jan 2020 17:17:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ide: make drive->dn read only
Message-ID: <20200121141742.GB1870@kadam>
References: <CGME20200121130719eucas1p15e8bc52b9167b48a1eb7be191ef103f5@eucas1p1.samsung.com>
 <20200121125942.hkr3zg77i5gtgc7v@kili.mountain>
 <beada2e3-29bd-2165-b6d7-d28a8c83060e@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beada2e3-29bd-2165-b6d7-d28a8c83060e@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001210118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001210118
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Jan 21, 2020 at 03:13:29PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> On 1/21/20 2:06 PM, Dan Carpenter wrote:
> > The IDE core always sets ->dn correctly so changing it is never
> > required.
> > 
> > Setting it to a different value than assigned by IDE core is very likely
> > to result in data corruption (due to wrong transfer timings being set on
> > the controller etc.)
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Thanks, it looks fine (though patch summary can be improved further i.e.:
> "[PATCH] ide-proc: make "number" setting read-only").
> 
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> I've also verified it (using ARAnyM emulator):
> 
> Tested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 

Thanks!

regards,
dan carpenter

