From: Tim Small <tim@seoss.co.uk>
Subject: Re: SiI 3726 pmp doesn't work with 2.6.38 and Marvell 88SE9123 AHCI
 controller
Date: Fri, 10 Jun 2011 17:43:39 +0100
Message-ID: <4DF249BB.3040808@seoss.co.uk>
References: <4DEE6831.9020501@seoss.co.uk> <20110609143755.GA2615@htj.dyndns.org> <4DF136FF.2010404@seoss.co.uk> <20110610102403.GE15235@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([78.47.234.210]:60799 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744Ab1FJQno (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jun 2011 12:43:44 -0400
In-Reply-To: <20110610102403.GE15235@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>, Hubert Bailey <hbailey@marvell.com>

On 10/06/11 11:24, Tejun Heo wrote:
> That's weird.  Link is up but EH is detected to be up but EH didn't
> probe it.  Is the behavior reproducible?
>   

I think-so, yes.  I'll double-check.

> Maybe FBS support doesn't work as advertised?  Can you please try the
> following patch?
>
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index d38c40f..a2f4b68 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -444,6 +444,7 @@ void ahci_save_initial_config(struct device *dev,
>  			   "controller can do FBS, turning on CAP_FBS\n");
>  		cap |= HOST_CAP_FBS;
>  	}
> +	cap &= ~HOST_CAP_FBS;
>  
>  	if (force_port_map && port_map != force_port_map) {
>  		dev_printk(KERN_INFO, dev, "forcing port_map 0x%x -> 0x%x\n",
>
>   

OK, will do thanks - I assume this'll force command based switching,
with it's associated crappy performance tho'...

I've ordered an 88SE9128 card (Hightpoint RocketRaid 620) as well, so
I'll be able to compare the two, as well as a sata_mv 88SX7042 as well.

Cheers,

Tim.
