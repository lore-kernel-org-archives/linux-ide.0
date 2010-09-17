From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCHSET #upstream] libata: reimplement LPM support
Date: Fri, 17 Sep 2010 02:06:49 -0400
Message-ID: <4C930579.3090507@garzik.org>
References: <1283356208-1884-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36781 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab0IQGG5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Sep 2010 02:06:57 -0400
Received: by qwh6 with SMTP id 6so1612901qwh.19
        for <linux-ide@vger.kernel.org>; Thu, 16 Sep 2010 23:06:56 -0700 (PDT)
In-Reply-To: <1283356208-1884-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On 09/01/2010 11:50 AM, Tejun Heo wrote:
> Hello,
>
> This patchset reimplement LPM support so that it's better integrated
> with the rest of libata and supports more than just ALPM.  After the
> patchset, DIPM works on ahci w/o ALPM support, host link of PMP can
> use both H/DIPM and fan-out links supports DIPM, and ata_piix w/ SIDPR
> also supports DIPM.
>
> Adding DIPM support for other controllers should be easy and DIPM
> actually works better than ALPM because DIPM implements sane timeout
> before entering powersave mode and thus doesn't hurt throughput like
> ALPM does.
>
> Tested with intel and JMB ahci's, ich8 ata_piix, SIMG and marvell
> PMPs.  SATA bus analyzer was used to verify links are actually
> entering and coming out of powersave mode.
>
> This patchset contains the following five patches
>
>   0001-libata-clean-up-lpm-related-symbols-and-sysfs-show-s.patch
>   0002-libata-implement-sata_link_scr_lpm-and-make-ata_dev_.patch
>   0003-libata-reimplement-link-power-management.patch
>   0004-libata-implement-LPM-support-for-port-multipliers.patch
>   0005-ata_piix-implement-LPM-support.patch
>
> and available in the folloing git tree
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git lpm

Had to hunt a bit for a good DIPM local test.

Looks good, applied, thanks!


