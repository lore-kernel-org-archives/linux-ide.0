From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH] libata: fix probe_ent alloc/free bugs
Date: Sat, 17 Feb 2007 12:09:30 -0600
Message-ID: <1171735771.3379.18.camel@mulgrave.il.steeleye.com>
References: <45D710E8.3090104@gmail.com>
	 <1171725374.3379.15.camel@mulgrave.il.steeleye.com>
	 <45D73A55.90008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <45D73A55.90008@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, SCSI Mailing List <linux-scsi@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Sun, 2007-02-18 at 02:24 +0900, Tejun Heo wrote:
> ata_probe_ent_alloc() had a temporary hack such that devm_kzalloc()
> was used for allocation if devres had been previously initialized on
> the device; otherwise, plain kzalloc() was used.  This was to make the
> code useable from both the old and devres-aware libata drivers during
> transition.  This hack made ata_sas_port_alloc() unable to determine
> how the probe_ent is allocated, causing double free in some cases.
> 
> Remove the now-unneeded hack and make ata_sas_port_alloc() use
> devm_kfree().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: James Bottomley <James.Bottomley@SteelEye.com>
> ---
> James, thanks for the diagnosis and please ack if this fixes the
> problem.

Yes, it fixes all the problems.

James


