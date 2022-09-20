Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B67C6FA8E
	for <linux-ide@archiver.kernel.org>; Tue, 20 Sep 2022 22:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiITWCw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 20 Sep 2022 18:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiITWCu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 20 Sep 2022 18:02:50 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DB774DC0
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2022 15:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663711369; x=1695247369;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6u/Do0n+DJNOsBzHcFMsX5pbbOEzyvcZYBGc4xAk91s=;
  b=JLQjnd7bT8m4l7VSq7pWH/3miQGshrhvsXlUxbGT6Z/F4OUEosl6BqBC
   I04Z7jXgH6G1cBD/ziMrsIK26hxeH7+v8DmrJ9/XAWpqbPtx/m3Dhf6NN
   5QH4NXiCvPUCNylR1LlM2EoA6fNeE6um/B675PKYVn7qj5ZbQwpxy1Smk
   f8cDk+bxoGmRiUDuSW1UnIzm3VD5rQLP7TKpEyf4XAmas9btq0BdXDRd+
   d/9RVuNetVKhlzAbe0i7te/YASXh9oybcyK8bg7quVpD1sydSAHEFQsA/
   YAuX1jjoEc/O+kFvretpInog0w2WzzqdHkoHLPdeLklfcZ9NXOYtEO1rw
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,331,1654531200"; 
   d="scan'208";a="211848337"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 06:02:48 +0800
IronPort-SDR: XcNXy8zm2gT/tlcO/FvDpvzjTQXfY6H3zU4VhgQj3fJYBoOmAzDPXCWAnIAiYbwVcw9QwKVZ4C
 dfryuMn8KXPmdUl2oVNbKLEblQ3QDK/UzpWA8p/2HVlRm6ZWlRboIv0syqG1/TDyrPsoC2MIvT
 B0SfAMbyjuNal0TbE1DzG6y+qAxhqZoFT5fJtDZLkn20gJzfiv3DX7BsugC5QlcJICZbOyFo6l
 9TnK96O43vGhwew6i10+n5IUreKGGgZQiR08RWWOTDsVXBGuwDkUgzrF4kzwLzJKz/VPdIld17
 kRnKp9hcQHyLhHJmzdTSPhWo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 14:17:25 -0700
IronPort-SDR: rDq5Knl044Dv4vWjTHG8akuOnUny98ioubum2uxfawuV34Sh4saMCcVdTjkM+cZFwnWe/jhvtA
 fM2uFSl6spOkt4DwoUeYJVaHuq9j64RZeekKBtny2yOgqwSfWEoDciN8l+DOCC8cQqfIPOP+2m
 /KxxUgyd6PUgjYxE5Z51NqXl18G1KhlAh2MNJrCZnaa3/TMujbwfF3qUMs6yTEo8aMidcLS0Gk
 nNV6/Gwk5j2wI3m1q8gNfzHSTEpVhk0IAGZuvONhfPCsZSLGmj84oILRy1shudpXm5I88Oilzz
 CQc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 15:02:50 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MXFsN4cFpz1Rwtl
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2022 15:02:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663711367; x=1666303368; bh=6u/Do0n+DJNOsBzHcFMsX5pbbOEzyvcZYBG
        c4xAk91s=; b=nJ6I2PvV0gQYfKM4izdm2wb9+BRJlNzbwXekfREZ4G1xIRfspah
        7jyOwG88ftP1EIqKFJOWtyIXeOsZFHd+xArwNinO3JVy+LYwHk1HPLsJkL38Oep2
        vwJK0G97+DaZbf49MxiZhi8ISIW2zjXbUPdjuyAwnwObDfIw6rDV68I+rzw//n7q
        zxYOUwcSvxvshEjUdyT+rEwv7uNqjS5ZZ0BAhoYLEW6ftuhvKbfPZyGdCfYIiyHk
        JcHIpvto8ZjKDDatGOXZ5RpfpAmVlH1AEE0vte+hWtAvQHX48TPkfffZsoelYoNj
        lJ1Dxg/TJO1Y0ZKRgHrwQHv9GXMSc8hd50w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id E6ehFVPXqlG9 for <linux-ide@vger.kernel.org>;
        Tue, 20 Sep 2022 15:02:47 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MXFsJ47y5z1RvLy;
        Tue, 20 Sep 2022 15:02:44 -0700 (PDT)
