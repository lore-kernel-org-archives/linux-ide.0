Return-Path: <SRS0=DiMu=XF=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD50C4740A
	for <linux-ide@archiver.kernel.org>; Tue, 10 Sep 2019 14:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07ED21479
	for <linux-ide@archiver.kernel.org>; Tue, 10 Sep 2019 14:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cirsa.onmicrosoft.com header.i=@cirsa.onmicrosoft.com header.b="Cip3KQWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfIJODw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:03:52 -0400
Received: from mail-eopbgr40094.outbound.protection.outlook.com ([40.107.4.94]:23630
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725957AbfIJODw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 10 Sep 2019 10:03:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCmVLoGa335oljRFH7gsojL+lV8wH4uN+2tWhyLslaAXKfkX7+aH86FTYKZ444glmAg0BBFCS9qq3STvMq2odMSebXZ3hZAtwa6f1E5nq8EG/vtL5nZXCpfDAHOzXPNlPNLfZuUMgcLogju4QG4gaiGvv3hTk9Ov0MuLT5V5NEPTDnDFwjF61gAEy4FcqFzxT3fIWHv+j3UGoN4mTEr2azR+ET7gGdBpWons8vdL1NWyRO79ExkeVkSB3S6liVv/7tHBlkGualWRIb7io0OWa+g7LyLPUkjdOrl+BIIGoOqfG0JjKDGhwcHk9EmT8EhAQdvv1GTfphczDSr3j89tIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCr+ZXFwY5B9OubqTIvjkmbYhC39OLrT0WX0PB8JMEc=;
 b=g/RohhnPgsxJXcEoYFyWvJUf6DoWNu6mzNp7g1cfkIA9XGr2o6ku8zeYa8+dqltLnaWauke5UQ7cWeF8B8JfLNrX9JHEdI14YHBivPxK1HjFqK83XSsxLM45nTiuenpksXMjAISENqILfNy6DIMMVe98EsLXtglCIemIgV/r7WXyVRfdJpf2lZq6DgHuSFpHdeFD8FbHGmIQ13ySJF0S8z+Eahlz4PoL8lObCWrE93VnUCK7RzNIGBJzJgby+mxiHKkzRuUryHal0OssBxFWaJd/+S9MA+aKp7+czz2E7D0LOEpQwqO/KKm4pr0EXY8t7yZuDZDWx6gZFKu8GHYGtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirsa.com; dmarc=pass action=none header.from=cirsa.com;
 dkim=pass header.d=cirsa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirsa.onmicrosoft.com;
 s=selector2-cirsa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCr+ZXFwY5B9OubqTIvjkmbYhC39OLrT0WX0PB8JMEc=;
 b=Cip3KQWldEiWOVsBEtnAwnIJL5lgEzJ+cE5iJnMXNS/1rPlYG6Sbke13IVKZj3DtInqqrCLMFBkFCoRvCn7OJ3CDcQ6OBerE7Ye24iQQeyQEd3MmmqQe5SQaJEByLigu5MG3VczqZ8sY/p0jCNr+Z7+W3PAK9CzzrJokQn00YL8=
Received: from AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM (10.255.123.23) by
 AM6PR10MB2248.EURPRD10.PROD.OUTLOOK.COM (20.177.113.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Tue, 10 Sep 2019 14:03:47 +0000
Received: from AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6864:7679:ad13:ea98]) by AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6864:7679:ad13:ea98%6]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 14:03:47 +0000
From:   Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
To:     Bryan Gurney <bgurney@redhat.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: RE: SATA errors accessing hidden partitions
Thread-Topic: SATA errors accessing hidden partitions
Thread-Index: AQHVQFgnAUYD9EudoEOsRKFCztfl1acjLOlKgAGKj4CAABo2V4AAXz0AgAAMTu8=
Date:   Tue, 10 Sep 2019 14:03:47 +0000
Message-ID: <AM6PR10MB3399036D93B32666191730D1A1B60@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
References: <AM6PR10MB33991CE19828429C676C0296A1C40@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
 <AM6PR10MB339928C6DF7AF88789F904EFA1B70@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
 <20190910055333.GA32641@infradead.org>
 <AM6PR10MB339977CEF9AB4C3726AF3124A1B60@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>,<CAHhmqcSGK2W0Gz9CM=cKYH6PjtGnOwnWtadG7qOwYmQLjGwNAQ@mail.gmail.com>
