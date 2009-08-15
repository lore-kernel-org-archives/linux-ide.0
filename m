From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: Export AHCI capabilities
Date: Sat, 15 Aug 2009 17:07:18 -0400
Message-ID: <4A872386.4080908@pobox.com>
References: <1247854427-3315-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53141 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462AbZHOVHV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Aug 2009 17:07:21 -0400
In-Reply-To: <1247854427-3315-1-git-send-email-mjg@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Matthew Garrett wrote:
> AHCI exports various capability bits that may be of interest to userspace
> such as whether the BIOS claims a port is hotpluggable or eSATA. Providing
> these via sysfs along with the version of the AHCI spec implemented by
> the host allows userspace to make policy decisions for things like ALPM.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>

I would prefer a better-yet-more-general interface, but I don't think 
one will appear anytime soon, so...

applied



