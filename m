Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E8DC433EF
	for <linux-ide@archiver.kernel.org>; Fri, 25 Mar 2022 03:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiCYDDV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Mar 2022 23:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358182AbiCYDDG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2022 23:03:06 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99539AE6F
        for <linux-ide@vger.kernel.org>; Thu, 24 Mar 2022 20:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648177291; x=1679713291;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CP3+Xu81tR9zqyhMRVWjzAG/iA0x4tF2KCn0Yf+Ht3Y=;
  b=ToDqJxCz9QLhNPzR32GOrn7vb6PQ6IH7DeCaZz5u+Z5FoBmi4ewSheOR
   CX9mVq8mno1W3Q5XDujrtntiXECO3k4gAAjbFBIKRBeEEcF17HBMmui9Y
   46+RLqb1gp2UsPdg/3DyOP0jMTxqkAPMpomawfRl/rDpPUVUo4o2PE1Fk
   Y+7lRXsMXdrbHgqb0wwhuIKEHWxo5Vx6MUcrXagxGSemOMpUhSb9M0W55
   +gY8ebMeJPpOxGr1Jrs/IOlSR9B7G3HSpRJZsw6GFAVbmXyJD+PUVIapc
   fK9mzpL9Vt9CImYQAH1KIBWu8qAEnAaiFkR7zK66xOOMe8K9tzPAcK0t8
   A==;
X-IronPort-AV: E=Sophos;i="5.90,209,1643644800"; 
   d="scan'208";a="196233500"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2022 11:01:27 +0800
IronPort-SDR: 9OL2mbfvALL3o+QAohox+PyyDiuqONZeIqWwrVTyItbNVVD4xrK8j30LQkru4Mbpzh7p2onCie
 0hhmMWRS4saWiSB1eVDfCaRrFo5U3K5uaE/QA6NsfWZkZ+rwZPQZYtnFqCWVZN6KVy8OWrsexU
 vT9BBhWn3W803jm8PirPtkO2DDDIICb2oV/m9tK9j8QKlvpyBeWRSE0yCSAoazetIBuueUAwoZ
 aP7esQ5VFm/CDQN+tI9wqzTaITzGB81M/DHSXKdSNE7bGyqCzwMlWoRR2iIi75ArSJ24m9RfsD
 ppEVPNGN4uuO81GF5gC8UY9Y
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 19:33:18 -0700
IronPort-SDR: NdpDN59Py6YB5JItxCQtyOGpkq5RKXzQIXYx7cnt0NtNzaQ1klDqdBxiqbTD4NO6hZ2avgez7z
 w4aKDeVYJXKHF7/d6yl66yGg2Un/ugfR2h1/AZ/2jmMhYCmXt/LDVXSf0rtdaOQNMyNHlh8G23
 glDNUn91zkLCDNyfvrA/FfCLyiFJmfZ5NNmrOiIjklLtY2cA/zhrTaUiPcuN9PgvGUZ6F72cjJ
 14fVNjWkLXrEiyJXhnY8zOWrMYRf5ty8mIm8Uf9xBEkIyoUZyb5tge4dl2fhNtgzfHTiaQjfTg
 xIo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 20:01:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KPn1329bNz1SHwl
        for <linux-ide@vger.kernel.org>; Thu, 24 Mar 2022 20:01:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648177286; x=1650769287; bh=CP3+Xu81tR9zqyhMRVWjzAG/iA0x4tF2KCn
        0Yf+Ht3Y=; b=c5P82c7qK+W5pdENuIFHUsqS72BcHWiT2oETVCmE3CKSPdinmQJ
        PN94rv5d0k4JB9r+6yx0DRXkqSjX/lO4OWGgwipu+OEFL4fPb1jkD8e89rTXW3gv
        O+CahBiFBkJfyt2zMIWzF9QWkJijHKiIUCdddI3+AIxZOuGKgeqVKvMk0mX3aTu/
        jvQXYMv99EZrlVDg83PS6WI55SDsLgVlhHyDVW69eYMXYYqHGQm1sexIqkXEMqcE
        tn0MocW9grgX8jlRp8lUTrfol0jdMqxnZZNpAQnW5L5WH02INNv1y6QV/gOzYI5L
        BgXGiP0MebL5b9XOuYkK+PScK0ZgweORPPQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WXmWvXBl5QQC for <linux-ide@vger.kernel.org>;
        Thu, 24 Mar 2022 20:01:26 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KPn1221lKz1Rvlx;
        Thu, 24 Mar 2022 20:01:26 -0700 (PDT)
Message-ID: <e1e36f35-deee-1ec5-732b-575a68579610@opensource.wdc.com>
Date:   Fri, 25 Mar 2022 12:01:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] libata: CONFIG_ATA_SYSFS_COMPAT
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org
References: <20220324123204.61534-1-hare@suse.de>
 <20220324123204.61534-3-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220324123204.61534-3-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/24/22 21:32, Hannes Reinecke wrote:
> Add a config option 'ATA_SYSFS_COMPAT' to create a compability

s/compability/compatibility

> 'ata' symlink in the PCI device sysfs directory.

I am not yet convinced if this new config option is really necessary... 
We could create the symlink unconditionally, no ?

In any case, I would like to at least reduce the number of #ifdef. So 
what about something like this on top of your patch:

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index a66c3480bdcf..fa249638bfb6 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -251,6 +251,40 @@ static int ata_tport_match(struct 
attribute_container *cont,
  	return &ata_scsi_transport_template->host_attrs.ac == cont;
  }