In-Reply-To: <CAHhmqcSGK2W0Gz9CM=cKYH6PjtGnOwnWtadG7qOwYmQLjGwNAQ@mail.gmail.com>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jorgefm@cirsa.com; 
x-originating-ip: [185.180.48.14]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3399b274-8855-4336-f7e6-08d735f7b2f9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR10MB2248;
x-ms-traffictypediagnostic: AM6PR10MB2248:
x-microsoft-antispam-prvs: <AM6PR10MB2248B70CF27265AD88DCA534A1B60@AM6PR10MB2248.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(396003)(346002)(366004)(199004)(189003)(486006)(478600001)(25786009)(74316002)(26005)(66066001)(446003)(55016002)(11346002)(53936002)(476003)(66446008)(71200400001)(81166006)(2906002)(9686003)(186003)(52536014)(66556008)(54906003)(316002)(66476007)(66946007)(86362001)(91956017)(76116006)(256004)(14444005)(33656002)(7696005)(229853002)(81156014)(6916009)(71190400001)(4326008)(5660300002)(8936002)(64756008)(6506007)(6246003)(8676002)(99286004)(7736002)(6116002)(76176011)(14454004)(6436002)(3846002)(305945005)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR10MB2248;H:AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cirsa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P6MS1W+5RCl1wKW5Z1ArUQuSIZZTXmxoFkkzef/fHYmePl2p9SUGqMm3P2iLvqkIzy4lELFilLUkwgJrk55gGfeuGyEm0nO17j9BfOIQzOwSNk5G/u6kH4i0ZF3wMK53K9360emLlviW+Ruqu0sdyyTzz0XyvplX63URX+J2ekSc3LVOw/qYmLGZYottW+Vf+s3szaNtCRk9A6lPfgvWmX07EGtPjeV5dKnicBe9aZxIXDEXLeMpH06xN0dmUKUZ6oXvBrbGF4bWROXiiNP/ToJRwnIfyywi4EB5F0NobnX4HjpctYWv8FJK2Uhhqfr4kucoC2yaNvY/mGnfVjuYO/U56hbbRpN7u/2UjVyBiw5EivkBL5g37uFTvHXBcnxvD+rbGK9EOVBLS3tTWCATAr9AuaEq4VOZdbVAIer0YRE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cirsa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3399b274-8855-4336-f7e6-08d735f7b2f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 14:03:47.1315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6d255d9-7bfe-42f2-a01e-09634cc3a03b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lzbUb2sQJQ5miT2HbZSLZivIHOjLspKXMKXp4/2fGFcLKuwzfi52HVKb7ASuGhlL/nKJpFemjD3q87a/i2LxHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2248
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Bryan! Thanks for your detailed answer!=0A=
=0A=
>Notice that logical block 524272 on devices sda3, sda4, and sda5 are=0A=
>cited.=A0 This is a blind guess, but are these partitions 524288 sectors=
=0A=
>(256 MB) in size?=0A=
=0A=
No, they're 4GB partitions.=0A=
=0A=
=0A=
>You can notice that the first few reads are near the "end" of the=0A=
>partition.=A0 In fact, the first two read completions are 128 sectors=0A=
>before the end, and 16 sectors before the end.=A0 I'm guessing that this=
=0A=
>"-16" read is the one that's failing in these three partitions.=0A=
=0A=
Then, there is an inconsistency in the blkid and kernel communication? Why =
the kernel=0A=
tries to access to a locked range? It seems that blkid ask for a sector and=
 the kernel try=0A=
to read it back ignoring its locked, reducing speed and trying again with n=
o luck until=0A=
the error is returned. This is consistent with our workaround removing blki=
d from the=0A=
udev rule to avoid the error.=0A=
=0A=
Maybe the OPAL is not clear enough about locked ranges and kernel thinks is=
 an error,=0A=
or it's an error in the disk's firmware I don't know, but under windows or =
MacOS X no=0A=
error is displayed.=0A=
=0A=
Is there some way to ask a disk for their locked ranges and patch blkid to =
avoid accesing them?=0A=
=0A=
Thanks,=0A=
Jorge=0A=
=0A=
