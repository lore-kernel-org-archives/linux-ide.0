From: Nicolas STRANSKY <Nico@stransky.cx>
Subject: Re: libata-tj and SMART
Date: Wed, 17 May 2006 23:15:43 +0200
Message-ID: <e4g3or$jbm$1@sea.gmane.org>
References: <e4b02t$e9b$1@sea.gmane.org> <44690B0F.90200@gmail.com> <e4bvsb$s9m$1@sea.gmane.org> <4469893A.10901@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060906090905090803080906"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:13505 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751130AbWEQVRB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 May 2006 17:17:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FgTNL-0000xC-Rr
	for linux-ide@vger.kernel.org; Wed, 17 May 2006 23:16:12 +0200
Received: from fbx.stransky.cx ([82.67.244.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 17 May 2006 23:16:11 +0200
Received: from Nico by fbx.stransky.cx with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 17 May 2006 23:16:11 +0200
In-Reply-To: <4469893A.10901@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------060906090905090803080906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Le 05/16/2006 10:11 AM, Tejun Heo a écrit :

Hi,

> If you've got some time though, I'd like to see what's really going on.
>  Can you modify #undef ATA_DEBUT to #define ATA_DEBUG in
> include/linux/libata.h and post the kernel messages after issuing above
> command?  Be warned that it will produce a LOT of messages while booting
> if you're using SATA disks for your system, and it can considerably slow
> down booting.

Here it is.
I first did a "smartctl -d ata -a -o on /dev/sda" and then a "smartctl
-d ata -a -S on /dev/sda" which are the two commands triggering errors
on this drive with you patch.

BTW the system is running very well with your patch apart from this
smartctl problem.

Regards,
-- 
Nico
Peut-être découvrirons-nous un jour que la même logique est à l'oeuvre
dans la pensée mythique et dans la pensée scientifique, et que l'homme
a toujours pensé aussi bien.
	-+- Claude Lévi-Strauss, Anthropologie structurale -+-

--------------060906090905090803080906
Content-Type: application/x-bzip;
 name="kern.log.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="kern.log.bz2"

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
agh/4u5IpwoSFOMyx+A=
--------------060906090905090803080906--

