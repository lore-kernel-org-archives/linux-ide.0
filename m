Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FFA3B182
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 06:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257809; cv=none; b=SvaXHhiLvR1TLcK8M0Sx1WieYFrToQUpHmqrTUfJAvyc+pm0ht1w0p4FtaW5s62NEWS+H1Wr2qD8VawuQ9/jr8jxrPvZQdvJbp/KnfM8wZeji5a0irp2xuuw9QoT3Okl9RQRsEov2gYtkPZHpGAmELwl07hIdrQjXO3ZdLOK0/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257809; c=relaxed/simple;
	bh=RQ7u4f43sjB5KGHLOxYrg2Uepn5CvvXmLeZIpJX3/lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KkSXElMfHqEi5824oc0+cSb7B/kOaHKwAz4gn/YM6JD99610Z3eUx71pQbaYFLINf1aRD8cvjSzFJHuVeYRBYUAXRaP+7C4JxlAlN+NRzptybw8lHwdXQ83DduDWvUM2RW8s8QDPV9uf/Yy9SiuT84+1qtlZu24a4gNvBom6YOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OYkD1lhp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jgWu5ed9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OYkD1lhp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jgWu5ed9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OYkD1lhp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jgWu5ed9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OYkD1lhp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jgWu5ed9"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8EFD91FB9C;
	Mon,  2 Sep 2024 06:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725257805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l5/HJpoHaRo2erMgudCwy6ZwrPogaRbzLnytjScMNsc=;
	b=OYkD1lhpuvOeJA9MbhKJgpDi5CfKY5Ws388ildDtUiC2teLhyY7zr7A03ALCQnlywun7l5
	6nbuXCZc1qolbnvPB2vhKElY81x7E94p+c5ko7gXM2qMVGru1Oq8AXItDMNPtvSNPNKQPq
	XzsTH+c2XtRhKCmXDLuAeeV17sBu3hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725257805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l5/HJpoHaRo2erMgudCwy6ZwrPogaRbzLnytjScMNsc=;
	b=jgWu5ed9zfKAyied5oV7Wmv+sF7K6kj/hixvKAEdX01TZPtMY3j3tvrzeQxFqnXTniLEKS
	5gWwJVOQS/MuQtDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OYkD1lhp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jgWu5ed9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725257805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l5/HJpoHaRo2erMgudCwy6ZwrPogaRbzLnytjScMNsc=;
	b=OYkD1lhpuvOeJA9MbhKJgpDi5CfKY5Ws388ildDtUiC2teLhyY7zr7A03ALCQnlywun7l5
	6nbuXCZc1qolbnvPB2vhKElY81x7E94p+c5ko7gXM2qMVGru1Oq8AXItDMNPtvSNPNKQPq
	XzsTH+c2XtRhKCmXDLuAeeV17sBu3hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725257805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l5/HJpoHaRo2erMgudCwy6ZwrPogaRbzLnytjScMNsc=;
	b=jgWu5ed9zfKAyied5oV7Wmv+sF7K6kj/hixvKAEdX01TZPtMY3j3tvrzeQxFqnXTniLEKS
	5gWwJVOQS/MuQtDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6604D13AE5;
	Mon,  2 Sep 2024 06:16:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JCQaF01Y1Wa8GQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Sep 2024 06:16:45 +0000
Message-ID: <e34aded2-c0f4-44f1-8941-4eb8c3818bc2@suse.de>
Date: Mon, 2 Sep 2024 08:16:44 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] ata: libata: Cleanup libata-transport
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20240902000043.155495-1-dlemoal@kernel.org>
 <20240902000043.155495-2-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240902000043.155495-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8EFD91FB9C
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO

