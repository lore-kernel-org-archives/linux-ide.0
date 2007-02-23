From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] remove duplicate ids from ata_piix
Date: Fri, 23 Feb 2007 05:49:41 -0500
Message-ID: <45DEC6C5.6040901@garzik.org>
References: <20070126021228.GA3444@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45018 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932238AbXBWKtp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Feb 2007 05:49:45 -0500
In-Reply-To: <20070126021228.GA3444@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, kay.sievers@suse.de

Greg KH wrote:
> From: Greg Kroah-Hartman <gregkh@suse.de>
> 
> It seems that the ata_piix driver has two duplicate ids, one of them
> with a different 'private' field in it, which was never being used due
> to the match for the device happening on an earlier entry.
> 
> This patch removes the duplicates, if this is the correct thing to do in
> this case for the ICH5 device or not, I'll leave to you :)
> 
> This duplication was pointed out to me by Kay Sievers <kay.sievers@suse.de>
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

manually applied the proper fix, this for spotting this


