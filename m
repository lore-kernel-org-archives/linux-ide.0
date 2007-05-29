From: Daniel Drake <dsd@gentoo.org>
Subject: Re: Fixing halt/shutdown for libata spindown handling
Date: Tue, 29 May 2007 18:42:04 -0400
Message-ID: <465CAC3C.2030900@gentoo.org>
References: <46492931.4080700@gentoo.org> <46496D47.9010504@gmail.com> <464BACD5.3030003@gentoo.org> <464C747C.4060307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp121.iad.emailsrvr.com ([207.97.245.121]:58856 "EHLO
	smtp121.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbXE2Wn1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 May 2007 18:43:27 -0400
In-Reply-To: <464C747C.4060307@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> One thing I'm worried about is reimplement-suspend-resume (9666f400).
> It hasn't received testing in -mm and got merged into -rc, so it would
> be a good idea to wait for a week or two and see whether any regression
> is caused by the change before applying it to distro kernel.

Thanks for all your help. I included all these patches in a release made 
last week and have only received positive feedback so far.

For anyone else interested, here are the patches backported to 2.6.21. A 
couple needed small rediffs, there were a couple more than originally 
described in the earlier mails (patch dependencies etc), but if you 
apply the following as a whole it seems to work nicely:

http://dev.gentoo.org/~dsd/genpatches/trunk/2.6.21/2110_scsi-sd-printing.patch
http://dev.gentoo.org/~dsd/genpatches/trunk/2.6.21/2111_sd-start-stop.patch
http://dev.gentoo.org/~dsd/genpatches/trunk/2.6.21/2112_libata-suspend.patch
http://dev.gentoo.org/~dsd/genpatches/trunk/2.6.21/2113_libata-spindown-compat.patch
http://dev.gentoo.org/~dsd/genpatches/trunk/2.6.21/2114_libata-shutdown-warning.patch
http://dev.gentoo.org/~dsd/genpatches/trunk/2.6.21/2115_libata-spindown-status.patch
http://dev.gentoo.org/~dsd/genpatches/trunk/2.6.21/2116_libata-remove-spindown-compat.patch
http://dev.gentoo.org/~dsd/genpatches/trunk/2.6.21/2117_sata-via-suspend.patch
http://dev.gentoo.org/~dsd/genpatches/trunk/2.6.21/2118_scsi-constants.patch

These are all contained in
http://dev.gentoo.org/~dsd/genpatches/tarballs/genpatches-2.6.21-3.base.tar.bz2

Daniel
