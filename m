From: Andy Warner <andyw@pobox.com>
Subject: Re: libata & scsi rescan.
Date: Fri, 1 Oct 2004 14:12:44 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041001141244.B23006@florence.linkmargin.com>
References: <20041001123951.A23006@florence.linkmargin.com> <415DA2C0.3060600@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-04.rdc-kc.rr.com ([24.94.166.116]:34196 "EHLO
	ms-smtp-04.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S266173AbUJATOc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Oct 2004 15:14:32 -0400
Content-Disposition: inline
In-Reply-To: <415DA2C0.3060600@pobox.com>; from jgarzik@pobox.com on Fri, Oct 01, 2004 at 02:32:32PM -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> [...]
> I don't see why rescan is needed, since SATA hardware supports hotplug.

OK - but at present, I can remove a quiescent drive
and /proc/scsi/scsi still serves up the cached info
about the drive. It seems there are at least a
couple of dots left that I could/should join.

Since they appear as scsi devices, I sort of expected
to be able to implement "scsi add-single-device n" and
"scsi remove-single-device n", but for all I know this
may be out of fashion or otherwise useless these days.

I can see how I may require HBA-driver-level
hooks to respond to phys going on/off-line, or
some such mechanism.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
