Return-Path: <SRS0=HNFi=DO=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28971C47095
	for <linux-ide@archiver.kernel.org>; Wed,  7 Oct 2020 16:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2CA216C4
	for <linux-ide@archiver.kernel.org>; Wed,  7 Oct 2020 16:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="A5eGA+Qg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgJGQDH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Oct 2020 12:03:07 -0400
Received: from mail-eopbgr80101.outbound.protection.outlook.com ([40.107.8.101]:59394
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728984AbgJGQDF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 7 Oct 2020 12:03:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOi0DG10IVKjh4YGmCKOF50dxQ/0TJjVCgBqLCE51iBXcaH42YYoRQXykEYZlZ6/TO7cK1miNsxWk0v9gtf9Ora4le4LKV+5IuUx+/c0bIEN/PaDET4JkeuMakq9hp5lR3rzin+dtCft15dwqgu9Ncw9jNIumVReDvTmM0FTIQyJaZHi/znP+pl0AmtmNSqzd6UsZrfz3d31vIpBAL5NfC83ZD+LQwjhGvSgBTL3DsYbSb6sSLSjUaHxREBzhECbwAdcHSFTCh3+R57gJYgGwxDxi4n1uRdDCtpqeXBihg8JOJMzhSe+LIZXKPQ6Yk34zN4Or+NydLU80QMC6cQ6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6kQpsKs2LExf4IY+Sn5wn2rN5eXiYd8aUOnC22Aas8=;
 b=jy4G5cWAOMdhVP/20QEovjTnBiko6j3Bw+277H3GD86v45yy0yxqv4zIm/tEPcJEh0jmKAYiLcoyJwfxnYtZeGoqsX2grUfR8eJhvurbXeqKkR2fvgzaf5ZQKobZXe0miI+q5bDRTu0PYJjYz4uLxRtJgRo3/JYxCDeIlVjRmw8KuNeQURfewLbej4N9Fn7WmDBMCDkSA3Q8uPNv90uNAsBDnls++uSxYJNQLgsPeLhIFIwXhst2wYeSwamO02fNYu8SdYfGbSG+OFqWyjdhVE4JCfJpqwWlNXlOVOjCdWj5h8rnkHQz1jkdKm28ZdQyQrzrp5I5Ig0LjBJanILK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6kQpsKs2LExf4IY+Sn5wn2rN5eXiYd8aUOnC22Aas8=;
 b=A5eGA+QggvrqE5YDgxgyGFqykE6czAe4crbP7d+y+zQVUloSW/uFyPGklPZbAOeQ/ewtKAAqwGx/e7KcQssiauge29xOeLCoUv1AITILTB2Dvis6XGD7fPCZaQrxkJLGm85dhIIhzaXfKlglWsu0vTf/KphgyUP5vVEq306816k=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM8PR05MB7268.eurprd05.prod.outlook.com (2603:10a6:20b:1dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Wed, 7 Oct
 2020 16:03:01 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 16:03:01 +0000
Date:   Wed, 7 Oct 2020 18:02:59 +0200
From:   Sven Auhagen <sven.auhagen@voleatech.de>
To:     Marc Zyngier <maz@kernel.org>
Cc:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, gregory.clement@bootlin.com,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH 1/7] ata: ahci: mvebu: Rename a platform data flag
Message-ID: <20201007160259.y3jblrt5b6b5ygqp@svensmacbookair.sven.lan>
References: <20201007154554.66650-1-sven.auhagen@voleatech.de>
 <20201007154554.66650-2-sven.auhagen@voleatech.de>
 <5f24cd5774b5e68681fc9c460cc44bec@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f24cd5774b5e68681fc9c460cc44bec@kernel.org>
X-Originating-IP: [109.193.235.168]
X-ClientProxiedBy: AM4PR0302CA0035.eurprd03.prod.outlook.com
 (2603:10a6:205:2::48) To AM8PR05MB7251.eurprd05.prod.outlook.com
 (2603:10a6:20b:1d4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from svensmacbookair.sven.lan (109.193.235.168) by AM4PR0302CA0035.eurprd03.prod.outlook.com (2603:10a6:205:2::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Wed, 7 Oct 2020 16:03:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ea9aba9-a9f7-4236-8488-08d86ada7784
X-MS-TrafficTypeDiagnostic: AM8PR05MB7268:
X-Microsoft-Antispam-PRVS: <AM8PR05MB7268D72CFF1BED3A6F9BE901EF0A0@AM8PR05MB7268.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7qWKIlXElGjkFa6b+QRmLTf0NYPYUBlE3RB/wcSaEfbL1Jb/YhBT+jxMR1ocr7/zb2AWn8S7mKTKph3UALxwNzGpH3vIxAtGgn87eKV/fylzYN+5BohrqHjJmShW2Q0Ay2iC+ZyN9Oeb8V5zAz3tLE2rQFpN9VuhOqJY3g5esvWaHfQifdj8HTJ7fYln4qE+eoMb3BZefvJISOZkc/17aDn9Zb/enCcrxu6jKf7CQ0pDgA028xeYhDjN5ibS4jSMJQBob4fgnSN1JFsJXCv1kq0BrTJ865EuHCA4T2yiTMfpLFCH9goYAALbIbzqZJ4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39840400004)(376002)(346002)(478600001)(956004)(4744005)(7416002)(55016002)(6916009)(44832011)(186003)(4326008)(16526019)(53546011)(2906002)(7696005)(6506007)(52116002)(66556008)(66946007)(66476007)(8676002)(9686003)(316002)(8936002)(5660300002)(86362001)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: lE49RkgnWLvRee+ZqQe307wMbwvHGEfCxN8KP86GDY+JhwjRdMmJDE4m6we7qEJ62jIXKMqcH711XisI9RrpAY8Znv1BK4yCCU0GE2ADwS2ChHJoOlVkgQB7wUDcC1uMfkADeXBZRQi0H2Z6DowuqWG/2OCuQhFJJZWYMt/tZAbn3uG+CxBEFC+ZKY07fh9/9FeMZRVnCHw3yYMs08F81x5SZSrb4gbg3yDT2NX7mI2wDrjgf10WlQ64p23H4vbj2t5t317p/qupq720X21aYRLE3Gf5z4ONDU2LAIqpBEmzL1EobTeE87Y8XHk3clv19ui+iDTE3E/cHJ20Y8OGUNz5vO8SdLVAViFv0Z7/ac1yaLno+OjO+abf+FphIfDE3tCJ7BfifRbwUjqrkWyfp3aiVuYdX0oGIbIsL/bJMFu0T2s6Yuxl6ahArPC0qHFZtqIWfWYRVupXybUzA1xn3c+GvcKnDHU88jVO44jddIwnplpKBhdRXkbAVXuTmmlV7JNeBgFMnslQcIXjKI5EsxqBWUQL4qMqEuleofLHBBaTnZJXzbbCkSKZxfuL17/dGau42CGKZ8pks447/mWEg9o86aLoUW1GQ+rkHaPLdhJHAh5CDHkkNQdDJL4Nsl+4MAlUVRFxMXrNnInlZscu3Q==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea9aba9-a9f7-4236-8488-08d86ada7784
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 16:03:01.5385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nXM6RJKBw9e2uyVtM7+kGWrDklc5YZKFZ9Mh9ywnABglkyjg1/93td5jwlOgoo2PYVQOewuQhc+7YZE1J3iVIBJxdziWdcCtU71ofc80Mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR05MB7268
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Oct 07, 2020 at 05:01:15PM +0100, Marc Zyngier wrote:
> On 2020-10-07 16:45, sven.auhagen@voleatech.de wrote:
> > From: Miquel Raynal <miquel.raynal@bootlin.com>
> > 
> > Before adding more entries in the platform data structure, rename the
> > flags entry to be more precise and name it host_flags.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> You are missing your own sign-off, as you are posting someone
> else's patch.

Ah, I did not know that it was necessary.
I used the patch without any changes.

I will add it for the next version, thanks.

Best
Sven

> 
>         M.
> -- 
> Jazz is not dead. It just smells funny...
