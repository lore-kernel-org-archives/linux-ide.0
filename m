From: Jeff Garzik <jeff@garzik.org>
Subject: Re: AHCI link power management and surprise hotplug
Date: Thu, 19 Mar 2009 14:06:55 -0400
Message-ID: <49C289BF.8080602@garzik.org>
References: <49C22689.9050005@buttersideup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45141 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755673AbZCSSHE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Mar 2009 14:07:04 -0400
In-Reply-To: <49C22689.9050005@buttersideup.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@buttersideup.com>
Cc: linux-ide@vger.kernel.org, kristen.c.accardi@intel.com

Tim Small wrote:
> On a related topic, is there any way to do anything other than
> "surprise" removal with libata?  It'd be nice to put a drive to sleep
> (e.g. with "hdparm -Y"), and ensure that nothing comes along and causes
> the drive to be reset and spin the drive attached to that SATA port back
> up prior to a removal and reinsertion.
> 
> I'm assuming that physically unplugging a non-spinning drive is
> preferable to unplugging a spinning one from a drive longevity point of
> view (I use SATA drives as removable backup medium in some cases).


Unplugging the SATA cable is fine.  I wouldn't yank power while it's 
actively storing data, though.

	Jeff


