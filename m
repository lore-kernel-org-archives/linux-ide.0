Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CEEC433FE
	for <linux-ide@archiver.kernel.org>; Mon,  7 Nov 2022 23:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiKGX7C (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Nov 2022 18:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiKGX6k (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Nov 2022 18:58:40 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D6A2DABA
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 15:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667865464; x=1699401464;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h7HMwgh6hTBAjRkeVunlmyhtXoae1/Hiw6TPRfmjq9E=;
  b=ZT5FiOmxPNw+CAotyl3C/r8nklaW0wuCpSNwJYfeg0qQ5QhCDLDR3GNo
   iXe3RPHC6H1nTnjGwMXzJyAx2DC0W4YNAt+5Tp4wpYEYwLWiVlVRjjOGC
   ECB2nNK/tP8JglL2WUYPAvSnAOpczdO5JFmzt9FPXxS5vQ6zZrjZgtXAN
   3JT3yY1WLs/He5aZiNksH/cvcQFGkPQj95G7u/9ULv75z9z2XQrN90SGM
   Q/yCdEkqVNdFVe7EuOoeugRnitt2wCF8JZHv7S93oPT8J/i066JpTzI+3
   CrT1Do+6AGW0E7twBuEEluAzEFXsckBXsL9/Sy2urEb7ZlNLwrC8BmBhw
   g==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665417600"; 
   d="scan'208";a="320043521"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 07:57:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHP7C/B1URdG6DVq1mxmTF4dKRALvNkxLGNpmmDajKDTr+7Eb4vdqU+YfHKXcLcmi8v2PEVbAIRqeqkKXq+kekMd2FRUdzcPJsOa+ekACsa5XparZxyQUBXAb8bQ3Y/jZ5vXquYaz0qmWFJKrluvqjIIbB6UgGuooW/JTlxp/87JDaXajAzQSZokxk3R4sJG1r/bLWTt9GndLX1HgYu6YzL1BRXjkRz2smSe8H3h0FOg3cTMxZVeYcj1QT4oc0LO940DO+nS47uRt46RxsPlyu0MG178BAfC+fjQlxsKbx+KQalsXpoUgSU6wY/U6feLQhhRKo46j3e07yNWaVVtRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVsfAp6y7zmXcUbXQtuaqZrj4zJSCKaqwHz3ZFEFDZQ=;
 b=inTc3eRxebrxBHHPPhFeLD2zR5ltdDOsV41mxZ4LD07QIVhIODg6lvWjnZo2iNFucyn5qWfBlO5Aprc+Q+x5MIAzCL+/8P/PuV1DDUiNea27wbHEXrwsALGbQ7oZBSPcsCNuXZ1xdpTQw3kGzx5rCXX/IH8+qu9/UHQgcIe1cTiUWImprzRV9ui470w6RTJpwQ8zrQABW29tRqexsEq52DT0U2g1mqHq/jprXOZhsbSODGM3KAjNWGbtVBVwAAQ85iwDGIuOaj7fQEvEPSa75vfE7Wa7IJgdy1suEbECSftyLXWzQBLFzIGkDoyRj54VcuaWKfcmFH+wuDcnUKJ+3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVsfAp6y7zmXcUbXQtuaqZrj4zJSCKaqwHz3ZFEFDZQ=;
 b=HpbxArx0IEFEuRujbFWq4Fnmbpnp5Uq3NBF8GOveQtny4C1q7iRz2w86fBy08Qql6poeRJM84raEf2bXCJgkdYOqfERV1gb6iA8WjMuDJJXpzik/IMYMyyMY+GBKnE6r1ws+eqABlMfKzWz1RHuiA1Es8xFrB5F8qfAaGvqBaO0=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM6PR04MB4636.namprd04.prod.outlook.com (2603:10b6:5:27::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 23:57:21 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::cb5e:7ea3:2482:80f8]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::cb5e:7ea3:2482:80f8%7]) with mapi id 15.20.5791.022; Mon, 7 Nov 2022
 23:57:21 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     John Garry <john.g.garry@oracle.com>
CC:     "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "tj@kernel.org" <tj@kernel.org>, "hare@suse.de" <hare@suse.de>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH v2] ata: libata-core: do not issue non-internal commands
 once EH is pending
Thread-Topic: [PATCH v2] ata: libata-core: do not issue non-internal commands
 once EH is pending
Thread-Index: AQHY8sN+Uw8brLy8kkmVlm0qWKEegK4zr72AgAB0EoA=
Date:   Mon, 7 Nov 2022 23:57:20 +0000
Message-ID: <Y2mbX8MvYrF0FHaI@x1-carbon>
References: <20221107161036.670237-1-niklas.cassel@wdc.com>
 <5a4fa5db-c706-5cf2-1145-bf091445d20e@oracle.com>
