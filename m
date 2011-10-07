From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata_piix: make DVD Drive recognisable on systems with
 Intel Sandybridge chipsets(v2)
Date: Thu, 6 Oct 2011 22:18:38 -0700
Message-ID: <CAOS58YPBVDoN7sbPicJC34Y7bc2W0XKVumW8U1LViKPbHQ2gkQ@mail.gmail.com>
References: <1317959422-12860-1-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50524 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757329Ab1JGFSj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2011 01:18:39 -0400
Received: by vcbfk10 with SMTP id fk10so2813538vcb.19
        for <linux-ide@vger.kernel.org>; Thu, 06 Oct 2011 22:18:39 -0700 (PDT)
In-Reply-To: <1317959422-12860-1-git-send-email-ming.lei@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ming.lei@canonical.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, seth.heasley@intel.com, Alan Cox <alan@linux.intel.com>

Hello,

On Thu, Oct 6, 2011 at 8:50 PM, <ming.lei@canonical.com> wrote:
>
> From: Ming Lei <ming.lei@canonical.com>
>
> This quirk patch fixes one kind of bug inside some Intel Sandybridge
> chipsets, see reports from
>
> =A0 =A0 =A0 https://bugzilla.kernel.org/show_bug.cgi?id=3D40592.
>
> Many guys also have reported the problem before:
>
> =A0 =A0 =A0 =A0https://bugs.launchpad.net/bugs/737388
> =A0 =A0 =A0 =A0https://bugs.launchpad.net/bugs/794642
> =A0 =A0 =A0 =A0https://bugs.launchpad.net/bugs/782389
> =A0 =A0 =A0 =A0......
>
> With help from Tejun, the problem is found to be caused by 32bit PIO
> mode, so introduce the quirk patch to disable 32bit PIO on SATA piix
> for some Sandybridge CPT chipsets.
>
> Seth also tested the patch on all five affected chipsets
> (pci device ID: 0x1c00, 0x1c01, 0x1d00, 0x1e00, 0x1e01), and found
> the patch does fix the problem.
>
> Tested-by: Heasley, Seth <seth.heasley@intel.com>
> Cc: Alan Cox <alan@linux.intel.com>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> Acked-by: Tejun Heo <htejun@gmail.com>
> ---
> v2: avoid to use global flag

Yeap, v2 too looks good to me. Jeff, can you please cc
stable@kernel.org when committing? We definitely need this in -stable.

Thank you.

--
tejun
