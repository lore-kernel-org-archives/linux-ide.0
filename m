From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH]libata-acpi: add ACPI _PSx method
Date: Thu, 1 Nov 2007 10:04:35 +0000
Message-ID: <20071101100435.7c80785e@the-village.bc.nu>
References: <1189737938.6330.7.camel@sli10-conroe.sh.intel.com>
	<1190341023.16930.5.camel@sli10-conroe.sh.intel.com>
	<200710302227.40310.lenb@kernel.org>
	<200710311426.25099.rjw@sisk.pl>
	<1193885429.6872.2.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1193885429.6872.2.camel@sli10-conroe.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org


> +	max_devices = ata_link_max_devices(&ap->link);
> +
> +	for (i = 0; i < max_devices; ++i) {
> +		struct ata_device *dev = &ap->link.device[i];

Better to use:

	ata_link_for_each_dev(dev, &ap->link) {		

> +
> +		if (dev->acpi_handle)
> +			acpi_bus_set_power(dev->acpi_handle,
> +				state.event == PM_EVENT_ON ?
> +				ACPI_STATE_D0: ACPI_STATE_D3);
> +	}

Also should you not check ata_dev_enabled(dev) ?

Alan
