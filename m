Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB742CDB47E
	for <linux-ide@archiver.kernel.org>; Fri, 13 Oct 2023 08:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjJMIvn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 13 Oct 2023 04:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjJMIvm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 13 Oct 2023 04:51:42 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9173DBF
        for <linux-ide@vger.kernel.org>; Fri, 13 Oct 2023 01:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697187100; x=1728723100;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=016ADJSmYXb0/K8aUiZxq73KvFWR7gjLXANBCjf7rSQ=;
  b=JWMVYHmxjoS0e2H/4bQeiO91y7GAvnkPeWj2mu1HSVNUBJtVLG/w6OBH
   7C3QhhYQpK4Cx0SonvOzBI7RRmYMYC6Fz0h3cpuk2IVOfgeyT/yOgeMIZ
   xvYlM+ahP9u1DotvN5JyxlJEPRaxP+DxsGxlXdUyennY8FM9uICXP2h4b
   Uets2fsEqqfrBILjbfa7NxHbBSjsfh5eRFqDhmPaChdFrsnvcF8YinsL2
   q4RO4XV2wzPG0QUujQPWooq/Nqh7/1gz0hPasLR6DPgcoJhzK2OhwS5Fh
   K3ciY+mqU1GmDMmyptGt++Wrkd8cpH/t/WVTuLJ529vdQq1ZUNMgNE7ii
   Q==;
