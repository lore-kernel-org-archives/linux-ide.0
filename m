From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v12 7/9] libata: scsi: no poll when ODD is powered off
Date: Thu, 10 Jan 2013 11:56:10 -0800
Message-ID: <20130110195610.GL20454@htj.dyndns.org>
References: <1357809870-18816-1-git-send-email-aaron.lu@intel.com>
 <1357809870-18816-8-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:34524 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755004Ab3AJT4P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jan 2013 14:56:15 -0500
Content-Disposition: inline
In-Reply-To: <1357809870-18816-8-git-send-email-aaron.lu@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Aaron Lu <aaron.lwe@gmail.com>, Jeff Wu <jeff.wu@amd.com>, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Jan 10, 2013 at 05:24:28PM +0800, Aaron Lu wrote:
> @@ -182,6 +182,13 @@ void zpodd_enable_run_wake(struct ata_device *dev)
>  {
>  	struct zpodd *zpodd = dev->zpodd;
>  
> +	/*
> +	 * Silence the media change poll, as we will be notified when
> +	 * user wants to use the ODD so there is no meaning to poll
> +	 * it when it is powered off
> +	 */
> +	dev->sdev->disable_disk_events = true;

What's the synchronization rule for this field?

Thanks.

-- 
tejun
