From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: aic94xx and the adaptec sata raid controller (aic-9410)
Date: Wed, 26 Aug 2009 15:12:41 -0400
Message-ID: <1251313961.14771.5.camel@mulgrave.site>
References: <4A956C59.2010709@globaldataguard.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45320 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761AbZHZTMq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Aug 2009 15:12:46 -0400
In-Reply-To: <4A956C59.2010709@globaldataguard.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kurt Newman <knewman@globaldataguard.com>
Cc: linux-ide@vger.kernel.org

On Wed, 2009-08-26 at 12:09 -0500, Kurt Newman wrote:
> Since the e-mail for Luben Tuikov, the original writer of the aic94xx
> driver, no longer works, I was hoping to ask someone a couple simple
> questions since it relates to the SATA subsystem.
> 
> If this is the incorrect mailing list, I'm very sorry.  Could you refer
> me to the proper one?  I'm at a dead end and hoping someone can point me
> in a better direction.
> 
> My question is:
> Does the aic94xx driver enable the use of the Adaptec SATA Raid
> functionality, such that, I'm able to see a single "raided" drive,
> instead of multiple, individual ones.

no ... the raid add on for the 94xx was Aic proprietary.   To get RAID
to work you need to use the linux md software RAID.

> Background information:
> Thus far, loading the aic94xx module simply says:
> "aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.2-2 loaded".
> 
> However, beyond that message and several /sys entries added, I'm unable
> to access the raid-1 "drive" created by the adaptec utility.  With or
> without that driver loaded, I still only have access to each individual
> drive (/dev/sda and /dev/sdb) using ata_piix.
> 
> I'm currently attempting to use kernel 2.6.18 (which is patched by
> RedHat to create kernel-2.6.18-128.7.1.el5).

Adaptec is supposed to use an industry standard RAID format, so it's
theoretically possible that MD might understand it, but I'd really
advise initiallising the volume from linux using mdadm and simply
dumping the adaptec tool ... that way you won't get any nasty
compatibility surprises.

James