X-CSE-ConnectionGUID: KLpcBv6pRdW0T1F9G6SxSQ==
X-CSE-MsgGUID: kucDlDn7RqWeD72p9g9HZQ==
X-IronPort-AV: E=Sophos;i="6.03,221,1694707200"; 
   d="scan'208";a="246469529"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2023 16:51:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5mw4TAeBBezXF1cXRFb/pRg4vDqjTabI6WQhzP0XZGi49DwxjC34mgvuCejS6DX7xwgiGgIEJKioV3ADHHRHkARXazDYgcL07+epZbAXUDkTF1Exxe2QwMNCuLpi11qipkIXyjkNQGMylAmEG9iL3ufEPpgwdt3xIHI67obKzmWsmOSbh7smvMNMiozzqjnqSlQfreMhIbenRGUKiXb242vdsw5JtuAWrUJU824OYBC83jXvYCE1EMLHyOoyaulDCGBusXbD3n0a7QxJ3qCN/6YqLKO5/f19NnNWVpdG/ZQgZREQ8lMHBNbWmMSjDfJyJTKmhgAgTvf+LVmeEP6nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtPhEWFRD3gjvtkoKSY2aTQG71kX0JtSoQUb9IamIxA=;
 b=cxUFaoPDmZKA+H3tBWFQDBFfbeNbQLlBQ7fqh+XdlDViRZ2VfGb8VQuIbIkNarodRFm2ikAnaP+kRXfB1G1kCYJHzZl5X+/XrJH1G3p0eFNAmgE3T0bkesQLmEWQlKcxHzmlfKVkjnhX/0FLQFKp/LuAm/h9EoNI+wvxQGJOV7QOqgUZlK6qxwvfk3yL5ii+UNoUnxBC4JEFHxCPnBWniW8jNXnEbRL/EnYM1FJwU+56HTL+Vul/F0cFc+VBjr2cvo3zF2ZDKKoZuE27dEOCBQMCNdVzZya87nKGQpDAiJv5jZeDbS4P+WasaJMPHj3YXctm+XwYBdP3i8FexvWRdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtPhEWFRD3gjvtkoKSY2aTQG71kX0JtSoQUb9IamIxA=;
 b=eO3JGvpctYu/3OjOINChTb7EJSbVZplCME4Q6wSvJ6ldgceH/qnQ9uvJyGfsCNrgpO4hLQnWg2pMJMMxK+tXxXjlH4FS4JkJJ1DG5Rl4DYHKqS8OxNa+YKDEzxWufgoRBfRcTcZYyNU2zhaHj1FUHudiG+vt4cKxQ0z9ziY5vJ8=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CH2PR04MB6645.namprd04.prod.outlook.com (2603:10b6:610:92::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 08:51:36 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6886.028; Fri, 13 Oct 2023
 08:51:36 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Phillip Susi <phill@thesusis.net>
Subject: Re: [PATCH 2/2] ata: libata-core: Improve ata_dev_power_set_active()
Thread-Topic: [PATCH 2/2] ata: libata-core: Improve ata_dev_power_set_active()
Thread-Index: AQHZ/bJ4MqyVrEl6cE6PkRoc44TCeQ==
Date:   Fri, 13 Oct 2023 08:51:36 +0000
Message-ID: <ZSkFGMSPuxNpH/1Z@x1-carbon>
References: <20231012071800.468868-1-dlemoal@kernel.org>
 <20231012071800.468868-3-dlemoal@kernel.org>
In-Reply-To: <20231012071800.468868-3-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CH2PR04MB6645:EE_
x-ms-office365-filtering-correlation-id: dd9661f3-a324-43e6-2c92-08dbcbc99bea
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qh7wkPY7LJ6xWJTbRTbs7O5B0VFzlKaE5LEDmuuXccPWAcVh2Ckx8QqcYPYcY665qx0RFThjon4Lk8oQlp5JVXEQW7BHFlUhVdf3pdbFfuXgyOBJGFV/cae8kUGM0XkZ9gIOP74WkSG+VDLBH0WtDeNcxZXi0KEFwW//7XLQYM4sM8G6hxBv+DCYPRLLcXHMnH1XAUpmPXYBsxHx02+VsYuDyW8dQxP97Y+CyyQ1RTaW3nEINAeTXsYb/3mxjNOuDAbRaANqihpVWGn6TDoplDEblFb+Q9+3TV9N28KOFojMVWa7zmOhOBQBO189AFlHu44RDBH8IaE2hKVROkKtmruTKHHm73C5oZfMb3nsaQ7UZTcj0ikNrkncRm9zcSslEK8LTIBW/Omy/5qwI4bgLsvMN9TQJo3auJpv/tqt7hy8wPeW5FcGfOyU9XNJircDAgOEOQRX5UFKQFW4OZ/a7nmZ17j6ZnVovNfTIslrK1iaD6q6VXlfYZz8/I+nK8IQP257QFtvY8nnNXZu4fJNsZWSFSi1RDKMp9cJarduL5bahNwyzkR4kDtpHuYGbdU07hrOQAZJIqpdOFN3bBFstVyzQHAFesFcrMD63bODZcg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(366004)(39860400002)(346002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82960400001)(26005)(83380400001)(122000001)(64756008)(66446008)(6512007)(54906003)(66476007)(9686003)(66946007)(38100700002)(76116006)(91956017)(38070700005)(6506007)(66556008)(71200400001)(6486002)(966005)(478600001)(41300700001)(6916009)(316002)(4326008)(8676002)(8936002)(2906002)(33716001)(86362001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?syObKd9NxXiW3TYtIGPbM2jYUtHhrZVzL5lqh8c3LDZHxV1UEGOy6Z9GAhO/?=
 =?us-ascii?Q?Tzp0LXAsIo7SYgOZNNyoZD83N3xmMgWQQwSlGIlgx698xohFeTyvNkZXLklt?=
 =?us-ascii?Q?dpMwsoZw6m83xmbRKj4DeQiIWV7dopxdxbLNqmgwrEuOrfV5D1KQQ0StfCU0?=
 =?us-ascii?Q?j90AD6Vo4w3ux3NV4FsYKLgkQ53XVJdwARw25ou/kD5U4xqmQRUSK67qYw64?=
 =?us-ascii?Q?N1ELFC+70PL+cNdJ40obdLL1Kh4f7bMltmhe//x0SRA7cOMbFu6cqcXMpIhJ?=
 =?us-ascii?Q?8lTGyXakfc145CuGxEk8lEINiDN4JltKKARkKCLlG97FKFHGn1hoU4RAYUBN?=
 =?us-ascii?Q?BJyPMzPlZicqyUmbigcoAz2arJGkmLyyepegHT61UQwDWrkFiGshFWVkq7+r?=
 =?us-ascii?Q?Y4AiWZK/cXIu32TXzBjy24Zj0G9mb68MZDXpPGCzEwjcyaZ2JRJOj3JPJxPJ?=
 =?us-ascii?Q?I0+WHTWl34F2dACp8jm92g0gxivOAtYZrkyQ7JQFx1kG6En7KHcdceYipavk?=
 =?us-ascii?Q?Fbi9l6ZA+gyaNtrQ1t8jC8iUvLO1/UstLbLSxqyXwIyY8tnE0UFeLYZ36qHY?=
 =?us-ascii?Q?qZyYZL/xoiuiuZTHPtpmn+J+cKpAsprMASF5C+4gI45Vgrs4LA9vzaDlf+1J?=
 =?us-ascii?Q?FRZObLm4ouAgxIvOtCpuW+2fQdjWY9gKNqpGrmLoTm8GoevemSfKEbPNc4xY?=
 =?us-ascii?Q?JYf/smpMjgsCc+BGsiXEzDDRmmyHygrW7IKhoC1cLmNI8f40ajtqPefYsfqr?=
 =?us-ascii?Q?PCYodpEqGxv6xUvZR3a1VR6fntDvvXG1xBfviVgLytK08LxHCoKzux3aZBLo?=
 =?us-ascii?Q?npjy6v9PZTWvSB0BcN8owGWkmVsB4UHpZShMPHT3CLOcthRCMP2MTDrNXIMH?=
 =?us-ascii?Q?xaZQvKdpZ3aT6+/kgV7MXm1peWTK7J1Rv8q9Sih3uAIYbE7KuHWVfEZUviju?=
 =?us-ascii?Q?UMYRr1X/JhZuHsbzoVvcHbhJiRWVE7GnjplOVNB7JQ1wxL1Odml6CUpV+kB5?=
 =?us-ascii?Q?aQfAHLKsHmSmnWkkwErIp/LgYgBDZTJzxoiG2sWsWd+KYFobTD7su91ae3i4?=
 =?us-ascii?Q?OP3qBakwmKnPz8jKLEoqzb6QV4zFWcJCc8pxukWKBV7K/T04wBwhXZYEL5TZ?=
 =?us-ascii?Q?JqLdtmG5CrOpjLryS3Ev4Tnc8HYs+ZRtRB8KolD2OPqFA9Yb8RzQxufNcBgR?=
 =?us-ascii?Q?NFTCOfLppjptJCMBHKMrmemSrrTO2RuwyOEClKsbEpto68RQcC46XSdv46W0?=
 =?us-ascii?Q?fePCc6Wlk3mr+Dxk2J3epij/mIZ96/jWW3g+XGskCIGHXMIJTcFBLmp+vGuE?=
 =?us-ascii?Q?hMVqZS3JyRlvxRjaexCF29GPKrEkGjfueAZODe/s1lZG44UDle8zkLWa5EVW?=
 =?us-ascii?Q?kC/v5xiVp/BaPTzvrfsf0lbsYFsyzbw+asUMhFG3t9YXwotBmugByOJ6Ss2G?=
 =?us-ascii?Q?8F8OlhkJNMhW6y7qR4DFw+LZA5eXuC5m2VgkgMpjAbLoOG3HJUh1wZ598Ndz?=
 =?us-ascii?Q?EPYI/30/CFksW8OvXuBTxzf/2yiaznn1IyZN+tCToO1MRMMg7271yY97WB7q?=
 =?us-ascii?Q?kLr5JCL0AMty6TWfNWAWCdqJEPKu1jcwwIY16LeZ+8HK/OupEXSINYl8FF5f?=
 =?us-ascii?Q?dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <83FC518D5BA4D0498E3363B8C6755458@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lJ7sgWPrKvlxe37E7585n7GGb+l/XsHhVvcZVU8CfJRsruM1d0cE7qXqEOWi5/1uJfp3AaVUhiDHrVrMVk5a2Gs0CePNMBjaUizLd9SDQnHQv+iEsPOZM+ZK9DkeDTFY5137gD0SP0CzyM+wLXNZUyYcPQQhve6DeLAYExQ5lnXzfRYxo6zkEd6plhNh6grdIHXKmWOHLtpK1yzW+UJ8UKlernfz4QnK5gu6OAZ1yAgSMmlFc0hxThJ2h140LVgJnZaEW6MZSVmwuELB8btPCOuo3JuJaux79Y2ejQBXXIxSvdEbXfuhxG93w6mrpKNeGR071YWrv5jg7rUKWVUqBrsV64NTZaM7NIt7SXLYsRG1LOnoyIAMYHOd90zRgp3iWdn78dU+PvGr27ROBcO8v2gAv0xBZ2A1IECEvpJV3N8WgxfiIpZrDRsrtQBmWER4X2y8I6AgtIBmEDUG3yrhUfrSDaxoV54I/CRbpsZEkuMhjEo/BFMU+DMFp5AogeQ/BX1bJYiZo23kC7GTBBYz6Khh80hPIrMquULm7MjUJYIz4dWYcApMmjCS073P3n90mHzvfUSopnFxi2s7AMirNG/kWnu/0+F5AB4fB2+zqyY5dzPr3fODQlzwN9YEvc47a1K01JNVxTUYjnlNr9UdRdZnXnvCVLY6PThLCi8yXwZS68SOktKi01aTIEweVTSFJ95QBTJSPSBhri5u6/1Ej28FcU2wg9kUkosikJCuk+/SKH5KeKCk3AjI7e0SGt3nR6ylmsyGDyFqjxWrUaKuuyoIU7lFlV51WYy8LBy81ciL/aWt3pNSy8cF577v5Ik2y8zpM7Rnr8EyV+zlKiRGSchROAO74kqMKg3B4JIvN9ALpH4RhS1GedvN3QwA1TCi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9661f3-a324-43e6-2c92-08dbcbc99bea
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 08:51:36.7182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+C+fByIVceJg0gUZ1B6C4V8NTzLWh9UPnH7xVstvKd2XNaMEJZvYAuMyMg3JQsk2StEIEAHJpfmGoqokGuOzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6645
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Oct 12, 2023 at 04:18:00PM +0900, Damien Le Moal wrote:
> Improve the function ata_dev_power_set_active() by having it do nothing
> for a disk that is already in the active power state. To do that,
> introduce the function ata_dev_power_is_active() to test the current
> power state of the disk and return true if the disk is in the PM0:
> active or PM1: idle state (0xff value for the count field of the CHECK
> POWER MODE command output).
>=20
> To preserve the existing behavior, if the CHECK POWER MODE command
> issued in ata_dev_power_is_active() fails, the drive is assumed to be in
> standby mode and false is returned.
>=20
> With this change, issuing the VERIFY command to access the disk media to
> spin it up becomes unnecessary most of the time during system resume as
> the port reset done by libata-eh on resume often result in the drive to
> spin-up (this behavior is not clearly defined by the ACS specifications
> and may thus vary between disk models).
>=20
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-core.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>=20
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 83613280928b..6fb4e8dc8c3c 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2042,6 +2042,33 @@ void ata_dev_power_set_standby(struct ata_device *=
dev)
>  			    err_mask);
>  }
> =20
> +static bool ata_dev_power_is_active(struct ata_device *dev)
> +{
> +	struct ata_taskfile tf;
> +	unsigned int err_mask;
> +
> +	ata_tf_init(dev, &tf);
> +	tf.flags |=3D ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
> +	tf.protocol =3D ATA_PROT_NODATA;
> +	tf.command =3D ATA_CMD_CHK_POWER;
> +
> +	err_mask =3D ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
> +	if (err_mask) {
> +		ata_dev_err(dev, "Check power mode failed (err_mask=3D0x%x)\n",
> +			    err_mask);
> +		/*
> +		 * Assume we are in standby mode so that we always force a
> +		 * spinup in ata_dev_power_set_active().
> +		 */
> +		return false;
> +	}
> +
> +	ata_dev_dbg(dev, "Power mode: 0x%02x\n", tf.nsect);
> +
> +	/* Active or idle */
> +	return tf.nsect =3D=3D 0xff;
> +}
> +
>  /**
>   *	ata_dev_power_set_active -  Set a device power mode to active
>   *	@dev: target device
> @@ -2065,6 +2092,13 @@ void ata_dev_power_set_active(struct ata_device *d=
ev)
>  	if (!ata_dev_power_init_tf(dev, &tf, true))
>  		return;
> =20
> +	/*
> +	 * Check the device power state & condition and force a spinup with
> +	 * VERIFY command only if the drive is not already ACTIVE or IDLE.
> +	 */
> +	if (ata_dev_power_is_active(dev))
> +		return;
> +
>  	ata_dev_notice(dev, "Entering active power mode\n");
> =20
>  	err_mask =3D ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
> --=20
> 2.41.0
>=20

From your explaination in:
https://lore.kernel.org/linux-ide/c0b086ab-dcd5-4b7b-b931-4d407dd7ad47@kern=
el.org/

The drive will be in the active power state when the drive is in the
process of spinning up the drive, even if the drive is not fully spun
up, and the reply to the first I/O will be delayed until the drive is
fully spun up.

Therefore, this patch makes a lot of sense:
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