On 9/2/24 02:00, Damien Le Moal wrote:
> Move the transport link device related functions after the device
> transport related functions to avoid the need for forward declaring
> ata_tdev_add() and ata_tdev_delete().
> 
> And while at it, improve the kdoc comments for ata_tdev_free() and
> ata_tdev_delete().
> 
> No functional changes are introduced.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-transport.c | 281 ++++++++++++++++-----------------
>   1 file changed, 137 insertions(+), 144 deletions(-)
> 
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
> index 48800cd0e75d..2a5025b2f28b 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -80,12 +80,6 @@ struct ata_internal {
>   #define transport_class_to_port(dev)				\
>   	tdev_to_port((dev)->parent)
>   
> -
> -/* Device objects are always created whit link objects */
> -static int ata_tdev_add(struct ata_device *dev);
> -static void ata_tdev_delete(struct ata_device *dev);
> -
> -
>   /*
>    * Hack to allow attributes of the same name in different objects.
>    */
> @@ -364,135 +358,6 @@ unsigned int ata_port_classify(struct ata_port *ap,
>   }
>   EXPORT_SYMBOL_GPL(ata_port_classify);
>   
> -/*
> - * ATA link attributes
> - */
> -static int noop(int x) { return x; }
> -
> -#define ata_link_show_linkspeed(field, format)				\
> -static ssize_t								\
> -show_ata_link_##field(struct device *dev,				\
> -		      struct device_attribute *attr, char *buf)		\
> -{									\
> -	struct ata_link *link = transport_class_to_link(dev);		\
> -									\
> -	return sprintf(buf, "%s\n", sata_spd_string(format(link->field))); \
> -}
> -
> -#define ata_link_linkspeed_attr(field, format)				\
> -	ata_link_show_linkspeed(field, format)				\
> -static DEVICE_ATTR(field, S_IRUGO, show_ata_link_##field, NULL)
> -
> -ata_link_linkspeed_attr(hw_sata_spd_limit, fls);
> -ata_link_linkspeed_attr(sata_spd_limit, fls);
> -ata_link_linkspeed_attr(sata_spd, noop);
> -
> -
> -static DECLARE_TRANSPORT_CLASS(ata_link_class,
> -		"ata_link", NULL, NULL, NULL);
> -
> -static void ata_tlink_release(struct device *dev)
> -{
> -}
> -
> -/**
> - * ata_is_link --  check if a struct device represents a ATA link
> - * @dev:	device to check
> - *
> - * Returns:
> - *	%1 if the device represents a ATA link, %0 else
> - */
> -static int ata_is_link(const struct device *dev)
> -{
> -	return dev->release == ata_tlink_release;
> -}
> -
> -static int ata_tlink_match(struct attribute_container *cont,
> -			   struct device *dev)
> -{
> -	struct ata_internal* i = to_ata_internal(ata_scsi_transport_template);
> -	if (!ata_is_link(dev))
> -		return 0;
> -	return &i->link_attr_cont.ac == cont;
> -}
> -
> -/**
> - * ata_tlink_delete  --  remove ATA LINK
> - * @link:	ATA LINK to remove
> - *
> - * Removes the specified ATA LINK.  remove associated ATA device(s) as well.
> - */
> -void ata_tlink_delete(struct ata_link *link)
> -{
> -	struct device *dev = &link->tdev;
> -	struct ata_device *ata_dev;
> -
> -	ata_for_each_dev(ata_dev, link, ALL) {
> -		ata_tdev_delete(ata_dev);
> -	}
> -
> -	transport_remove_device(dev);
> -	device_del(dev);
> -	transport_destroy_device(dev);
> -	put_device(dev);
> -}
> -
> -/**
> - * ata_tlink_add  --  initialize a transport ATA link structure
> - * @link:	allocated ata_link structure.
> - *
> - * Initialize an ATA LINK structure for sysfs.  It will be added in the
> - * device tree below the ATA PORT it belongs to.
> - *
> - * Returns %0 on success
> - */
> -int ata_tlink_add(struct ata_link *link)
> -{
> -	struct device *dev = &link->tdev;
> -	struct ata_port *ap = link->ap;
> -	struct ata_device *ata_dev;
> -	int error;
> -
> -	device_initialize(dev);
> -	dev->parent = &ap->tdev;
> -	dev->release = ata_tlink_release;
> -	if (ata_is_host_link(link))
> -		dev_set_name(dev, "link%d", ap->print_id);
> -	else
> -		dev_set_name(dev, "link%d.%d", ap->print_id, link->pmp);
> -
> -	transport_setup_device(dev);
> -
> -	error = device_add(dev);
> -	if (error) {
> -		goto tlink_err;
> -	}
> -
> -	error = transport_add_device(dev);
> -	if (error)
> -		goto tlink_transport_err;
> -	transport_configure_device(dev);
> -
> -	ata_for_each_dev(ata_dev, link, ALL) {
> -		error = ata_tdev_add(ata_dev);
> -		if (error) {
> -			goto tlink_dev_err;
> -		}
> -	}
> -	return 0;
> -  tlink_dev_err:
> -	while (--ata_dev >= link->device) {
> -		ata_tdev_delete(ata_dev);
> -	}
> -	transport_remove_device(dev);
> -  tlink_transport_err:
> -	device_del(dev);
> -  tlink_err:
> -	transport_destroy_device(dev);
> -	put_device(dev);
> -	return error;
> -}
> -
>   /*
>    * ATA device attributes
>    */
> @@ -660,14 +525,14 @@ static int ata_tdev_match(struct attribute_container *cont,
>   }
>   
>   /**
> - * ata_tdev_free  --  free a ATA LINK
> - * @dev:	ATA PHY to free
> + * ata_tdev_free  --  free a transport ATA device structure

Odd wording; maybe 'ATA transport device' ?

> + * @dev:	target ATA device

Why 'target ATA device'? Wouldn't 'ATA transport device' be better?

>    *
> - * Frees the specified ATA PHY.
> + * Free the transport ATA device structure for the specified ATA device.

Same here.

>    *
>    * Note:
> - *   This function must only be called on a PHY that has not
> - *   successfully been added using ata_tdev_add().
> + *   This function must only be called on a device that has not successfully

'device'? Shouldn't we not use the same wording as in the description?

> + *   been added using ata_tdev_add().
>    */
>   static void ata_tdev_free(struct ata_device *dev)
>   {
> @@ -676,10 +541,10 @@ static void ata_tdev_free(struct ata_device *dev)
>   }
>   
>   /**
> - * ata_tdev_delete  --  remove ATA device
> - * @ata_dev:	ATA device to remove
> + * ata_tdev_delete  --  remove an ATA device sysfs entry
> + * @ata_dev:	target ATA device
>    *

And here we should be consistent with whatever wording we've been using
in ata_tdev_free().

> - * Removes the specified ATA device.
> + * Removes the transport sysfs entry for the specified ATA device.
>    */
>   static void ata_tdev_delete(struct ata_device *ata_dev)
>   {
> @@ -690,7 +555,6 @@ static void ata_tdev_delete(struct ata_device *ata_dev)
>   	ata_tdev_free(ata_dev);
>   }
>   
> -
>   /**
>    * ata_tdev_add  --  initialize a transport ATA device structure.
>    * @ata_dev:	ata_dev structure.

And we would need to modify this, too, to have the same wording.

> @@ -734,6 +598,135 @@ static int ata_tdev_add(struct ata_device *ata_dev)
>   	return 0;
>   }
>   
> +/*
> + * ATA link attributes
> + */
> +static int noop(int x)
> +{
> +	return x;
> +}
> +
> +#define ata_link_show_linkspeed(field, format)			\
> +static ssize_t							\
> +show_ata_link_##field(struct device *dev,			\
> +		      struct device_attribute *attr, char *buf)	\
> +{								\
> +	struct ata_link *link = transport_class_to_link(dev);	\
> +								\
> +	return sprintf(buf, "%s\n",				\
> +		       sata_spd_string(format(link->field)));	\
> +}
> +
> +#define ata_link_linkspeed_attr(field, format)			\
> +	ata_link_show_linkspeed(field, format)			\
> +static DEVICE_ATTR(field, 0444, show_ata_link_##field, NULL)
> +
> +ata_link_linkspeed_attr(hw_sata_spd_limit, fls);
> +ata_link_linkspeed_attr(sata_spd_limit, fls);
> +ata_link_linkspeed_attr(sata_spd, noop);
> +
> +static DECLARE_TRANSPORT_CLASS(ata_link_class,
> +		"ata_link", NULL, NULL, NULL);
> +
> +static void ata_tlink_release(struct device *dev)
> +{
> +}
> +
> +/**
> + * ata_is_link --  check if a struct device represents a ATA link
> + * @dev:	device to check
> + *
> + * Returns:
> + *	%1 if the device represents a ATA link, %0 else
> + */
> +static int ata_is_link(const struct device *dev)

Why is this not a boolean ?

> +{
> +	return dev->release == ata_tlink_release;
> +}
> +
> +static int ata_tlink_match(struct attribute_container *cont,
> +			   struct device *dev)
> +{
> +	struct ata_internal *i = to_ata_internal(ata_scsi_transport_template);
> +
> +	if (!ata_is_link(dev))
> +		return 0;
> +	return &i->link_attr_cont.ac == cont;
> +}
> +
> +/**
> + * ata_tlink_delete  --  remove ATA LINK
> + * @link:	ATA LINK to remove

Why is the 'link' in capital letters?

> + *
> + * Removes the specified ATA LINK.  remove associated ATA device(s) as well.
> + */
> +void ata_tlink_delete(struct ata_link *link)
> +{
> +	struct device *dev = &link->tdev;
> +	struct ata_device *ata_dev;
> +
> +	ata_for_each_dev(ata_dev, link, ALL) {
> +		ata_tdev_delete(ata_dev);
> +	}
> +
> +	transport_remove_device(dev);
> +	device_del(dev);
> +	transport_destroy_device(dev);
> +	put_device(dev);
> +}
> +
> +/**
> + * ata_tlink_add  --  initialize a transport ATA link structure
> + * @link:	allocated ata_link structure.

Same comment than above: why 'transport ATA link', and not 'ATA 
transport link' ?

> + *
> + * Initialize an ATA LINK structure for sysfs.  It will be added in the
> + * device tree below the ATA PORT it belongs to.
> + *
> + * Returns %0 on success

And what on failure?

> + */
> +int ata_tlink_add(struct ata_link *link)
> +{
> +	struct device *dev = &link->tdev;
> +	struct ata_port *ap = link->ap;
> +	struct ata_device *ata_dev;
> +	int error;
> +
> +	device_initialize(dev);
> +	dev->parent = &ap->tdev;
> +	dev->release = ata_tlink_release;
> +	if (ata_is_host_link(link))
> +		dev_set_name(dev, "link%d", ap->print_id);
> +	else
> +		dev_set_name(dev, "link%d.%d", ap->print_id, link->pmp);
> +
> +	transport_setup_device(dev);
> +
> +	error = device_add(dev);
> +	if (error)
> +		goto tlink_err;
> +
> +	error = transport_add_device(dev);
> +	if (error)
> +		goto tlink_transport_err;
> +	transport_configure_device(dev);
> +
> +	ata_for_each_dev(ata_dev, link, ALL) {
> +		error = ata_tdev_add(ata_dev);
> +		if (error)
> +			goto tlink_dev_err;
> +	}
> +	return 0;
> + tlink_dev_err:
> +	while (--ata_dev >= link->device)
> +		ata_tdev_delete(ata_dev);
> +	transport_remove_device(dev);
> + tlink_transport_err:
> +	device_del(dev);
> + tlink_err:
> +	transport_destroy_device(dev);
> +	put_device(dev);
> +	return error;
> +}
>   
>   /*
>    * Setup / Teardown code

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