+#ifdef CONFIG_ATA_SYSFS_COMPAT
+
+static int ata_tport_compat_link_add(struct ata_port *ap)
+{
+	struct device *dev = &ap->tdev;
+	struct device *parent = dev->parent;
+	char compat_name[64];
+
+	sprintf(compat_name, "ata%d", ap->print_id);
+
+	return sysfs_create_link(&parent->kobj, &dev->kobj, compat_name);
+}
+
+static void ata_tport_compat_link_delete(struct ata_port *ap)
+{
+	struct device *dev = &ap->tdev;
+	struct device *parent = dev->parent;
+	char compat_name[64];
+
+	sprintf(compat_name, "ata%d", ap->print_id);
+	sysfs_remove_link(&parent->kobj, compat_name);
+}
+
+#else
+
+static inline int ata_tport_compat_link_add(struct ata_port *ap)
+{
+	return 0;
+}
+
+static inline void ata_tport_compat_link_delete(struct ata_port *ap) {}
+
+#endif
+
  /**
   * ata_tport_delete  --  remove ATA PORT
   * @ap:	ATA PORT to remove
@@ -260,13 +294,8 @@ static int ata_tport_match(struct 
attribute_container *cont,
  void ata_tport_delete(struct ata_port *ap)
  {
  	struct device *dev = &ap->tdev;
-#ifdef CONFIG_ATA_SYSFS_COMPAT
-	struct device *parent = dev->parent;
-	char compat_name[64];

-	sprintf(compat_name, "ata%d", ap->print_id);
-	sysfs_remove_link(&parent->kobj, compat_name);
-#endif
+	ata_tport_compat_link_delete(ap);
  	ata_tlink_delete(&ap->link);

  	transport_remove_device(dev);
@@ -290,9 +319,6 @@ int ata_tport_add(struct device *parent,
  {
  	int error;
  	struct device *dev = &ap->tdev;
-#ifdef CONFIG_ATA_SYSFS_COMPAT
-	char compat_name[64];
-#endif

  	device_initialize(dev);
  	dev->type = &ata_port_type;
@@ -323,18 +349,14 @@ int ata_tport_add(struct device *parent,
  		goto tport_link_err;
  	}

-#ifdef CONFIG_ATA_SYSFS_COMPAT
-	sprintf(compat_name, "ata%d", ap->print_id);
-	error = sysfs_create_link(&parent->kobj, &dev->kobj, compat_name);
+	error = ata_tport_compat_link_add(ap);
  	if (error)
  		goto compat_link_err;
-#endif
+
  	return 0;

-#ifdef CONFIG_ATA_SYSFS_COMPAT
   compat_link_err:
  	ata_tlink_delete(&ap->link);
-#endif
   tport_link_err:
  	transport_remove_device(dev);
  	device_del(dev);



> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/ata/Kconfig            | 10 ++++++++++
>   drivers/ata/libata-transport.c | 20 ++++++++++++++++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index e5641e6c52ee..f27b12ba2ce7 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -51,6 +51,16 @@ config ATA_VERBOSE_ERROR
>   
>   	  If unsure, say Y.
>   
> +config ATA_SYSFS_COMPAT
> +	bool "Keep original sysfs layout"
> +	default y
> +	help
> +	  This option retains the original sysfs layout by adding an
> +	  additional ata_port object with the name of 'ataX' in
> +	  to the ATA objects like 'ata_port', 'ata_link', and 'ata_device'.
> +
> +	  If unsure, say Y.
> +
>   config ATA_FORCE
>   	bool "\"libata.force=\" kernel parameter support" if EXPERT
>   	default y
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
> index 555fe6e2293d..a66c3480bdcf 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -260,7 +260,13 @@ static int ata_tport_match(struct attribute_container *cont,
>   void ata_tport_delete(struct ata_port *ap)
>   {
>   	struct device *dev = &ap->tdev;
> +#ifdef CONFIG_ATA_SYSFS_COMPAT
> +	struct device *parent = dev->parent;
> +	char compat_name[64];
>   
> +	sprintf(compat_name, "ata%d", ap->print_id);
> +	sysfs_remove_link(&parent->kobj, compat_name);
> +#endif
>   	ata_tlink_delete(&ap->link);
>   
>   	transport_remove_device(dev);
> @@ -284,6 +290,9 @@ int ata_tport_add(struct device *parent,
>   {
>   	int error;
>   	struct device *dev = &ap->tdev;
> +#ifdef CONFIG_ATA_SYSFS_COMPAT
> +	char compat_name[64];
> +#endif
>   
>   	device_initialize(dev);
>   	dev->type = &ata_port_type;
> @@ -313,8 +322,19 @@ int ata_tport_add(struct device *parent,
>   	if (error) {
>   		goto tport_link_err;
>   	}
> +
> +#ifdef CONFIG_ATA_SYSFS_COMPAT
> +	sprintf(compat_name, "ata%d", ap->print_id);
> +	error = sysfs_create_link(&parent->kobj, &dev->kobj, compat_name);
> +	if (error)
> +		goto compat_link_err;
> +#endif
>   	return 0;
>   
> +#ifdef CONFIG_ATA_SYSFS_COMPAT
> + compat_link_err:
> +	ata_tlink_delete(&ap->link);
> +#endif
>    tport_link_err:
>   	transport_remove_device(dev);
>   	device_del(dev);


-- 
Damien Le Moal
Western Digital Research
