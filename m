Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2973DC43334
	for <linux-ide@archiver.kernel.org>; Wed, 15 Jun 2022 21:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349872AbiFOV7l (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 15 Jun 2022 17:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347212AbiFOV7k (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jun 2022 17:59:40 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04hn0206.outbound.protection.outlook.com [52.100.18.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7038853C76
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2022 14:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsRt53ZYax+AEOeti3vtug0ncUfsI4BtDTmATK4j9TWGo7tRGqgcX5Za1IyPnpEnBtzFI+geVdnBNk3qMbBTVB2lOhOWIsJHCQz95RrvtKvNM+7TRSQcrzhORJluIZxFfP1HaXDfc0DeTg0J3LVDdOjTjlAxdHQvNJiJtl3n9DsN89JocsaSx3P3gmb01BTwWt/3fr9RWTdzEpGlvU967iOOPOX3RojaUqH2lUBPmC5Y4FaDoZttgyF+Nhs7G47OI+WBU4ey/Vuix1KlQyguh9obRMkMQIBlPuInZHx52tJ/VoKKlAHtPrheUFJnJ6uJE/XH4YNXvNIIMpFQObo39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQsm62DnO3DRMaTO7/AWxijWtNxIrL/VW/Qe6xhipJU=;
 b=IGQsFS6EetL6gudVSJfMgpjpmfd5+XQYqAKwQ8MAdyuIZrZ1Cv3DTTbsfge2vjrFU5F+pt4EPEgUj+ucHPj/Sm5ppaluIJalpsGyjZdCtqHaHBcXDwB3OvgRP0RC+OvpMaYUCvl3f0EIbuEa8gIjFYVqfpx3Ay3chIkGal4seqaJhI1RZOyrzAA06OMuEulgHI3yvqB1MKaKX+ii+SDrinsAmdKHprS9M1k3lGoY792BeAWrBH0hcuvhDbX7HZuc0RmS7g1bGefiYItiMznXZEReHrnLUDTsA8qQnnc6SRJoOWb/7rR30f1yDKj8l9UqdH8APxAq4/TWdSH3XzBAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=permerror (sender ip
 is 91.151.71.70) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=solairedirect.co.za; dmarc=none action=none
 header.from=solairedirect.co.za; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solairdirect.onmicrosoft.com; s=selector1-solairdirect-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQsm62DnO3DRMaTO7/AWxijWtNxIrL/VW/Qe6xhipJU=;
 b=HsgLrIBf5Y5/jugPwHtZ3YjFXOYz7zxWLBzU7zsXG9VlhkejcSNBlSPznZSZxqd3Py8TKG9TenjZ2h+1d7f4mI0HoWLgtwFkC2aoms2KYL1wG5rVh26vO3xNMegw706L3WVxdfK/TrxVDy0NLMK2PAtGRoRDRFSm6enD8XsQIWo=
Received: from DB6PR0601CA0011.eurprd06.prod.outlook.com (2603:10a6:4:7b::21)
 by AM5PR0602MB2771.eurprd06.prod.outlook.com (2603:10a6:203:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Wed, 15 Jun
 2022 21:59:36 +0000
Received: from DB5EUR01FT086.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:7b:cafe::9d) by DB6PR0601CA0011.outlook.office365.com
 (2603:10a6:4:7b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Wed, 15 Jun 2022 21:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=permerror (sender IP is
 91.151.71.70) smtp.mailfrom=solairedirect.co.za; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=solairedirect.co.za;
Received-SPF: PermError (protection.outlook.com: domain of solairedirect.co.za
 used an invalid SPF mechanism)
Received: from SDSV152-VM.solairedirect.lan (91.151.71.70) by
 DB5EUR01FT086.mail.protection.outlook.com (10.152.5.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5353.14 via Frontend Transport; Wed, 15 Jun 2022 21:59:35 +0000
Received: from [206.72.197.122] ([206.72.197.122] unverified) by SDSV152-VM.solairedirect.lan with Microsoft SMTPSVC(8.5.9600.16384);
         Thu, 16 Jun 2022 00:00:12 +0200
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hi
To:     linux-ide@vger.kernel.org
From:   "Emerald Johansson" <marketing@solairedirect.co.za>
Date:   Wed, 15 Jun 2022 17:59:34 -0400
Reply-To: emjo680@gmail.com
Message-ID: <SDSV152-VM5d0g4ucaj00047013@SDSV152-VM.solairedirect.lan>
X-OriginalArrivalTime: 15 Jun 2022 22:00:12.0354 (UTC) FILETIME=[49630220:01D88103]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba2cf0f4-652a-4476-258b-08da4f1a5622
X-MS-TrafficTypeDiagnostic: AM5PR0602MB2771:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0602MB2771B0D09E4C31696F2A48FAEBAD9@AM5PR0602MB2771.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?rxaNO7BR1VOHvkWuHnyHHXX/pdC8iGmyieEALgT1JrUayU3TXBbg8i0445?=
 =?iso-8859-1?Q?VfIZGzkrrMUxC8O5uUvTqSYRoUgDKPAus324pJBGPbRlneb16Ts5VCei7S?=
 =?iso-8859-1?Q?Ej56l0raUjbgkIRo00b4kxfhr/8mTbDFuAHfgziX2uBF8FU5NKOAFvwzU8?=
 =?iso-8859-1?Q?BiRjNMfz5aYK+XWdC/1klhCkyZgrWz/7y6xKpL0zuX+0FHrS65NfFL07IT?=
 =?iso-8859-1?Q?Dhga0+i6xh21QMmh+wDlo85KRnUbzwoGp75xA6b2ZoqVFPpL1liFM5dBSr?=
 =?iso-8859-1?Q?Y7lLcaYhj3QYv2Bd4S/lzNAOnSK1ETfVLrINmJRFiSVstPP3UrKgprOiOz?=
 =?iso-8859-1?Q?zTmbAETO9GEG6y9+5bzxsaz6zyWNv3TBy//7uOHxSX+8331lNUzA4sDwVv?=
 =?iso-8859-1?Q?hD1xSb/tBN82ZYkxd228VgiLkVQtPEBMD54KTf1zg1NNEm07TnwGfbRp51?=
 =?iso-8859-1?Q?smUWc3QpKSGUhtlaUweiTwG9npz61nBvl9YzhJG5wr2fKaxectvcoM8P5G?=
 =?iso-8859-1?Q?WouiLNzNX80fC7VBHChQOqGqx+Ao0mE7VpdVWFLiu/A1WeQpsuTd0p8sZ3?=
 =?iso-8859-1?Q?g0JW2+9rdTb6BGsO/ZqPzu0SmftgHnkebkYg01phyRSDbp+WBEt9bs45YV?=
 =?iso-8859-1?Q?6pqva0uPbNiXGfvp+6wCsbZfxE1rrYhT++rlIDadePqA+3YHeAm+h/Zl+W?=
 =?iso-8859-1?Q?zugIsr8bu6iqTHULBPwfCBJE0EkL7UxIOW4De40B5VVj7IzvXH+nT0e9Q1?=
 =?iso-8859-1?Q?IXiS2yVpTkh7n36h+yYPhAagXGmQESMt1e6PzrkSNwcLTrD1kx+ZzRBqi5?=
 =?iso-8859-1?Q?ztZRl4GCGYVkuE1mlSfuLa2VWCHmr+ympGYDrcblkZct0EZo31rg4fl95h?=
 =?iso-8859-1?Q?sR+zi8J5YsU1n+VcDmo6sYK+V2kfBSjnXkJvcGhIWc7q0rwqCqyA8hAau0?=
 =?iso-8859-1?Q?e8xoIzl3voW0WklscKJ/LwhcMJysDbNmRsEQMn8uTQGpXi405S5sJT5xRw?=
 =?iso-8859-1?Q?RGHB5n4Eiw8PQfunbFXvqeUEsOXWwQFh9kYYz9urFpc0nizrWHCZTEiiu3?=
 =?iso-8859-1?Q?eryEClSxIJLHd5+DvF4pyLY=3D?=
X-Forefront-Antispam-Report: CIP:91.151.71.70;CTRY:FR;LANG:en;SCL:5;SRV:;IPV:CAL;SFV:SPM;H:SDSV152-VM.solairedirect.lan;PTR:undef-71-70.c-si.fr;CAT:OSPM;SFS:(13230016)(346002)(39860400002)(396003)(136003)(40470700004)(36840700001)(46966006)(186003)(7116003)(3480700007)(2860700004)(8936002)(82310400005)(4744005)(5660300002)(36860700001)(41300700001)(336012)(956004)(316002)(40480700001)(508600001)(6666004)(40460700003)(81166007)(86362001)(2906002)(356005)(26005)(9686003)(47076005)(70206006)(6916009)(70586007)(8676002)(16900700008);DIR:OUT;SFP:1501;
X-OriginatorOrg: solairedirect.co.za
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 21:59:35.8075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2cf0f4-652a-4476-258b-08da4f1a5622
X-MS-Exchange-CrossTenant-Id: 1c138fa9-0b91-4473-baea-5be5feac0f7e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1c138fa9-0b91-4473-baea-5be5feac0f7e;Ip=[91.151.71.70];Helo=[SDSV152-VM.solairedirect.lan]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT086.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0602MB2771
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

I hope that you are at your best and doing well. The purpose of this letter=
 is seeking for a pen pal like friendship and I'd love to and be honored to=
 be friends with you if you do not mind.. If the Idea sounds OK with you, j=
ust say yes and we can take it on from there. I look forward to hear hearin=
g from you.. My name is Emerald From Sweden 36 years , this will mean a lot=
 to me to hear back from you.

Warm Regards.

Emerald
