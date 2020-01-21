Return-Path: <SRS0=H5qQ=3K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265AFC2D0CE
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jan 2020 11:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC70C2253D
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jan 2020 11:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kUmWb58v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgAULzb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:55:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44442 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgAULzb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jan 2020 06:55:31 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00LBrQ4t049836;
        Tue, 21 Jan 2020 11:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=zBdqAA4BOQgFITAGeYfb5IM0FCacLYaCNGSteW28NRw=;
 b=kUmWb58vbPPMkVaSaPym3eMXjGh8juZrFbcy8p3eP/ACP2a/mWeO1tZAlxA2L40RE6Ss
 s0h+Mh89TKhW0Zt1Lh25JHc6pf7i1Ulh2KuasSxFOy902KocEoQY7YBz/v3n+nRJplUB
 G1RyGOi6BGX+kOOZP8CP3+OLsJJUq2IG8H7x/NXSBeopmJOA8nVhNoLA9eiH/swBHzZd
 uR+j2n/YEC5nT5l4zsabxyDOwdozfstThIb+Fg82DkZHbTHd0HIehorT+aOIymoVT5d6
 ThLK3ysH6QleZ/6lqIo9RpHXsrww2/dMhyGo0VffcOb2FkjXfZeM0Wbb+otIgyicIMKD 5g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xkseuckjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 11:55:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00LBs7Rs031564;
        Tue, 21 Jan 2020 11:55:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xnsj4ex8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 11:55:25 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00LBtNd6032589;
        Tue, 21 Jan 2020 11:55:23 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Jan 2020 03:55:22 -0800
Date:   Tue, 21 Jan 2020 14:55:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: Re: [PATCH 1/2] cmd64x: potential buffer overflow in
 cmd64x_program_timings()
Message-ID: <20200121115514.GA1870@kadam>
References: <20200107130441.y3owvcnxdljailt5@kili.mountain>
 <20200120.144042.1810086369376110530.davem@davemloft.net>
 <CGME20200121111555eucas1p2d26b5230ab428f40ee3fc76d687e601f@eucas1p2.samsung.com>
 <faf4b367-29b3-474c-73bc-400f6ab36758@samsung.com>
 <20200121114835.GB1847@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121114835.GB1847@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001210101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001210101
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Jan 21, 2020 at 02:48:35PM +0300, Dan Carpenter wrote:
> On Tue, Jan 21, 2020 at 12:15:54PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> > 
> > On 1/20/20 2:40 PM, David Miller wrote:
> > > From: Dan Carpenter <dan.carpenter@oracle.com>
> > > Date: Tue, 7 Jan 2020 16:04:41 +0300
> > > 
> > >> The "drive->dn" value is a u8 and it is controlled by root only, but
> > >> it could be out of bounds here so let's check.
> > 
> > drive->dn should not be root controllable, please point me where it
> > happens as this may need fixing instead of cmd64x driver.
> > 
> > [ IDE core makes sure that drive->dn is never > 3 and a lot of code
> >   assumes it. ]
> > 
> 
> It's a marked as a setable field in ide-proc.c
> 
> drivers/ide/ide-proc.c
>    206  ide_devset_rw(current_speed, xfer_rate);
>    207  ide_devset_rw_field(init_speed, init_speed);
>    208  ide_devset_rw_flag(nice1, IDE_DFLAG_NICE1);
>    209  ide_devset_rw_field(number, dn);
>                             ^^^^^^^^^^
> Sets ->dn
> 
>    210  
>    211  static const struct ide_proc_devset ide_generic_settings[] = {
>    212          IDE_PROC_DEVSET(current_speed, 0, 70),
>    213          IDE_PROC_DEVSET(init_speed, 0, 70),
>    214          IDE_PROC_DEVSET(io_32bit,  0, 1 + (SUPPORT_VLB_SYNC << 1)),
>    215          IDE_PROC_DEVSET(keepsettings, 0, 1),
>    216          IDE_PROC_DEVSET(nice1, 0, 1),
>    217          IDE_PROC_DEVSET(number, 0, 3),
                                          ^^^^
Argh...  This clamps it to 0-3 doesn't it.

Sorry, I didn't see that.

regards,
dan carpenter