In-Reply-To: <5a4fa5db-c706-5cf2-1145-bf091445d20e@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM6PR04MB4636:EE_
x-ms-office365-filtering-correlation-id: 2b3b6741-5497-454e-682e-08dac11bcf2e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YPTKRKlyiZN3Btey5PeAm8tycUOcgIfCAas0vBbcQMu6LBaFV6feb2o/NHhGC55Qb6Pvz0deQfVCknVQMoaedk7zxSil31hOLmbcQQGpA/vSqgAoYNEX2nrHN11gngqcVMLZpnAR6uUydghfl/P+ywA0q/0y/D90JMNbj+Kyur1HHvqsEltsI4FLqq4wlCfCoG8EQ0VojSZuDB2atLgxEMAvetjBi160qHmMA+GWpz9abLmfV+kXY9FmRcxERQ2onEUGueuT2iF7wJynUnrYYLHBBl4tX7dtoOWuYWq4RKwpreVunal/6+VY3rpJSdLQzj0BTlVKtflmYCua/geMt+28zgSLlLgClqd+InRbMmqnmz+48bwSFhup+KfdNuRqZdVMgaoflLspbZ0hMpMxtQyxTui7+eSZm/X1Hl/OXG93NTBLtSBJOue6GeAdTUVe2arHGenlbqqlUCzgHTyoLPAvALOJIEtnD/QvUZIFaEMaK700uqeLKFkyOxyivqmbOHk4Ar4bvfvNRcQFLvsSutIOxN5/r521OsImniCH9VgjXz4cRcEN7i6cWtBziPz5dvmDSfeCtpVIDWt4BnTeMLtnbIowXI0V1wZVVlSOcr3VqcgSvFAbJYI3KLggB89sEJ/hWfZJqTDs1qRbOiC22WliQke2easafMAZb8B0DOi36/Mu2LdFUxO3/AYJG/8s8Z4zFsWpLfbvZMZwJlxM+cu9ZDZIjRHTvvPXyVsCmX1nd49A0o3o5Aox9jvBUHFcOhk56IltzG0TolajQo0MqfdYsbsmyUZJKHDFDPSvH+c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199015)(53546011)(186003)(6506007)(9686003)(6512007)(38100700002)(26005)(122000001)(83380400001)(66946007)(5660300002)(2906002)(33716001)(71200400001)(54906003)(4326008)(6486002)(966005)(316002)(478600001)(41300700001)(64756008)(66556008)(66446008)(6916009)(8936002)(8676002)(66476007)(91956017)(76116006)(38070700005)(82960400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h7waXuGimPdvL+oe1fHPJw4fAyuk6XaPpAxaiu7jr6wefdv/CyfXqXuvuCCz?=
 =?us-ascii?Q?hswwu0QSDwRfFd2KdXGu6faeqAex+BKmP9HOWBMb4EAHJvQXx6YUTygtgMLg?=
 =?us-ascii?Q?jgWLPMUi+/AOh2gO9plDXGdh8yJd2tDc1mlqI0ywYzwl60pu7+h94tp90H7m?=
 =?us-ascii?Q?ftzIOYJefJkMNc/awuQLcDjRcY2NiFK+9VBCU81ITYBVNpwgCajLAZRwt8XB?=
 =?us-ascii?Q?dzB6KqUdCwIW9vFzKgUUFODJR+YWxcl1hm+AYjoV/C1ceu8gWyexdWy/xEqz?=
 =?us-ascii?Q?KAHsxdU7fb/4Em+lBQg4jm27h1ZcWdwj8r/FrGdxl25mVGkcSDL0imgaNqD/?=
 =?us-ascii?Q?JODqMTF0Q4f1ua9J5Hugb5Wc9I+dPh0QULhJ+fdSkPUWnXXX+gBaQHiQbwZ3?=
 =?us-ascii?Q?c+Wz/Pnoesjx2Q9nCyq+fy2Zd5/9Hcdwr7mGeOyFPgB/fgFZCWSq5/6bqRZ1?=
 =?us-ascii?Q?Nn96W3CeGnOV/XhUHGfHEzFbIr1NfeUx0aecqqdTCOW64LIq7sEKUX+CFeuP?=
 =?us-ascii?Q?VaBl360GjQ2/GnH/iMxXsrpnuCNG4OibQh1cw6KCau8ayDoVUY+VYqtTTx2N?=
 =?us-ascii?Q?KZEf4RnaQAA2HuNSnIoGlXqhTKbhixCdKo+Ig0oTR/ovE8Nbf03wg/ctUyQ+?=
 =?us-ascii?Q?C8OGgLoNMUCZ598eSOrhNhg1+fyhD0O+4uW0OVoppJ4FctaXzg6YX3bNTpz0?=
 =?us-ascii?Q?7pTF/BVyMQPoH/6onct5a/E1wVxxkD63fu02a/W8g3hHg2A9sACQuzZL0RaJ?=
 =?us-ascii?Q?jfQsy1OWIzh2NHk2+aDvVyJbN90mbmrMf9vhjfFhsWNA75Ssf6m+Y5y6WivG?=
 =?us-ascii?Q?PncGYSUegJQhwxSVPGQukHMHQjohmrqlfmwNTfGeaLbgXx3DJWaMCZukr81r?=
 =?us-ascii?Q?9pwYeosulvgpId0Q5C8xrgsJgR9rawHSv7uF6c6mgsaqxT7+wCzWWxbhrS/Y?=
 =?us-ascii?Q?GgUouU8Ifn8eIG7UE5a6RLBCaMUJyiGKxbU9rm938JhaXERKLYw5qVks1AaI?=
 =?us-ascii?Q?HHrh50pBYttyOq8fDzgB+Ks1d7ZL040fCQT0RiWtl6iCH1yQf+ZzTAFx97ZZ?=
 =?us-ascii?Q?/Z52wH1yqnDMBDTab5bfQOZqp9BAf1z4T37jdMYJn6OlzpgGNyJGalRxQR96?=
 =?us-ascii?Q?Bp6tgFqCJ09/hFPDzqu7xjfQXlPS2tlVT4iDrFEgJSdmPjCUxGlL8o37uB/V?=
 =?us-ascii?Q?RZ25Q+WGk7jJDMjT7TnqkYtd33Ebni8VXm1Tr5Gr8/oKTSb75dGjnxkyRVSl?=
 =?us-ascii?Q?4yUGArufYl2vwRlnhLXMBfp/fI3rrhK+Qqr887QTxxwzc3ZNi9Yvc6S9LkoP?=
 =?us-ascii?Q?lSUdVu89mvSxb87LmwsAr00jn646jL6gdzUqFFrbdIjYOxImHgSpiZ1lnNuC?=
 =?us-ascii?Q?ZdVLlQdnHHEXF+/I0BMANhRq50cn0JavPUzVwzoxnEQUCwxISsU7Na3jXOol?=
 =?us-ascii?Q?CoPvTXlEKUXGlQhUzSn3U3x3OoiB77Bekfei0vkEJiQGi1BEl3Dg3cHAJ9a4?=
 =?us-ascii?Q?liMywtXi/rM56Q3D4UmMOLLT7/BgXRal38ppRNq4WT5FZk0CauF1zm66M7cb?=
 =?us-ascii?Q?gTwzQzxD55cOEWfxFhxl6euenoutfTw+ftXPZhq8M9jovY1GeOmihlCuYiE/?=
 =?us-ascii?Q?/g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4BD2C817EEADE64C94A61B0D5FEACE6A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3b6741-5497-454e-682e-08dac11bcf2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 23:57:21.0080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lKsEpHt/dInWArgukfPsk7WjMk7YaYtRZJz6kBMxtBkXp4NkzJMCljrVJ4IyFSOfm0OoNn2l96gFeSB0I8kmng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4636
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Nov 07, 2022 at 05:01:53PM +0000, John Garry wrote:
> On 07/11/2022 16:10, Niklas Cassel wrote:
> > scsi_queue_rq() will check if scsi_host_in_recovery() (state is
> > SHOST_RECOVERY), and if so, it will _not_ issue a command via:
> > scsi_dispatch_cmd() -> host->hostt->queuecommand() (ata_scsi_queuecmd()=
)
> > -> __ata_scsi_queuecmd() -> ata_scsi_translate() -> ata_qc_issue()
> >=20
> > Before commit e494f6a72839 ("[SCSI] improved eh timeout handler"),
> > when receiving a TFES error IRQ, this was the call chain:
> > ahci_error_intr() -> ata_port_abort() -> ata_do_link_abort() ->
> > ata_qc_complete() -> ata_qc_schedule_eh() -> blk_abort_request() ->
> > blk_rq_timed_out() -> q->rq_timed_out_fn() (scsi_times_out()) ->
> > scsi_eh_scmd_add() -> scsi_host_set_state(shost, SHOST_RECOVERY)
> >=20
> > Which meant that as soon as the error IRQ was serviced, no additional
> > commands sent from the block layer (scsi_queue_rq()) would be sent down
> > to the device. (ATA internal commands originating for ATA EH could of
> > course still be sent.)
> >=20
> > However, after commit e494f6a72839 ("[SCSI] improved eh timeout handler=
"),
> > scsi_times_out() would instead result in a call to scsi_abort_command()=
 ->
> > queue_delayed_work(). work function: scmd_eh_abort_handler() would call
> > scsi_eh_scmd_add(), which calls scsi_host_set_state(shost, SHOST_RECOVE=
RY).
> >=20
> > (It was possible to get the old behavior if host->hostt->no_async_abort
> > was set, but libata never used it, and this option was completely remov=
ed
> > in commit a06586325f37 ("scsi: make asynchronous aborts mandatory"))
> >=20
> > Additionally, later in commit 358f70da49d7 ("blk-mq: make
> > blk_abort_request() trigger timeout path"), blk_abort_request() was cha=
nged
> > to also call the abort callback asynchronously.
> >=20
> > So now, after the TFES error irq has been serviced, we need to wait for
> > two different workqueues to run their work, before the SHOST_RECOVERY
> > state gets set.
> >=20
> > While the ATA specification states that a device should return command
> > aborted for all commands queued after the device has entered error stat=
e,
> > since ATA only keeps the sense data for the latest command (in non-NCQ
> > case), we really don't want to send block layer commands to the device
> > after it has entered error state. (Only ATA EH commands should be sent,
> > to read the sense data etc.)
> >=20
> > While we could just call scsi_host_set_state(shost, SHOST_RECOVERY) fro=
m
> > ata_qc_schedule_eh() directly, that might be a layering violation.
> > So instead of doing that, add an additional check against the libata's =
own
> > EH flag(s) before calling the qc_defer callback.
> >=20
> > Fixes: e494f6a72839 ("[SCSI] improved eh timeout handler")
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---
> > Changes since v1:
> > -Implemented review comments from Damien.
> >=20
> >   drivers/ata/libata-scsi.c | 20 ++++++++++++++++++++
> >   1 file changed, 20 insertions(+)
> >=20
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index 4cb914103382..383a208f5f99 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -1736,6 +1736,26 @@ static int ata_scsi_translate(struct ata_device =
*dev, struct scsi_cmnd *cmd,
> >   	if (xlat_func(qc))
> >   		goto early_finish;
> > +	/*
> > +	 * scsi_queue_rq() will defer commands when in state SHOST_RECOVERY.
> > +	 *
> > +	 * When getting an error interrupt, ata_port_abort() will be called,
> > +	 * which ends up calling ata_qc_schedule_eh() on all QCs.
> > +	 *
> > +	 * ata_qc_schedule_eh() will call ata_eh_set_pending() and then call
> > +	 * blk_abort_request() on the given QC. blk_abort_request() will
> > +	 * asynchronously end up calling scsi_eh_scmd_add(), which will set
> > +	 * the state to SHOST_RECOVERY and wake up SCSI EH.
> > +	 *
> > +	 * In order to avoid requests from being issued to the device from th=
e
> > +	 * time ata_eh_set_pending() is called, to the time scsi_eh_scmd_add(=
)
> > +	 * sets the state to SHOST_RECOVERY, we defer requests here as well.
> > +	 */
> > +	if (ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS)) {
> > +		rc =3D ATA_DEFER_LINK;
> > +		goto defer;
>=20
> Could we move this check earlier? I mean, we didn't need to have the qc
> alloc'ed and xlat'ed for this check to be done, right?

Sure, we could put it in e.g. ata_scsi_queuecmd() or __ata_scsi_queuecmd().


Or, perhaps it is just time to accept that ATA EH is so interconnected with
SCSI EH, so the simplest thing is just to do:

--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -913,6 +913,7 @@ void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
=20
        qc->flags |=3D ATA_QCFLAG_FAILED;
        ata_eh_set_pending(ap, 1);
+       scsi_host_set_state(ap->scsi_host, SHOST_RECOVERY);
=20
        /* The following will fail if timeout has already expired.
         * ata_scsi_error() takes care of such scmds on EH entry.


Which appears to work just as well as the patch in $subject.

In commit ee7863bc68fa ("[PATCH] SCSI: implement shost->host_eh_scheduled")
Tejun mentioned that "... libata is planning to depart from SCSI, so, for t=
he
time being, libata will be using SCSI EH to handle such exceptions."

Now, 16 years later, ATA is still using SCSI EH (see ata_port_schedule_eh()=
 and
ata_std_sched_eh()) to schedule EH in the case when there are no QCs to abo=
rt:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/ata/libata-eh.c?h=3Dv6.1-rc4#n1004

Damien, thoughts?=