Message-ID: <ecde5199-bb9e-6df4-832a-f3707babd3d6@opensource.wdc.com>
Date:   Wed, 21 Sep 2022 07:02:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RFC 2/6] scsi: scsi_transport_sas: Allocate end device
 target id in the rphy alloc
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, hch@lst.de
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, brking@us.ibm.com
References: <1663669630-21333-1-git-send-email-john.garry@huawei.com>
 <1663669630-21333-3-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1663669630-21333-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/20/22 19:27, John Garry wrote:
> Currently the per-end device target id is allocated when adding the rphy,
> which is when we execute the scan of the target.
> 
> However it will be useful to have the target id allocated earlier when
> allocating the rphy for the end device. For libata we want to move to a
> scheme of allocating the sdev early in the probe process and then later
> executing the scan (for that target). As such, users of would libata would
> require that the target id allocated earlier here (before the scan).
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/scsi_transport_sas.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
> index 2f88c61216ee..56d325665bc7 100644
> --- a/drivers/scsi/scsi_transport_sas.c
> +++ b/drivers/scsi/scsi_transport_sas.c
> @@ -1433,6 +1433,7 @@ static void sas_rphy_initialize(struct sas_rphy *rphy)
>   struct sas_rphy *sas_end_device_alloc(struct sas_port *parent)
>   {
>   	struct Scsi_Host *shost = dev_to_shost(&parent->dev);
> +	struct sas_host_attrs *sas_host = to_sas_host_attrs(shost);
>   	struct sas_end_device *rdev;
>   
>   	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
> @@ -1455,6 +1456,10 @@ struct sas_rphy *sas_end_device_alloc(struct sas_port *parent)
>   	sas_rphy_initialize(&rdev->rphy);
>   	transport_setup_device(&rdev->rphy.dev);
>   
> +	mutex_lock(&sas_host->lock);
> +	rdev->rphy.scsi_target_id = sas_host->next_target_id++;
> +	mutex_unlock(&sas_host->lock);
> +
>   	return &rdev->rphy;
>   }
>   EXPORT_SYMBOL(sas_end_device_alloc);
> @@ -1500,6 +1505,16 @@ struct sas_rphy *sas_expander_alloc(struct sas_port *parent,
>   }
>   EXPORT_SYMBOL(sas_expander_alloc);
>   
> +static bool sas_rphy_end_device_valid_tproto(struct sas_rphy *rphy)
> +{
> +	struct sas_identify *identify = &rphy->identify;
> +
> +	if (identify->target_port_protocols &
> +	    (SAS_PROTOCOL_SSP | SAS_PROTOCOL_STP | SAS_PROTOCOL_SATA))
> +		return true;
> +	return false;

You could just do:

return identify->target_port_protocols &
	(SAS_PROTOCOL_SSP | SAS_PROTOCOL_STP | SAS_PROTOCOL_SATA))

> +}
> +
>   /**
>    * sas_rphy_add  -  add a SAS remote PHY to the device hierarchy
>    * @rphy:	The remote PHY to be added
> @@ -1529,16 +1544,10 @@ int sas_rphy_add(struct sas_rphy *rphy)
>   
>   	mutex_lock(&sas_host->lock);
>   	list_add_tail(&rphy->list, &sas_host->rphy_list);
> -	if (identify->device_type == SAS_END_DEVICE &&
> -	    (identify->target_port_protocols &
> -	     (SAS_PROTOCOL_SSP | SAS_PROTOCOL_STP | SAS_PROTOCOL_SATA)))
> -		rphy->scsi_target_id = sas_host->next_target_id++;
> -	else if (identify->device_type == SAS_END_DEVICE)
> -		rphy->scsi_target_id = -1;
>   	mutex_unlock(&sas_host->lock);
>   
>   	if (identify->device_type == SAS_END_DEVICE &&

You could move this check inside sas_rphy_end_device_valid_tproto(),
no ?

> -	    rphy->scsi_target_id != -1) {
> +	    sas_rphy_end_device_valid_tproto(rphy)) {
>   		int lun;
>   
>   		if (identify->target_port_protocols & SAS_PROTOCOL_SSP)
> @@ -1667,7 +1676,7 @@ static int sas_user_scan(struct Scsi_Host *shost, uint channel,
>   	mutex_lock(&sas_host->lock);
>   	list_for_each_entry(rphy, &sas_host->rphy_list, list) {
>   		if (rphy->identify.device_type != SAS_END_DEVICE ||
> -		    rphy->scsi_target_id == -1)
> +		    !sas_rphy_end_device_valid_tproto(rphy))
>   			continue;
>   
>   		if ((channel == SCAN_WILD_CARD || channel == 0) &&

-- 
Damien Le Moal
Western Digital Research

