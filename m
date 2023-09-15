Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C399EE6457
	for <linux-ide@archiver.kernel.org>; Fri, 15 Sep 2023 12:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjIOMHC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 15 Sep 2023 08:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjIOMHB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 15 Sep 2023 08:07:01 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664412113
        for <linux-ide@vger.kernel.org>; Fri, 15 Sep 2023 05:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694779511; x=1726315511;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YOO9gykawAQMkMNX1yLCQJx+stzG15diTTVcwr2eR9I=;
  b=d6YOwwGxvfujkbE/72WEF5ar1Q6YUjMVTWJOFdierNhGgrqphYAbyi6j
   HpFvu8DIYB8lmypxPYjaTpl+8CXHXcGntIOWOrY43AiLoOPgVlcgMsd5C
   OB24h45hNYuv5Fm57wxE6Okx9/tmG3DdovkSfJiw2T9rmAR87wC5Pnwau
   8jBKgk10OpujR2UPYWaPpTsfl7wRd6AmZksodKG12tjJJmaI1EhE0kWCU
   cZ5sGyvD257GkoJuVNjl68xXJznh12ANQ9EqtDQ5MOWybkGY9AUjzLD0C
   kkqrptKR30nP7/B2/zOFQiXDjTWgWzbMZ5QALB8BmdVYW9XN8bvi2IeRk
   w==;
X-CSE-ConnectionGUID: ix9HDc57Qwu4k9P9Ds1LZA==
X-CSE-MsgGUID: 5a96VPnVSLiZJgJCdmxb/g==
X-IronPort-AV: E=Sophos;i="6.02,149,1688400000"; 
   d="scan'208";a="244057901"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 20:05:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miBrXjU5TaNzI6N2oB9Ev4mo+edalr9pTIOikS8cVlBwa9HCBycKJD0oanCKfxeLwdXnLxz1oSSLmuD8up4Yp5uOOjdHGdfM2JrfVW5nTR4cRt8U9ltfeGKHHPvIJB66CF4JFKH34Qhx28xv77L7Mfs6/oxNKQzXNZz9uFnXs/NNnpX9ZkdiFkLr9A4Q7MWcGj5lnxxMR4kw3RA4rkWbAZRaptuAn0oP2mkVrRxHm4ysiCYJYd3zDkl+lw/v3EQkkGu7vqKJF80p6VNIPkLFlYEu6sw+EWkaRDkF+0k874G3so90xeNOk23sfWUKDA/fKMlZFBNzY+8MGxyNQJXgmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5aIAb8ugUe17dp8+0hxGj5PqYTbNoJ8y22ankkc5UU=;
 b=CFTqsQe41OlfvqRI+H87V9U7Gvp2Tr+OS5dNHN1nuFyCPHHP0POh1MUALWvhhTD5qXGzsDGUXla+Xi6ezuq+zpEb4/yryk2WW5aDAdve3fMh7pE4hmBu4yV0COxqwaAifInsYOrgWFT5iKTTACYn6uLM6eNN4RZpU8XHwVzMJgAr5cze5FUikpgkYXwceapPm8xQ4K1lGg/IV8mNwwl73FoYYrFnEp2yQ1a6bhx2cL+5Bf20TXzgrE/POFh7e2fvAxX5uXs1g+4FzDp3JhnsYwFvqivMqVQPsqifG+iqnMxjG0/sMObSZxL8oMyCuXvCrVnwoXKcMfQrfDEzO7iE+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5aIAb8ugUe17dp8+0hxGj5PqYTbNoJ8y22ankkc5UU=;
 b=DmDCCxyY0bJHq87dEj0n9vN/eQd4tKF+9U4fGHjYIZGev03EJEAGvUsIYeM9rUVpFEZ28pln4EeLJ3PnKwNlJD8JCVsS7cCaI6JQq/6g+CNo+WQ2EslPRoLWmQAOkqbERkz5lnIZk3Gk58IEgCNJwD/vUX93GXeTbEim4UiD88w=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by MN2PR04MB6413.namprd04.prod.outlook.com (2603:10b6:208:1a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.8; Fri, 15 Sep
 2023 12:05:08 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6813.007; Fri, 15 Sep 2023
 12:05:07 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     Niklas Cassel <nks@flawful.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        patenteng <dimitar@daskalov.co.uk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] ata: libata-core: fetch sense data for successful
 commands iff CDL enabled
