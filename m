Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B30BC352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 12:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1550B20661
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 12:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="f2/8BbPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgBJMem (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:34:42 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56651 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJMem (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 07:34:42 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210123440euoutp020287cd37776a1e0d8b76204108153102~yCpseGutj2506925069euoutp02M
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 12:34:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210123440euoutp020287cd37776a1e0d8b76204108153102~yCpseGutj2506925069euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581338080;
        bh=cBXFAeypiyL/pK9/TJXKJ2VcITXVb3Vwi07jAYE6gps=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=f2/8BbPQLSrStmH1dlfWAHjX77mm1+hDryIkqOJ3anwUWnjyl75r873VyGwAB0viD
         MYqATiEqj5gUqXIh1yUw7rOcWwcrqFCLPpZDIP9eelpoK5VNVQzinpb+xvPfdAD3Vx
         L3Oavk8vr9u28OiAbUF+oDMphmIRJ+jDLfg8gN1g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210123440eucas1p2708cba590ef6ff044e1984064f43f568~yCpsTgVV42269922699eucas1p2J;
        Mon, 10 Feb 2020 12:34:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5B.F1.61286.0ED414E5; Mon, 10
        Feb 2020 12:34:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210123440eucas1p103fd202fb095aa8bf3dcecbb9599f39e~yCpsFvyLo0530505305eucas1p11;
        Mon, 10 Feb 2020 12:34:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210123440eusmtrp250e5a35cf49796ae2695eca154ec68e7~yCpsFM8m22371923719eusmtrp2l;
        Mon, 10 Feb 2020 12:34:40 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-08-5e414de0b4b7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 03.B4.08375.0ED414E5; Mon, 10
        Feb 2020 12:34:40 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210123439eusmtip28e4d4bf3a84bbbd44cac380bf8c83783~yCprtmNvl2144421444eusmtip2g;
        Mon, 10 Feb 2020 12:34:39 +0000 (GMT)
Subject: Re: [PATCH 05/46] libata: remove pointless debugging messages
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <f214e413-2123-3d85-237d-a829d75e1063@samsung.com>
Date:   Mon, 10 Feb 2020 13:34:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-6-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7oPfB3jDNp2C1qsvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLFJdNSmpOZllqkb5dAldG/+XDTAXb
        1SqW9TcxNTB+k+ti5OSQEDCR+HT6OROILSSwglFi7SWeLkYuIPsLo8S6QwfYIRKfGSWeHpGB
        aWifvJUVomg5o8T8NRMYIYreMkosWyndxcjBISzgJjHhWCJIWERASeJj+yGwOcwCcRJNV+6C
        2WwCVhIT21eBtfIK2Ek83befBcRmEVCVmNF1lBnEFhWIkPj04DArRI2gxMmZT8BqOAWMJa50
        PmOEmCkucevJfCYIW15i+9s5zCC3SQhMZpeYt3E7E8g9EgIuEvNmRUHcLyzx6vgWdghbRuL/
        TpBekPp1jBJ/O15ANW9nlFg++R8bRJW1xJ1zv9hABjELaEqs36UPEXaUOL+inxliPp/EjbeC
        EDfwSUzaNh0qzCvR0SYEUa0msWHZBjaYtV07VzJPYFSaheSzWUi+mYXkm1kIexcwsqxiFE8t
        Lc5NTy02zEst1ytOzC0uzUvXS87P3cQITCin/x3/tIPx66WkQ4wCHIxKPLwO9g5xQqyJZcWV
        uYcYJTiYlUR4LaUd44R4UxIrq1KL8uOLSnNSiw8xSnOwKInzGi96GSskkJ5YkpqdmlqQWgST
        ZeLglGpgbKnbrbT2pP8s+fbVC7bu68rmXbZsjzMb4xvhX0f3n5SXtdsdrro+ae3DDb7lmRxV
        a6+e+DxlcfmKV8sfTf+1XECowPzNl6MftqlWRu5f8y705N3vmYJRn87MD8v58MJxx/vJHtNe
        CntMZOT8wPnERO7H0r8X1dreXbjMvSpBJKAs3ipn/y4hFz8lluKMREMt5qLiRAB5zMUZJAMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7oPfB3jDFasZLZYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M/suHmQq2q1Us629iamD8JtfFyMkhIWAi
        0T55K2sXIxeHkMBSRome35sYuxg5gBIyEsfXl0HUCEv8udbFBlHzmlHiXOM1VpAaYQE3iQnH
        EkFqRASUJD62H2IHsZkF4iT+9e1mgqhfzyhx/sJLFpAEm4CVxMT2VYwgNq+AncTTffvB4iwC
        qhIzuo4yg9iiAhESh3fMgqoRlDg58wlYDaeAscSVzmeMEAvUJf7Mu8QMYYtL3HoynwnClpfY
        /nYO8wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAuNo27Gf
        m3cwXtoYfIhRgINRiYfXwd4hTog1say4MvcQowQHs5IIr6W0Y5wQb0piZVVqUX58UWlOavEh
        RlOg5yYyS4km5wNjPK8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dU
        A2N89RHrdGGPdtf/bwq/s8zmVdbYH7u10NHqX/2/aqacSxL/195jYHx9zUjkaaXcxaubp0ZE
        FGuLMb39zFIX8k7SOOfezO0KJ15PlBU7JC34fMfn0wbh8vu1gkLKzq6sftai5rrgkf6GGW+O
        O8uw/PHbZvZV7s5dk2qhsNuaqol6Icu+Jq7ee1aJpTgj0VCLuag4EQCG07+duQIAAA==
