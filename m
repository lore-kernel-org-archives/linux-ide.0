Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9394313F44D;
	Thu, 13 Jun 2024 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267374; cv=none; b=i+UFXIBaJrdmy7tDhA1OJt/XKPPOvxnUSwQWjfO14xlXbAuSXd+2pzfgaYUEdBZENG6SMVuS+qfkKzc+9URarCvUQo8TXPQWiNNB+NrdOHaMP6QnPkHoQ5l+R1+gajlOKeVGlbph0FU/gfkh9sEqjqwPVFZH5Y53yXsqekJ4nVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267374; c=relaxed/simple;
	bh=l4N3XZH/Lyc04zGUdvrDCw6fJqQjm5MgxchR1YGkeRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPXS5dzSSBw8VGkcmFCq8pj1hD54gD1iRqLqHsHIpCT+OuTcxh3hDUQD2av/gApRkCQuk9i6VqMYfhB25et1cNpoU3h/7HW7F9tsTa0Wb8UWww7e6S8P7sOFpOVSgvPpzS/Th691WMJ6evPE3wj1dkiN+BN23/bYEmnYtJttG/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgoYzJV/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgoYzJV/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6193C2BBFC;
	Thu, 13 Jun 2024 08:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718267374;
	bh=l4N3XZH/Lyc04zGUdvrDCw6fJqQjm5MgxchR1YGkeRs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AgoYzJV/XYhFcenw/J0LJ1afv7x5NXorTpp6unPhJyL7X8JFUxKkr8ypteePygtlk
	 4iB5q6LplWWeGzSXYRt6xgJzmqyoiy+TvYClXzw+tE0HOmRrnjePn8SE3Ry+BwJSBM
	 4iOj1DbuMB3YiGG5mdEqTOnf6F2fYYfj6b+kXePo69HMudb9w2eayMV6haahdh65u+
	 pHRFghIbSAkAwY9LS1CN54iviA/hYy8D+3sQb3ssDnTNEWVi1r9c0R3JXVAJP4H5X2
	 JrLRUgwaRcU8n3wTSGMjnje9d3O2k7Clay1JcuHX/pxU31kixxb7UBLD7a0fd4SHI3
	 mCT0gkOcHjubg==
Message-ID: <63b12a50-7921-4f61-b41f-74e074c5ceb3@kernel.org>
Date: Thu, 13 Jun 2024 17:29:31 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] ata: ahci: a hotplug capable port is an external
 port
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Niklas Cassel <cassel@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>, Daniel Drake <drake@endlessos.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jian-Hong Pan <jhp@endlessos.org>, Dieter Mummenschanz
 <dmummenschanz@web.de>, Mario Limonciello <mario.limonciello@amd.com>,
 linux-ide@vger.kernel.org, regressions@lists.linux.dev
References: <20240206211352.1664816-1-cassel@kernel.org>
 <20240206211352.1664816-3-cassel@kernel.org>
 <c0de8262-dc4b-4c22-9fac-33432e5bddd3@t-8ch.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <c0de8262-dc4b-4c22-9fac-33432e5bddd3@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/13/24 15:34, Thomas Weißschuh wrote:
> Hi everbody,
> 
> On 2024-02-06 22:13:43+0000, Niklas Cassel wrote:
>> A hotplug capable port is an external port, so mark it as such.
>>
>> We even say this ourselves in libata-scsi.c:
>> /* set scsi removable (RMB) bit per ata bit, or if the
>>  * AHCI port says it's external (Hotplug-capable, eSATA).
>>  */
>>
>> This also matches the terminology used in AHCI 1.3.1
>> (the keyword to search for is "externally accessible").
>>
>> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
>> ---
>>  drivers/ata/ahci.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index aa58ce615e79..4d3ec6d15ad1 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -1648,9 +1648,10 @@ static void ahci_mark_external_port(struct ata_port *ap)
>>  	void __iomem *port_mmio = ahci_port_base(ap);
>>  	u32 tmp;
>>  
>> -	/* mark esata ports */
>> +	/* mark external ports (hotplug-capable, eSATA) */
>>  	tmp = readl(port_mmio + PORT_CMD);
>> -	if ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS))
>> +	if (((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS)) ||
>> +	    (tmp & PORT_CMD_HPCP))
>>  		ap->pflags |= ATA_PFLAG_EXTERNAL;
>>  }
> 
> This seems to introduce a userspace regression.
> 
> GNOME/udisks are now automounting internal disks, which they didn't before.
> See [0], [1], [2]
> 
> ATA_PFLAG_EXTERNAL is translated into GENHD_FL_REMOVABLE.
> (Through ata_scsiop_inq_std(), scsi_add_lun(), sd_probe())
> 
> But GENHD_FL_REMOVABLE is not meant for hotpluggable devices but for
> media-changable devices (See its description in include/linux/blkdev.h).
> 
> To indicate hotplug, dev_set_removable() is to be used.
> 
> (Both end up in "removable" sysfs attributes, but these have different
> semantics...)

This should take care of the issue.

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 37ded3875ea3..170ed47ef74a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1912,11 +1912,8 @@ static unsigned int ata_scsiop_inq_std(struct
ata_scsi_args *args, u8 *rbuf)
                2
        };

-       /* set scsi removable (RMB) bit per ata bit, or if the
-        * AHCI port says it's external (Hotplug-capable, eSATA).
-        */
-       if (ata_id_removable(args->id) ||
-           (args->dev->link->ap->pflags & ATA_PFLAG_EXTERNAL))
+       /* Set scsi removable (RMB) bit per ata bit. */
+       if (ata_id_removable(args->id))
                hdr[1] |= (1 << 7);

        if (args->dev->class == ATA_DEV_ZAC) {

BUT, need to check what SAT & SATA-IO have to say about this.

> 
> #regzbot introduced: 45b96d65ec68f625ad26ee16d2f556e29f715005
> 
> [0] https://bbs.archlinux.org/viewtopic.php?id=295958
> [1] https://github.com/storaged-project/udisks/issues/1282
> [2] https://github.com/util-linux/util-linux/issues/3088
> 

-- 
Damien Le Moal
Western Digital Research

