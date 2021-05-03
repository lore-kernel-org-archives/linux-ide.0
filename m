Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC82AC43460
	for <linux-ide@archiver.kernel.org>; Mon,  3 May 2021 14:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B53611CB
	for <linux-ide@archiver.kernel.org>; Mon,  3 May 2021 14:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhECOza (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 3 May 2021 10:55:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54220 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhECOz3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 3 May 2021 10:55:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143Esabn017915;
        Mon, 3 May 2021 14:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=it8TZnimk/hdDtUjvLPilylVGsPVscDKQcO/oRqnLh0=;
 b=uIjV32lUwDZGb16zefFNXWRtMWiRgTJBa4YIefDhMcv+K4Tm2IdLlnO5Y2V5PaaOWgKJ
 khBF5n2SYUXb/uftQEcQYTttZfs9DCXqpkgX2es0AcPXwZ6RchTac3trxpq6PArMcEg1
 wcfaNgprSBr0L4+612yXursN7f5f4Ri8GUfjUSC0dd8smrIzY9THlARqABpC3jNzEPRj
 m5qXymT6NtgSEzkLchw/hG+jGwK/kAY1L3hN+3zoF8bUqAP0vx+lx3xOea3k/Mp+49/3
 p87M4zOrhTrLN37i1WQDRROKLiB1kVUdJEgNhgasgwpSs80lxr7P2o1cf2144h/d1gTw rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 388xxmuvg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 14:54:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143Ep9xH033402;
        Mon, 3 May 2021 14:54:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 388v3v2un5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 14:54:35 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 143Er1lb054655;
        Mon, 3 May 2021 14:54:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 388v3v2umg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 14:54:35 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 143EsYqG007039;
        Mon, 3 May 2021 14:54:34 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 May 2021 07:54:33 -0700
Date:   Mon, 3 May 2021 17:54:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     piyush.mehta@xilinx.com
Cc:     linux-ide@vger.kernel.org
Subject: [bug report] ata: ahci: ceva: Update the driver to support xilinx GT
 phy
Message-ID: <YJAOpC/HepmKJPsC@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: SWCSh86I-djlKOmiwOn6gEJRzi7I4DYK
X-Proofpoint-ORIG-GUID: SWCSh86I-djlKOmiwOn6gEJRzi7I4DYK
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030104
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello Piyush Mehta,

The patch 9a9d3abe24bb: "ata: ahci: ceva: Update the driver to
support xilinx GT phy" from Feb 8, 2021, leads to the following
static checker warning:

	drivers/ata/ahci_ceva.c:213 ceva_ahci_probe()
	warn: pointer error 'PTR_ERR(cevapriv->rst)' not handled

drivers/ata/ahci_ceva.c
   192  static int ceva_ahci_probe(struct platform_device *pdev)
   193  {
   194          struct device_node *np = pdev->dev.of_node;
   195          struct device *dev = &pdev->dev;
   196          struct ahci_host_priv *hpriv;
   197          struct ceva_ahci_priv *cevapriv;
   198          enum dev_dma_attr attr;
   199          int rc;
   200  
   201          cevapriv = devm_kzalloc(dev, sizeof(*cevapriv), GFP_KERNEL);
   202          if (!cevapriv)
   203                  return -ENOMEM;
   204  
   205          cevapriv->ahci_pdev = pdev;
   206  
   207          cevapriv->rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
   208                                                                    NULL);
   209          if (IS_ERR(cevapriv->rst))
   210                  dev_err_probe(&pdev->dev, PTR_ERR(cevapriv->rst),
   211                                "failed to get reset\n");


The function just continues if "cevapriv->rst" is an error pointer.  We
should probably return an error, because the user asked us to do
something and we failed.  Another option is to set it to NULL.

   212  
   213          hpriv = ahci_platform_get_resources(pdev, 0);
   214          if (IS_ERR(hpriv))
   215                  return PTR_ERR(hpriv);
   216  
   217          if (!cevapriv->rst) {

It's an error pointer so it's not NULL

   218                  rc = ahci_platform_enable_resources(hpriv);
   219                  if (rc)
   220                          return rc;
   221          } else {
   222                  int i;
   223  
   224                  rc = ahci_platform_enable_clks(hpriv);
   225                  if (rc)
   226                          return rc;
   227                  /* Assert the controller reset */
   228                  reset_control_assert(cevapriv->rst);
                                             ^^^^^^^^^^^^^
This will trigger a WARN_ON().

   229  
   230                  for (i = 0; i < hpriv->nports; i++) {
   231                          rc = phy_init(hpriv->phys[i]);

regards,
dan carpenter
