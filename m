Return-Path: <SRS0=DiMu=XF=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A28C3A5A2
	for <linux-ide@archiver.kernel.org>; Tue, 10 Sep 2019 08:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2A82084D
	for <linux-ide@archiver.kernel.org>; Tue, 10 Sep 2019 08:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cirsa.onmicrosoft.com header.i=@cirsa.onmicrosoft.com header.b="R4IdHkfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfIJIDN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 10 Sep 2019 04:03:13 -0400
Received: from mail-eopbgr70110.outbound.protection.outlook.com ([40.107.7.110]:38686
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbfIJIDN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 10 Sep 2019 04:03:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7d8e6v3Bf404GMdMWm1jd4FR+YTZIkwI6vNvQwy6GLnx9kIQ8mmx+I3mBrMCE9opA/m32Y3pp35ivE1IVzknLmG6rdn6Cm3tOdJD3sg/TGei53v1XJlMiALlEpXLN4X6Nm+LMOSD0zyrZbLiX9z0bDW8C3o10kdkUXglaCN9+RmkYasQp0YJAOzcLFsSpXCnCrG6MgDz7XZKPgjsJmJdN/xkzCQNCdWvwwI25Oj3VjtY/IuuYY1uAe4orUzHR9hmJSZBgiGuTfYorFnUdRJVT7w64PSl2uZeMcdp+KDVp5PDrg+mnDkUYXZKpf724N29qcfU0TbtsqdrmpkOFgyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1RX+NpwbiPNOftVEs7HDQWbJqXjEa0gonATb+8g+hY=;
 b=dAjDZ9XaPgh41A7AMYKV7nNs5Yv3Q0ulidOkA9lLSTgpiVF+SlffZ55Sjs+fjDYDAud5kTbm7e7wtf2sXm3oyJMyA/HC9NTTLRN+453opUSzpJeHT4ZWesLlsUjr1YbNfHueACKN2cAI8Y9Rf6Q/CeaXQ3eVC9Zp+25d9AeohWZEdDNphP2f61XJnuZuOC+p4TcqxXp4WMjkVAflEz3URWKWiruEZtlvN9SPn8S5uEN067FBSkqSBsHBv9hXknshi90eZ9G16eNOiAzsElIsfxWpH3Rkx+L/0FG8z3/3I9Bjmq1M6K4PR7/Ip7lmmUpPTu/dnxKyNInbeg2QJOyKEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirsa.com; dmarc=pass action=none header.from=cirsa.com;
 dkim=pass header.d=cirsa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirsa.onmicrosoft.com;
 s=selector2-cirsa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1RX+NpwbiPNOftVEs7HDQWbJqXjEa0gonATb+8g+hY=;
 b=R4IdHkfjJMjZfEL2vFUY0gYzjlLyQsKD9QxAJ5MHftHZLLCiIvDtTT6COEeDrDMQgypkZ44Q5ydIXm/NIOWXbiRoBGK4wWY5CefuzddzBBhKuH/T/wmAtXiBplcnWp8hliIJJj1PKXTtdcTSVqEVy2PpT21KPW9/wkicr99V6RU=
Received: from AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM (10.255.123.23) by
 AM6PR10MB2039.EURPRD10.PROD.OUTLOOK.COM (52.134.120.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Tue, 10 Sep 2019 08:03:10 +0000
Received: from AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6864:7679:ad13:ea98]) by AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6864:7679:ad13:ea98%6]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 08:03:10 +0000
From:   Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "tj@kernel.org" <tj@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: RE: SATA errors accessing hidden partitions
Thread-Topic: SATA errors accessing hidden partitions
Thread-Index: AQHVQFgnAUYD9EudoEOsRKFCztfl1acjLOlKgAGKj4CAABo2Vw==
Date:   Tue, 10 Sep 2019 08:03:10 +0000
Message-ID: <AM6PR10MB339977CEF9AB4C3726AF3124A1B60@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
References: <AM6PR10MB33991CE19828429C676C0296A1C40@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
 <AM6PR10MB339928C6DF7AF88789F904EFA1B70@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>,<20190910055333.GA32641@infradead.org>
In-Reply-To: <20190910055333.GA32641@infradead.org>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jorgefm@cirsa.com; 
x-originating-ip: [185.180.48.14]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3229a6c7-4baa-49e1-a58e-08d735c55259
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR10MB2039;
x-ms-traffictypediagnostic: AM6PR10MB2039:
x-microsoft-antispam-prvs: <AM6PR10MB203905D6B039D45648C9C125A1B60@AM6PR10MB2039.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(346002)(39860400002)(366004)(53754006)(189003)(199004)(66556008)(66476007)(53936002)(186003)(4744005)(486006)(8676002)(14454004)(66946007)(66066001)(3846002)(6916009)(8936002)(6116002)(99286004)(86362001)(4326008)(478600001)(316002)(2906002)(81166006)(256004)(5660300002)(14444005)(102836004)(25786009)(6506007)(81156014)(26005)(54906003)(71190400001)(71200400001)(446003)(9686003)(11346002)(7736002)(76176011)(7696005)(64756008)(66446008)(305945005)(52536014)(476003)(6436002)(6246003)(74316002)(229853002)(33656002)(55016002)(76116006)(91956017);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR10MB2039;H:AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cirsa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L7yV4nt/djMLt8jmOS3vxIJH3O61E7HkymJ+VwhgenENke27AS3v0y+inzdWgX17QDrno3iIZCdnqcwrGkd/s9i1/yspSgmO2edv7kyP+RFj8HaBRARwEzcytp+j+1dpd8UTCDW2e/z7vEE2I7OsNEtRInCncAUeAPwzeLD4IKqK2tmAQ5qwqORaiaefqHr9eEpPyIWYbiK9oVjB9qrGczNN3veSuaImLkV+IzPFM7jFnZHpoTJ0/inZ5t4FnUiYAnIcZ7tqOLI9LxOw7oBvGOhPtM7xy/ANY86cf8IehUComid30ik/9NdyUcdSduOio+UF6t8eIqFCE1FE/g81eM08RDr5xId+eEftJB0fF6nssdvz3IVflGI5CeLbS23NwHe+iZMEwp1MV4k0/BKZZrJzjqYxsmqo75h9NLlpwnE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cirsa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3229a6c7-4baa-49e1-a58e-08d735c55259
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 08:03:10.0871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6d255d9-7bfe-42f2-a01e-09634cc3a03b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tcKOORVlQyWoEbieqndWtx2QJFUbrv27hLhkNDXqH2lkuWuOURxie8tNMCaqBP6VPqQAfxmJEbAhcuJ3Qf/rBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2039
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

>> Hi all,=0A=
>> =0A=
>> I have a SSD disk from transcend with 6 partitions, where partitions 3, =
4 and 5 are locked. This disk implements the OPAL specifications and transc=
end supplies some tools to hide/unhide a partition.=0A=
>=0A=
>OPAL does not have a concept to hide a partition, it supports locking=0A=
>ranges.=A0 In doubt you want to use the kernel opal support to unlock all=
=0A=
>ranges and should be fine, otherwise there isn't too much we can do.=0A=
=0A=
You're right. We are  using locking ranges and these partitions are mapped =
onto these ranges.=0A=
We're try too with a locked range without any partition inside an the syste=
m tries to access the=0A=
locked range. We're wondering why kernel? blkid? is trying to get info from=
 a locked range??=0A=
The outcome is a SATA link in 1.5Gbps after a long time boot. In windows or=
 MacOSx works in=0A=
other way.=0A=
=0A=
Thanks!=0A=
Jorge=
