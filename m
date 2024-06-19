Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054BF1E878
	for <linux-ide@vger.kernel.org>; Wed, 19 Jun 2024 04:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718769887; cv=none; b=aACAipOui3C7KyURxIonTp/ME3S7qNQmac/wsmt85V3jlixsrZuAXY9QbXO3U8/YMAuQM9s+CHfE96xZNISuZKKIhrhpqmDF4k1GEQn1kVhT2qNMzoZubDGZ46BJVDnNkrlQ+esUHlsqeDHrSD5w8Va5MnGdyAZpf01jaVFKzPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718769887; c=relaxed/simple;
	bh=mC+Pkb3o7FydREWd0pNHaZE4c85mPnUvreH4ni45otQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTOarYwBlXY6d7GUdhIBx9Mw+Rot+1I8/F8lK5QmCG0XD7DaVf2fYm+lfzapyp8bLfQPvV8w2aqkMuk6I8Z3o/JnI3Zq84RVP5aXuk1rZEdx2H7kJeECP/I8sgY2N0AlXQmSAqYc/esUyd/4+6+Qo8vk0SIL0EspqfniQvcDYdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqjdzDxx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqjdzDxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41BFC2BBFC;
	Wed, 19 Jun 2024 04:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718769886;
	bh=mC+Pkb3o7FydREWd0pNHaZE4c85mPnUvreH4ni45otQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JqjdzDxx5P9fiHiMZHjuyOkhl7G0GU4wuo2jrI9yaIBozSWjpmAMnkf5jzhmauMFX
	 bdxOVJEki63sz924w+mCXUbl4X92x7VSz4tkOKiAM+9fa/GvmoPd+fn/k9kmfdMU78
	 Qb/JxpdKf+wLud1lbYbXQIzZdj0DIIsG2nna5T/oYZOxxSK6r/2GXx2p2M1zVsNTlK
	 Sr1m7127Aa26Mt08YSDfcwhyEAV4dhChGsC4LDoQJUXNVHVrNxV40MYKygRdVrr/Lm
	 7gCrCq8tt/9LMRXuLvMfKPG9ppKVJWpzaLpfSTdSg5QZrmKLZ8sSMvoawbjnU8A4rh
	 PbdTyRt/39oHg==
Message-ID: <9d1b6c33-3bf0-4df2-b1f0-bb589b701698@kernel.org>
Date: Wed, 19 Jun 2024 13:04:44 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] ata: libata-scsi: Assign local_port_no at host
 allocation time
To: Niklas Cassel <cassel@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-ide@vger.kernel.org
References: <20240618153537.2687621-7-cassel@kernel.org>
 <20240618153537.2687621-11-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240618153537.2687621-11-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 00:35, Niklas Cassel wrote:
> Now when we have removed support for decreasing the number of ports,
> the most logical thing is to assign local_port_no at the same location(s)
> where we assign port_no.
> 
> Note that we cannot move the local_port_no assignment to ata_port_alloc(),
> because not all users of ata_port_alloc() assigns local_port_no
> (i.e. ata_sas_port_alloc()).
> 
> I have no idea what local_port_no is actually used for, but at least
> there should be no functional changes caused by this commit.

It used as the sysfs "port_no" attribute to show the port number relative to the
adapter.

E.g. on my test box which has 2 adapters:

# find /sys -name port_no
/sys/devices/pci0000:00/0000:00:17.0/ata1/ata_port/ata1/port_no
/sys/devices/pci0000:00/0000:00:17.0/ata8/ata_port/ata8/port_no
/sys/devices/pci0000:00/0000:00:17.0/ata6/ata_port/ata6/port_no
/sys/devices/pci0000:00/0000:00:17.0/ata4/ata_port/ata4/port_no
/sys/devices/pci0000:00/0000:00:17.0/ata2/ata_port/ata2/port_no
/sys/devices/pci0000:00/0000:00:17.0/ata7/ata_port/ata7/port_no
/sys/devices/pci0000:00/0000:00:17.0/ata5/ata_port/ata5/port_no
/sys/devices/pci0000:00/0000:00:17.0/ata3/ata_port/ata3/port_no
/sys/devices/pci0000:00/0000:00:1c.0/0000:01:00.0/ata9/ata_port/ata9/port_no
/sys/devices/pci0000:00/0000:00:1c.0/0000:01:00.0/ata10/ata_port/ata10/port_no

For the first adapter:

# cat /sys/devices/pci0000:00/0000:00:17.0/ata1/ata_port/ata1/port_no
1
# cat /sys/devices/pci0000:00/0000:00:17.0/ata2/ata_port/ata2/port_no
2
...

And for the second adapter:

# cat /sys/devices/pci0000:00/0000:00:1c.0/0000:01:00.0/ata9/ata_port/ata9/port_no
1
#cat /sys/devices/pci0000:00/0000:00:1c.0/0000:01:00.0/ata10/ata_port/ata10/port_no
2

So the confusion here is the naming: ap->print_id is an ID increasing for all
adapters, ap->port_no is the index of the port in the host (adapter) array of
ports and local_port_no is the same + 1...

So I think we can get rid of local_port_no by simply rewriting:

ata_port_simple_attr(local_port_no, port_no, "%u\n", unsigned int);

in libata-transport.c. That will avoid this useless and confusing code.

> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/libata-core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index fb4835c2ba2d..ee1a75bc0466 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5591,6 +5591,7 @@ struct ata_host *ata_host_alloc(struct device *dev, int n_ports)
>  			goto err_out;
>  
>  		ap->port_no = i;
> +		ap->local_port_no = i + 1;
>  		host->ports[i] = ap;
>  	}
>  
> @@ -5902,10 +5903,6 @@ int ata_host_register(struct ata_host *host, const struct scsi_host_template *sh
>  	for (i = host->n_ports; host->ports[i]; i++)
>  		WARN_ON(host->ports[i]);
>  
> -	/* give ports names and add SCSI hosts */
> -	for (i = 0; i < host->n_ports; i++)
> -		host->ports[i]->local_port_no = i + 1;
> -
>  	/* Create associated sysfs transport objects  */
>  	for (i = 0; i < host->n_ports; i++) {
>  		rc = ata_tport_add(host->dev,host->ports[i]);

-- 
Damien Le Moal
Western Digital Research

