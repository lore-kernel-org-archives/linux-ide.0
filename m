From: Bryan O'Sullivan <bos@serpentine.com>
Subject: Re: Additions to libata patch archive
Date: Tue, 04 Oct 2005 22:09:34 -0700
Message-ID: <1128488974.428.16.camel@camp4.serpentine.com>
References: <434352E4.8090002@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hierophant.serpentine.com ([66.92.13.71]:39062 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S932278AbVJEFJf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Oct 2005 01:09:35 -0400
In-Reply-To: <434352E4.8090002@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Wed, 2005-10-05 at 00:13 -0400, Jeff Garzik wrote:

> http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/archive/2.6.14-rc3-sil24-original.patch.bz2
> Original Silicon Image 3124 driver contributed by Silicon Image.  Since 
> there is a newer driver, this is merely provided as a reference.

In case anyone should care, the original SiImage driver oopses during
boot with recent kernels.

The reason I know this is that I just tried booting 2.6.14-rc3 with the
0.10 (SiImage) driver.  It appears to contain port multiplier support,
which I need.  Tejun's rewrite doesn't, and SiImage wants me to sign an
NDA to get a more recent driver of theirs that has port multiplier
support.

	<b

