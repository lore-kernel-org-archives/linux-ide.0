From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Regression: SATA disk double spin-off during hibernation on hp nx6325
Date: Sat, 6 Sep 2008 01:18:37 +0200
Message-ID: <200809060118.38493.rjw@sisk.pl>
References: <200808290002.55026.rjw@sisk.pl> <200809041605.22055.rjw@sisk.pl> <200809060025.20039.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34284 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047AbYIEXO0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Sep 2008 19:14:26 -0400
In-Reply-To: <200809060025.20039.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org, trenn@suse.de, htejun@gmail.com, hancockr@shaw.ca, linux-kernel@vger.kernel.org, Maciej Rutecki <maciej.rutecki@gmail.com>

On Saturday, 6 of September 2008, Frans Pop wrote:
> On Thursday 04 September 2008, Rafael J. Wysocki wrote:
> > I have uploaded a new version of the patch into the Bugzilla:
> > http://bugzilla.kernel.org/attachment.cgi?id=17618&action=view
> 
> This version does not work for me, possibly because I use a different hard 
> disk driver (ata_piix instead of sata_sil)?
> 
> I've seen there are later versions of the patch, but as the comments 
> mention that 2510p was removed from those I haven't tested them.
> 
> > (also please attach dmesg output to the Bugzilla entry)
> 
> Added.

Thanks.  There's a new patch for you to test in there already. :-)

Rafael
