From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata patches in 2.6.7bk6 Hang Maxtor on SP bridge
Date: Tue, 29 Jun 2004 04:25:14 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040629082514.GB19267@havoc.gtf.org>
References: <40E096B6.8090108@hbahr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([216.162.42.101]:41399 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265540AbUF2IZv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jun 2004 04:25:51 -0400
Content-Disposition: inline
In-Reply-To: <40E096B6.8090108@hbahr.org>
List-Id: linux-ide@vger.kernel.org
To: hab <hab@hbahr.org>
Cc: linux-ide@vger.kernel.org

On Mon, Jun 28, 2004 at 05:07:50PM -0500, hab wrote:
> Sir
>    I resolved problem by baking out scsi portion of patches, athough
> some general configs such as FC2 development still introduce
> the same problem as identified in the attached message.

Use sata_sil not siimage.  And certainly not _both_ drivers.

	Jeff


