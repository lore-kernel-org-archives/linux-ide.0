From: Brett Russ <russb@emc.com>
Subject: Re: [PATCH] Re: AHCI: support for tf_read (RFC)
Date: Mon, 07 Mar 2005 11:43:48 -0500
Message-ID: <422C84C4.8090103@emc.com>
References: <20050224232413.4869514FC5@lns1032.lss.emc.com> <421FB272.4030502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from mailhub.lss.emc.com ([168.159.2.31]:36481 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261848AbVCGQn6
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Mar 2005 11:43:58 -0500
In-Reply-To: <421FB272.4030502@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, ric@emc.com

Jeff Garzik wrote:
> Brett Russ wrote:
> 
>> I coded this because ata_pass_thru_cc() (in the dev branch) and other
>> functions call tf_read() which is supported for most except ahci.
>> I've been unable to test because I'm leaving on vacation and am in a
>> last minute rush but wanted to get this out there for comments.
>>
>> Signed-off-by: Brett Russ <russb@emc.com>
> 
> 
> I checked the attached patch into a local repository, but haven't yet 
> merged it into libata-dev-2.6, or tested it.

The reason I didn't just use ata_tf_from_fis() was because I didn't 
think it was valid to overload tf->command with status and tf->feature 
with error.  It was commented as a host->device FIS translation, where 
those fields would line up with the properly named tf fields.

As long as the overload is fine then this is certainly simpler than my 
patch.

BR

<snip>

> +static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
> +{
> +	struct ahci_port_priv *pp = ap->private_data;
> +	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
> +
> +	ata_tf_from_fis(d2h_fis, tf);
>  }
>  
>  static void ahci_fill_sg(struct ata_queued_cmd *qc)

