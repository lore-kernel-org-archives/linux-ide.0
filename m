From: Jim Paris <jim@jtan.com>
Subject: Re: smartctl causing HSM violation on sata_nv, 2.6.18
Date: Thu, 28 Sep 2006 04:09:45 -0400
Message-ID: <20060928080945.GA17964@jim.sh>
References: <20060927183339.GA28174@jim.sh> <20060928065409.GI25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:57507 "EHLO neurosis.jim.sh")
	by vger.kernel.org with ESMTP id S1751025AbWI1IJy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Sep 2006 04:09:54 -0400
Content-Disposition: inline
In-Reply-To: <20060928065409.GI25800@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, smartmontools-support@lists.sourceforge.net

Hi Tejun,

Tejun Heo wrote:
> The following patch against smartmontools-5.36 converts it to use
> HDIO_DRIVE_TASK ioctl for AUTOSAVE and AUTO_OFFLINE which don't have
> the above issue.

This patch works like a charm.  Now "smartctl -S on" and "smartctl -o on"
works as expected on all of my SATA and IDE controllers.  Thank you!

-jim