Thread-Topic: [PATCH] ata: libata-core: fetch sense data for successful
 commands iff CDL enabled
Thread-Index: AQHZ5lPDkqhAhkbwJESgzdv+fHeLLLAbcD0AgABc1gA=
Date:   Fri, 15 Sep 2023 12:05:07 +0000
Message-ID: <ZQRIcrQQCKj/bpkH@x1-carbon>
References: <20230913150443.1200790-1-nks@flawful.org>
 <e6fd1980-cbc2-65a1-770b-af745c89a787@kernel.org>
In-Reply-To: <e6fd1980-cbc2-65a1-770b-af745c89a787@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|MN2PR04MB6413:EE_
x-ms-office365-filtering-correlation-id: 2bf7c69f-89c7-408e-cd5e-08dbb5e40112
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wChtARicFq9MX331eCH3ItED4dGUYyxlbUfqeRbNF9QeDza/acFXwr8ViNMJ9w34k+tVF459B2xWVEucduJP+EIjE6xYRUVaWV72cnCh7KeglxWXe1JJYIkkfWc+nUYa3xIon1LRR+PdxjYiwSm+2ugYKGZHUNp8CiqhuGgUAf0nnwA4AhbPYTJ78V7325q7pOZWzoY4U/KJu0fI8TNCJ5loFexdChGi6SsqEL7gHTk6FH8Uz2l77R2tOy/lpA0Vxz0QdPff/fgjAvvX0DXQc0aCnX+TciclJOCahXwHaLWdwgpIDjtvj0BeYwycIr6+ZUGmuSMk4/bKfU/QpUG47FmAkjTewY6rN9z1elUclwqySFaYOLTXB2b7HIifgfOTBkLZSBIrx0/oaRr00U76sNcIHGaixjEhLZML8iNi+bPWJLV8LYZSftACWfr5KzD7lxc6eH9CQVK1ncbM0q2Bym5G40hy26b623hTBQGoFn4wPILhbdZjzidHDeSks3Ur+63nK8EYU8Yu1n/JAJWjg2kjZ3jgKWE66/9MmjbO+b0yNqVZRfVQcPnxMxtvBQv09DZHrK6Qs87nteTA4Vs1DiX1RrnYj0la97JZhnwNnl3fvzZfjBuIy2jlnJQlFOHP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(346002)(136003)(376002)(396003)(186009)(451199024)(1800799009)(26005)(38100700002)(38070700005)(122000001)(478600001)(33716001)(6512007)(82960400001)(6486002)(9686003)(71200400001)(53546011)(6506007)(66556008)(91956017)(66946007)(54906003)(66476007)(41300700001)(316002)(66446008)(64756008)(83380400001)(6916009)(5660300002)(2906002)(8676002)(4326008)(8936002)(76116006)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HyNg7zP1LbOpSBX1LWHTd307uO0S2MNPbYuxz7/cPKUO4AphdJQ7RxRS1aj7?=
 =?us-ascii?Q?Fy85C236hh55gadROf5xkZgoGJ9PafFM04m+pCHtsPrpyTW4KWuJZly/GHMk?=
 =?us-ascii?Q?p1LyTZOdgyuoBTtqXpijYpoDJ3wbdFnUvxdz4+FfeMRp5IQdpoSoaXI7MNhp?=
 =?us-ascii?Q?u41boVblcrbVUrBBhJkLkPMrKskKoTUKOkBvPX1+XPS7SN8USOdmVOVXpxsu?=
 =?us-ascii?Q?HHwEvIbUDbALEZy1xqEIRkcDZxMaxAGb2auOB6YNN87T3WRrSzRL+8k1REDK?=
 =?us-ascii?Q?OX+xAZbDvrCeRDCHXNUZdxNnLQBwRY+efbLW4OVLdfa6enqxKp6ueDxHxgak?=
 =?us-ascii?Q?746AEEG0IaOb5feWN5bZ/Qx+iZl4Cf4A7npVCLqwA+wkC/YpSry+ZllIMXgJ?=
 =?us-ascii?Q?X1EJ2Za+5DJAXdd94+w9J9Mbt9FwosVX916WcOieimaPAJ+1w4d76rcah870?=
 =?us-ascii?Q?HXmCDBS8V/FIte9fDxP2wgBxi8ToTjqPb4TrmFKvG9OgLf/VtxH64GpRaBRf?=
 =?us-ascii?Q?ynOzPIGWZo7bJb/gAzsyk7cvTNJDe6hEZ/+liH1tD7WTayZeOtGtpnLxfCoy?=
 =?us-ascii?Q?KKdaZNXyUCfj+a30synsQUhOhlEGYRYCH3WlFH52O5gJ+Q+A8MBdQdwP8NEI?=
 =?us-ascii?Q?XV4nvmNlhd6goHt1/DJ3nC+EIF6YEg1JuNbtvnZLhsfPyPUIKsYttwEDYg6g?=
 =?us-ascii?Q?9E2Oo5Ab/N7hLLBwqoF9ClTzZpA25mfDNjJgg4n75l5aYK9nNLRT5sjYg5yb?=
 =?us-ascii?Q?GTUcGWSXE2tWXq+r9BnnqKE98hsw+vDCmI1gchSeXNKu2Btr7WKTw6yj2BLV?=
 =?us-ascii?Q?L2h7RXHuzfxw/chqgwdl7qFOhuDgSlyTbDlZBmQxCGtxJEJgdJ0T1bdg6SDk?=
 =?us-ascii?Q?dqL28Oolh0H8h5teWx25GAzqTXdCXUZsqkqW1QPX3R4GZB6oe4rK5mvSm1gF?=
 =?us-ascii?Q?BhYonCe4oKQxgPu7+UeUsfjsZ2zYuDTKgIQWd6bdbq1Dsd5kWOLUzn0EedkP?=
 =?us-ascii?Q?jLVflzdxi0ko3Y//B9dk3L0eepsB+dSBeUBaKEfQSrc9FQK/9L/jhYu0R1z+?=
 =?us-ascii?Q?jJFPFho1qlu3IKLuBaP2yK5voDefY8u8jIisP2xWwUb9BDzZ/8oNVi00jJmv?=
 =?us-ascii?Q?fVlqYbUKocc8c3TxgL0/p/hGD4Qwl01yHElqT02EQTjua0WXLeZvb+EjUpVV?=
 =?us-ascii?Q?WMNA7qb7QOvr+g7asODk0Jl7yeWPOuFpo3cppBQaqK915SqeTkzSSkdk/q0i?=
 =?us-ascii?Q?7lR1UIiP9c9SUdBeuNR85Lez78wOAD/QlwwJJAgcoqxw7rQtQMwaUzPL4VuN?=
 =?us-ascii?Q?tRM6neK7z813c269BMjcEW8TA8PbUKh9e+D/XCHvU0yEz/7S6H4MWwP1nzSV?=
 =?us-ascii?Q?vcDP4KC+F5nHOXw4S+7IDcmPGn5PwZT2MaRnQ2qySRaas+oev19Ccc5lZt82?=
 =?us-ascii?Q?bZ8qUkKAp/ABjM9/ICK3UTl+UPzyWoLpXR5ihiRH/Cy2sp2L+Pv1H6436za+?=
 =?us-ascii?Q?HgZdT00Lca7t54O9WmEq9/QEi2NyrAxjPx8PU+yj8Zp6yXP+8oF9Z1AkyOVZ?=
 =?us-ascii?Q?Mc30CbUk6bnIoHqMh56uQAHXjp13r3qtiO1OQIsEU3aRWpxAftGxsd2KO/M3?=
 =?us-ascii?Q?Mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <04D12DE2088C6448A43C387759F18BF7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dJmyayKQaEYsojeGhEZKqA8Q7Nv2fF0CNJji8jV+OIXvmsOCGwN6IH11MeUGkwKrwvD1Ldk8zhPp+3GX/AHZznVzjZ4NSJCwQwhIel+XF+1n7zJX9mg/eVJJ1iiElGghQYhNW+jftam8yfEYd00eOyk0cHvmonPKXR7MjHs2RLNroALDD6NZk4nhxdWVoqXqQTyMRG6ePRKiVpogu6dUMx7B4WdtrJogGVwFJCIg5ero49RDwbbaQBXrzbmQabOu6qQzFIQXNl6AAphE2lXEwjuhF7SKhXk/6/XRaf1sCZJ+nUxACppTQN00NSK4qZ9vZVrPumBx99FFPNxTpGVXREs1Gi/jMNFswg4k0neWH4FC2/CL9EEbU+ITPm7YNsmjBfiXihKpnYU18u3vIJx3R7WBYJlkQnOAK9DKlfOB3SL9XtWxwqOvRUx/99mcLuneaNkqL2AYvp4nv4KmGVMWyXmIodqeuDAzU+V+XqyWh+MmjI9Db/Rt+43CpjJt8A/lJMgMMqCCSzEdcmgJTP55a5OL8ew6n0P5ytv1ZMSFCexR/Se4FOrENPqFuIf+s9R1LW8s3hbwLG9kNJy+VojpKtDqdaPmMjPyLecBo5iRKYARO+oBSCqwpG+FLLV5wCGAUWQ990qRu6zX64mLtlTrgGqLDawLUzppfx7RYINR7TEeDbQ5wfU5n14zHzO4OAb9dKUGy1zpUcueIEE9hUHZATnwJmqKrjaYDtHcEHT5e4nkm8yQZQiRFEXEhnJsNJmSuVkn/gHaMEphlfXn3p9bXrWrOITCIzqCz3Kp/KmOimqPhd9BzmTUzfjUBmfyTngLRqNiVdTABgfHgLzlwrRAPY2PBJ5qruH8WNjAjMDeDospCsjTad7p21Y4REBIR4tcqb1wXUzYw6UXq8PUcc/5wdrqU7TNIStilFyNPlGGFh0=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf7c69f-89c7-408e-cd5e-08dbb5e40112
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 12:05:07.8185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hg63yc8hDS+FwKxA8QFJFTh1Y/mvIxDNRfzrHCy3LNrzuSKpfKL1FqcSZq9TdE25opTC7fGCdiuqiIR6kSiIDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6413
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Sep 15, 2023 at 03:32:50PM +0900, Damien Le Moal wrote:
> On 9/14/23 00:04, Niklas Cassel wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> >=20
> > Currently, we fetch sense data for a _successful_ command if either:
> > 1) Command was NCQ and ATA_DFLAG_CDL_ENABLED flag set (flag
> >    ATA_DFLAG_CDL_ENABLED will only be set if the Successful NCQ command
> >    sense data supported bit is set); or
> > 2) Command was non-NCQ and regular sense data reporting is enabled.
> >=20
> > This means that case 2) will trigger for a non-NCQ command which has
> > ATA_SENSE bit set, regardless if CDL is enabled or not.
> >=20
> > This decision was by design. If the device reports that it has sense da=
ta
> > available, it makes sense to fetch that sense data, since the sk/asc/as=
cq
> > could be important information regardless if CDL is enabled or not.
> >=20
> > However, the fetching of sense data for a successful command is done vi=
a
> > ATA EH. Considering how intricate the ATA EH is, we really do not want =
to
> > invoke ATA EH unless absolutely needed.
> >=20
> > Before commit 18bd7718b5c4 ("scsi: ata: libata: Handle completion of CD=
L
> > commands using policy 0xD") we never fetched sense data for successful
> > non-NCQ commands.
> >=20
> > In order to not invoke the ATA EH unless absolutely necessary, even if =
the
> > device claims support for sense data reporting, only fetch sense data f=
or
> > successful (NCQ and non-NCQ commands) if CDL is supported and enabled.
> >=20
> > Fixes: 3ac873c76d79 ("ata: libata-core: fix when to fetch sense data fo=
r successful commands")
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---
> >  drivers/ata/libata-core.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index 74314311295f..2f7f72994cd7 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -4784,10 +4784,7 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
> >  	 * 0xD. For these commands, invoke EH to get the command sense data.
> >  	 */
> >  	if (qc->result_tf.status & ATA_SENSE &&
> > -	    ((ata_is_ncq(qc->tf.protocol) &&
> > -	      dev->flags & ATA_DFLAG_CDL_ENABLED) ||
> > -	     (!ata_is_ncq(qc->tf.protocol) &&
> > -	      ata_id_sense_reporting_enabled(dev->id)))) {
> > +	    dev->flags & ATA_DFLAG_CDL_ENABLED) {
>=20
> Applied to for-6.6-fixes with a tweak:
>=20
> 	if (qc->flags & ATA_QCFLAG_HAS_CDL &&
> 	    qc->result_tf.status & ATA_SENSE) {
>=20
> is the test I tweaked. This allows ignoring command that do not use CDL. =
And
> seeing ATA_QCFLAG_HAS_CDL set implies that dev->flags & ATA_DFLAG_CDL_ENA=
BLED is
> true. So this is better I think.

I agree.


Kind regards,
Niklas=