X-CMS-MailID: 20200210123440eucas1p103fd202fb095aa8bf3dcecbb9599f39e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165612eucas1p1536b44de53b36d2c43c802995197c4b4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165612eucas1p1536b44de53b36d2c43c802995197c4b4
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165612eucas1p1536b44de53b36d2c43c802995197c4b4@eucas1p1.samsung.com>
        <20200204165547.115220-6-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> Debugging messages in pci init functions or sg setup are pretty
> much pointless, as the workflow pretty much decides what happened.
> So drop them.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/acard-ahci.c  | 4 ----
>  drivers/ata/ahci.c        | 2 --
>  drivers/ata/libahci.c     | 3 ---
>  drivers/ata/libata-core.c | 6 ------
>  drivers/ata/libata-sff.c  | 2 --
>  drivers/ata/sata_nv.c     | 4 ----
>  6 files changed, 21 deletions(-)
> 
> diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
> index 46dc54d18f0b..5270151ac441 100644
> --- a/drivers/ata/acard-ahci.c
> +++ b/drivers/ata/acard-ahci.c
> @@ -185,8 +185,6 @@ static unsigned int acard_ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
>  	struct acard_sg *acard_sg = cmd_tbl + AHCI_CMD_TBL_HDR_SZ;
>  	unsigned int si, last_si = 0;
>  
> -	VPRINTK("ENTER\n");
> -
>  	/*
>  	 * Next, the S/G list.
>  	 */
> @@ -364,8 +362,6 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
>  	struct ata_host *host;
>  	int n_ports, i, rc;
>  
> -	VPRINTK("ENTER\n");
> -
>  	WARN_ON((int)ATA_MAX_QUEUE > AHCI_MAX_CMDS);
>  
>  	ata_print_version_once(&pdev->dev, DRV_VERSION);
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index b2719c64fc04..4f628e33f52e 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1643,8 +1643,6 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	int n_ports, i, rc;
>  	int ahci_pci_bar = AHCI_PCI_BAR_STANDARD;
>  
> -	VPRINTK("ENTER\n");
> -
>  	WARN_ON((int)ATA_MAX_QUEUE > AHCI_MAX_CMDS);
>  
>  	ata_print_version_once(&pdev->dev, DRV_VERSION);
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index ea5bf5f4cbed..4055071f213f 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1596,8 +1596,6 @@ static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
>  	struct ahci_sg *ahci_sg = cmd_tbl + AHCI_CMD_TBL_HDR_SZ;
>  	unsigned int si;
>  
> -	VPRINTK("ENTER\n");
> -
>  	/*
>  	 * Next, the S/G list.
>  	 */
> @@ -1671,7 +1669,6 @@ static void ahci_fbs_dec_intr(struct ata_port *ap)
>  	u32 fbs = readl(port_mmio + PORT_FBS);
>  	int retries = 3;
>  
> -	DPRINTK("ENTER\n");
>  	BUG_ON(!pp->fbs_enabled);
>  
>  	/* time to wait for DEC is not specified by AHCI spec,
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index cee815ecd7df..cea065fb6282 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5052,8 +5052,6 @@ static int ata_sg_setup(struct ata_queued_cmd *qc)
>  	struct ata_port *ap = qc->ap;
>  	unsigned int n_elem;
>  
> -	VPRINTK("ENTER, ata%u\n", ap->print_id);
> -
>  	n_elem = dma_map_sg(ap->dev, qc->sg, qc->n_elem, qc->dma_dir);
>  	if (n_elem < 1)
>  		return -1;
> @@ -6016,8 +6014,6 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
>  {
>  	struct ata_port *ap;
>  
> -	DPRINTK("ENTER\n");
> -
>  	ap = kzalloc(sizeof(*ap), GFP_KERNEL);
>  	if (!ap)
>  		return NULL;
> @@ -6133,8 +6129,6 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
>  	int i;
>  	void *dr;
>  
> -	DPRINTK("ENTER\n");
> -
>  	/* alloc a container for our list of ATA ports (buses) */
>  	sz = sizeof(struct ata_host) + (max_ports + 1) * sizeof(void *);
>  	host = kzalloc(sz, GFP_KERNEL);
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 038db94216a9..931ae61d69fb 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -2452,8 +2452,6 @@ static int ata_pci_init_one(struct pci_dev *pdev,
>  	struct ata_host *host = NULL;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> -
>  	pi = ata_sff_find_valid_pi(ppi);
>  	if (!pi) {
>  		dev_err(&pdev->dev, "no valid port_info specified\n");
> diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
> index eb9dc14e5147..8639f66706a3 100644
> --- a/drivers/ata/sata_nv.c
> +++ b/drivers/ata/sata_nv.c
> @@ -1271,8 +1271,6 @@ static int nv_adma_host_init(struct ata_host *host)
>  	unsigned int i;
>  	u32 tmp32;
>  
> -	VPRINTK("ENTER\n");
> -
>  	/* enable ADMA on the ports */
>  	pci_read_config_dword(pdev, NV_MCP_SATA_CFG_20, &tmp32);
>  	tmp32 |= NV_MCP_SATA_CFG_20_PORT0_EN |
> @@ -1314,8 +1312,6 @@ static void nv_adma_fill_sg(struct ata_queued_cmd *qc, struct nv_adma_cpb *cpb)
>  	struct scatterlist *sg;
>  	unsigned int si;
>  
> -	VPRINTK("ENTER\n");
> -
>  	for_each_sg(qc->sg, sg, qc->n_elem, si) {
>  		aprd = (si < 5) ? &cpb->aprd[si] :
>  			&pp->aprd[NV_ADMA_SGTBL_LEN * qc->hw_tag + (si-5)];
> 
