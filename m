From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: aic94xx and the adaptec sata raid controller (aic-9410)
Date: Wed, 26 Aug 2009 20:46:39 -0600
Message-ID: <4A95F38F.9060509@gmail.com>
References: <4A956C59.2010709@globaldataguard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f205.google.com ([209.85.217.205]:38006 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829AbZH0Cql (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Aug 2009 22:46:41 -0400
Received: by gxk1 with SMTP id 1so825029gxk.17
        for <linux-ide@vger.kernel.org>; Wed, 26 Aug 2009 19:46:42 -0700 (PDT)
In-Reply-To: <4A956C59.2010709@globaldataguard.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kurt Newman <knewman@globaldataguard.com>
Cc: linux-ide@vger.kernel.org

On 08/26/2009 11:09 AM, Kurt Newman wrote:
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
>
> Background information:
> Thus far, loading the aic94xx module simply says:
> "aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.2-2 loaded".
>
> However, beyond that message and several /sys entries added, I'm unable
> to access the raid-1 "drive" created by the adaptec utility.  With or
> without that driver loaded, I still only have access to each individual
> drive (/dev/sda and /dev/sdb) using ata_piix.

ata_piix will be for an Intel integrated chipset SATA controller, not an 
aic94xx. Are you sure the drives are actually hooked up through the 
Adaptec controller?

>
> I'm currently attempting to use kernel 2.6.18 (which is patched by
> RedHat to create kernel-2.6.18-128.7.1.el5).
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

