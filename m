From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: hdparm-8.2 now available
Date: Wed, 20 Feb 2008 10:32:50 -0500
Message-ID: <87f94c370802200732g594a4f01jeba7d05579625ee2@mail.gmail.com>
References: <47BA21F0.90405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:18897 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932798AbYBTPcv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Feb 2008 10:32:51 -0500
Received: by an-out-0708.google.com with SMTP id d31so635247and.103
        for <linux-ide@vger.kernel.org>; Wed, 20 Feb 2008 07:32:50 -0800 (PST)
In-Reply-To: <47BA21F0.90405@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, ballen@gravity.phys.uwm.edu, Ric Wheeler <ric@emc.com>

Mark,

What kernel level is needed to support the new -N arg?

Tried it on a Suse 2.6.22 kernel (possibly not patched with all the
current security updates).

Failed with:

The Running Kernel Lack CONFIG_IDE_TASK_IOCTL Support.

Thanks
Greg

On Mon, Feb 18, 2008 at 7:25 PM, Mark Lord <mlord@pobox.com> wrote:
> hdparm for SATA/PATA has now been updated to version 8.2.
>
>  Upgrading is strongly recommended for all users.
>  This version fixes several bugs in earlier 7.x/8.x releases
>  that could cause issues when advanced features are attempted
>  on devices being driven by the old drivers/ide subsystem.
>
>  libata devices were unaffected, but drivers/ide devices could
>  misbehave or even be corrupted by some operations.
>
>  hdparm-8.2 is available at http://sourceforge.net/projects/hdparm/
>
>  Upgrading from any earlier 7.x or 8.x version
>  is strongly recommended for all users.
>
>  Cheers
>  --
>  Mark Lord
>  Real-Time Remedies Inc.
>  mlord@pobox.com
>  -
>  To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
